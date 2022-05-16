const childProcess = require('child_process')
const formidable = require('formidable');
const fs = require('fs-extra');
const express = require('express');
const util = require('util');
const bodyParser = require("body-parser");
const db = require('./Database');
const path = require('path');

const app = express();
const port = '8080';
const exec = util.promisify(childProcess.exec);

app.use(bodyParser.json())
app.use(express.urlencoded({ extended: true }))

//create router to listen port
app.listen(port, async function (){
    await db.connect();
    console.log("Database connected")
    console.log("Running at " + port);
})

//Use POST method to process user's input
app.post('/fileupload', async (req, res) => {

    console.log("Received request");
    var filename = String(Math.random());
    var filePath = '/Users/jackielai/Desktop/Test/' + filename;
    var outputFilePath = '/Users/jackielai/Desktop/output_usdz/' + filename;
    var exe = '/Users/jackielai/Desktop/phototest/Products/usr/local/bin/HelloPhotogrammetry';

    await fs.mkdirp(filePath);
    await fs.mkdirp(outputFilePath);

    var form = new formidable.IncomingForm({
        multiples: true,
        uploadDir: filePath,
        keepExtensions: true,
        maxFileSize: 500 * 1024 * 1024 * 8 * 1024
    });
    //Parse form to receive footage for generate an 3D object
    form.parse(req, async function (err, fields, files) {
        if (err) throw err;
        let filesLength = files.image.length !== undefined ? files.image.length : 1;
        let userID = fields.userID;
        let modelName = fields.modelName;
        let location = await insertRecord(userID, filename, modelName, filesLength);
        let start = new Date().getTime();
        let result = await exec(exe + " " + filePath + " " + outputFilePath + "/output.usdz");
        res.end();
        let end = new Date().getTime();
        if(result.stdout.includes("error")){
            updateProgress(location, 2, end - start, result.stderr);
        }else{
            updateProgress(location, 1, end - start, null);
        }
        fs.remove(filePath, err => {
            if (err){
                console.log(err);
            }else{
                console.log(filePath + " deleted");
            }
        })

         console.log(result);
        //return file to client
        // res.redirect('/download/?file=' + outputFilePath + "/output.usdz");
    });
});

//redirect to download page for download to output file
app.get('/download', (req,res)=>{
    console.log(req.query.file);
    let fileLocation = req.query.file;
    // res.download((req.query.file));
    let path = "/Users/jackielai/Desktop/output_usdz/" + fileLocation + "/output.usdz";
    try{
        if(fs.pathExistsSync(path)){
            console.log(path);
            res.download(path);
        }else{
            console.log("Model not exist");
            res.end();
        }
    }catch(err){
        console.log(err);
        res.end();
    }
})

app.post('/query_user',async (req, res) => {
    //let deviceID = req.body.deviceID;
    //let result = await db.connection.execute(`SELECT * FROM 3dscannerapplication.model WHERE owner = '${deviceID}'`)
    let userID = req.body.userID;
    if(userID === undefined){
        let serverResponse = {
            "code" : 3,
            "message": "Unable receive user ID",
            "trans": []
        }
        res.end(JSON.stringify(serverResponse));
    }
    console.log(userID);
    const response = await db.connection.execute(`SELECT * FROM 3dscannerapplication.model WHERE (userID = '${userID}') ORDER BY tranID DESC;`);
    //console.log(deviceID);
    // let output = JSON.stringify(response[0]);
    let serverResponse = {
        "code" : 0,
        "message": "",
        "trans": response[0]
    }
    console.log(serverResponse)
    res.end(JSON.stringify(serverResponse));
})

app.post("/query_model", async (req, res) => {
    let tranID = req.body.tranID;
    if(tranID != undefined){
        let response = await db.connection.execute(`SELECT * FROM 3dscannerapplication.model WHERE (tranID = '${tranID}')`);
        let location = response[0][0].location;
        let filePath = '/Users/jackielai/Desktop/output_usdz/' + location + '/output.usdz';
    }else{
        console.log("Can't find model")
    }
    res.end();
})

//direct to form page to wait user's input
app.get("/", (req, res) => {
    res.writeHead(200, {'Content-Type': 'text/html'});
    res.write('<form action="fileupload" method="post" enctype="multipart/form-data">');
    res.write('<input type="file" multiple name="image[]"><br>');
    res.write('<input type="text" name="modelName"><br>');
    res.write('<input type="text" name="userID"><br>')
    res.write('<input type="submit">');
    res.write('</form>');
    return res.end();
});

app.post("/delete_model", async (req, res) =>{
    let tranID = req.body.tranID;
    let serverResponse;

    let response = await db.connection.execute(`SELECT location FROM 3dscannerapplication.model WHERE (tranID = '${tranID}')`);
    let fileLocation = response[0][0].location;
    console.log(fileLocation);

    let path = "/Users/jackielai/Desktop/output_usdz/" + fileLocation;

    fs.remove(path, err => {
        if (err){
            console.log(err);
        }else{
            console.log(path + " deleted");
        }
    })

    console.log(tranID);
    if(tranID !== undefined){
        //DELETE FROM `3dscannerapplication`.`model` WHERE (`tranID` = '73');
        response = await db.connection.execute(`DELETE FROM 3dscannerapplication.model WHERE (tranID = ${tranID})`);
        serverResponse = {
            code: 0,
            message: "Deleted Model"
        }
        console.log(response);
    }else{
        serverResponse = {
            code: 1,
            message: "Can't receive transaction ID"
        }
    }




    res.end(JSON.stringify(serverResponse));
})

app.get((req, res) => {
    res.write("Something wrong");
    res.end();
});

async function insertRecord(userID, fileName, modelName, filesLength){
    let today = new Date();
    let dd = String(today.getDate()).padStart(2, '0');
    let mm = String(today.getMonth() + 1).padStart(2, '0');
    let yyyy = today.getFullYear();
    today = mm + '/' + dd + '/' + yyyy;
    let time = new Date().toLocaleTimeString();
    let query = await db.connection.execute(`INSERT INTO 3dscannerapplication.model (date, location, status, userID, modelName, time, imageLength) VALUES ('${today}', '${fileName}', 0 , '${userID}', '${modelName}', '${time}', ${filesLength})`);
    console.log(`Query: ${query[0].insertId}`);
    return query[0].insertId;
}

function updateProgress(location, status, rawProcessTime, errorMessage){
    let hours = 0;
    let minutes = 0;
    let seconds;
    let totalProcessTime = "";

    rawProcessTime = rawProcessTime / 1000;

    while(rawProcessTime > 3600){
        hours++;
        rawProcessTime -= 3600;
    }

    while(rawProcessTime > 60){
        minutes++;
        rawProcessTime -= 60;
    }

    seconds = Math.round(rawProcessTime);

    if(hours > 0){
        totalProcessTime += `${hours} hr `;
    }
    if(minutes > 0){
        totalProcessTime += `${minutes} min `;
    }
    totalProcessTime += `${seconds} sec`;

    console.log(errorMessage);
    if(errorMessage == null){
        let query = db.connection.execute(`UPDATE 3dscannerapplication.model SET status = ${status}, processTime = '${totalProcessTime}' WHERE (tranID = '${location}')`);
    }else{
        let query = db.connection.execute(`UPDATE 3dscannerapplication.model SET status = ${status}, processTime = '${totalProcessTime}', errorMessage = '${errorMessage}' WHERE (tranID = '${location}')`);
    }
}