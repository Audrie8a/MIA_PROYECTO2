const oracledb= require("oracledb");

credentials={
    user: "audrie8a",
    password: "audrie8a",
    connectString:"172.17.0.2/ORCLCDB.localdomain"

}

try {
    oracledb.initOracleClient({libDir: '/opt/oracle/instantclient_21_1'});
} catch (err) {
    console.error('No se puede conectar al cliente!', err);
}


async function Open(sql, binds, autoCommit) {
    let cnn = await oracledb.getConnection(credentials);
    let result = await cnn.execute(sql, binds, { autoCommit });
    cnn.release();
    return result;
}

exports.Open = Open;