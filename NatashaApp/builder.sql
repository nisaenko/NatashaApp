CREATE 
    TABLE Builders (idx INTEGER NOT NULL DEFAULT 0 PRIMARY KEY AUTOINCREMENT,
        buildername Varchar DEFAULT NULL,
        address Varchar DEFAULT NULL,
        phone Varchar DEFAULT NULL,
        price Varchar DEFAULT NULL,
        picture BLOB DEFAULT NULL);
