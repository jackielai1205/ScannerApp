let mysql = require('mysql2/promise');

const db = {
    connection: null,
    connect: async () => {
        db.connection = await mysql.createConnection({
            host: "localhost",
            user: "root",
            password: "root",
            database: "3dscannerapplication"
        });
    }
};

module.exports = db;