//***************
// IMPORTS
//***************
var commonlib = require("../common");


//***********************
// OTHER FUNCTIONS
//***********************
function printQuestionMarks(num) {
  var arr = [];
  for (var i = 0; i < num; i++) {
    arr.push('?');
  }
  return arr.toString();
}

function objToSql(ob) {
  var arr = [];
  for (var key in ob) {
    if (ob.hasOwnProperty(key)) {
      arr.push(key + '=' + ob[key]);
    }
  }
  return arr.toString();
}


//***********************
// MAIN FUNCTIONS
//***********************
var crud = {
    //param:
    //  pool - pool from mysqlcontroller.js
    //  querystring - string query with ?
    //  querydata - array of data from ? of query string
    //  querytag - function name + reason for query
    // result:
    //  error - connection error
    //  result - array of result
  selectAllQuery: function(pool, querystring, querydata, querytag, callback) {
      var errormsge = {};

      pool.getConnection(function(err,connection){
          if (err) {
            errormsge = {
                querydata: querydata,
                request: querytag + " "+ err,
            };
            // throw error logic here...
            commonlib.writeErrorLogV2("mysqlcontroller.js","crud > selectAllQuery - 1", errormsge);
            callback("error");
          }

          connection.query(querystring, querydata, function(err, result) {
              connection.release();
              connection.destroy();
              if (err) {
                errormsge = {
                    querydata: querydata,
                    request: querytag + " "+ err,
                };
                commonlib.writeErrorLogV2("mysqlcontroller.js","crud > selectAllQuery - 2", errormsge);
                callback("error");
              }
              else{
                  callback(result);
              }
          });

          connection.on('error', function(err) {
            connection.release();
            connection.destroy();
            errormsge = {
                querydata: querydata,
                request: querytag + " "+ err,
            };
            commonlib.writeErrorLogV2("mysqlcontroller.js","crud > selectAllQuery - 3", errormsge);
            callback("error");
          });

      });
  },
// selectAllQuery: function(pool, querystring, querydata, querytag, callback) {
//     var errormsge = {};

//     pool.getConnection(function(err, connection) {
//         if (err) {
//             errormsge = {
//                 querydata: querydata,
//                 request: querytag + " " + err,
//             };
//             commonlib.writeErrorLogV2("mysqlcontroller.js", "crud > selectAllQuery - 1", errormsge);
//             callback("error");
//             return; // Stop execution on error
//         }

//         try {
//             connection.query(querystring, querydata, function(err, result) {
//                 if (err) {
//                     errormsge = {
//                         querydata: querydata,
//                         request: querytag + " " + err,
//                     };
//                     commonlib.writeErrorLogV2("mysqlcontroller.js", "crud > selectAllQuery - 2", errormsge);
//                     callback("error");
//                 } else {
//                     callback(result);
//                 }
//             });

//             connection.on('error', function(err) {
//                 errormsge = {
//                     querydata: querydata,
//                     request: querytag + " " + err,
//                 };
//                 commonlib.writeErrorLogV2("mysqlcontroller.js", "crud > selectAllQuery - 3", errormsge);
//                 callback("error");
//             });
//         } finally {
//             connection.release();
//             connection.destroy();
//         }
//     });
// },

    //param:
    //  pool - pool from mysqlcontroller.js
    //  querystring - string query with ?
    //  querydata - array of data from ? of query string
    //  querytag - function name + reason for query
    // result:
    //  error - connection error
    //  true - successfully insert
//   insertQuery: function(pool, querystring, querydata, querytag, callback) {
//       var errormsge = "";

//       pool.getConnection(function(err,connection){
//         if (err) {
//             errormsge = {
//                 querydata: querydata,
//                 request: querytag + " "+ err,
//             };
//             commonlib.writeErrorLogV2("mysqlcontroller.js","crud > insertQuery - 1", errormsge);
//             callback("error");
//         }

//         connection.query(querystring, querydata, function(err, result) {
//             connection.release();
//             connection.destroy();
//             if (err) {
//                 errormsge = {
//                     querydata: querydata,
//                     request: querytag + " "+ err,
//                 };
//                 commonlib.writeErrorLogV2("mysqlcontroller.js","crud > insertQuery - 2", errormsge);
//                 callback("error");
//             }
//             else{ callback("true"); }
//         });

//         connection.on('error', function(err) {
//             connection.release();
//             connection.destroy();
//             errormsge = {
//                 querydata: querydata,
//                 request: querytag + " "+ err,
//             };
//             commonlib.writeErrorLogV2("mysqlcontroller.js","crud > insertQuery - 3", errormsge);
//             callback("error");
//         });
//     });
//   },

insertQuery: function (pool, querystring, querydata, querytag, callback) {
    var errormsge = "";

    pool.getConnection(function (err, connection) {
        if (err) {
            errormsge = {
                querydata: querydata,
                request: querytag + " " + err,
            };
            commonlib.writeErrorLogV2("mysqlcontroller.js", "crud > insertQuery - 1", errormsge);
            callback("error");
            return; // ✅ Stop execution on error
        }

        connection.query(querystring, querydata, function (err, result) {
            connection.release(); // ✅ Properly releasing the connection
            
            if (err) {
                errormsge = {
                    querydata: querydata,
                    request: querytag + " " + err,
                };
                commonlib.writeErrorLogV2("mysqlcontroller.js", "crud > insertQuery - 2", errormsge);
                callback("error");
                return; // ✅ Stop execution on error
            } else {
                callback("true");
            }
        });

        connection.on("error", function (err) {
            errormsge = {
                querydata: querydata,
                request: querytag + " " + err,
            };
            commonlib.writeErrorLogV2("mysqlcontroller.js", "crud > insertQuery - 3", errormsge);
            callback("error");
            return; // ✅ Stop execution on error
        });
    });
},


    //param:
    //  pool - pool from mysqlcontroller.js
    //  querystring - string query with ?
    //  querydata - array of data from ? of query string
    //  querytag - function name + reason for query
    // result:
    //  error - connection error
    //  true - successfully updated
  updateQuery: function(pool, querystring, querydata, querytag, callback) {
    var errormsge = "";

    pool.getConnection(function(err,connection){
        if (err) {
            errormsge = {
                querydata: querydata,
                request: querytag + " "+ err,
            };
            commonlib.writeErrorLogV2("mysqlcontroller.js","crud > updateQuery - 1", errormsge);
            callback("error");
        }

        connection.query(querystring, querydata, function(err, result) {
            connection.release();
            connection.destroy();
            if (err) {
                errormsge = {
                    querydata: querydata,
                    request: querytag + " "+ err,
                };
                commonlib.writeErrorLogV2("mysqlcontroller.js","crud > updateQuery - 2", errormsge);
                callback("error");
            } else if(result.affectedRows>0){
                callback("true");
            }
            else{ callback("false"); }
        });

        connection.on('error', function(err) {
            connection.release();
            connection.destroy();
            errormsge = {
                querydata: querydata,
                request: querytag + " "+ err,
            };
            commonlib.writeErrorLogV2("mysqlcontroller.js","crud > updateQuery - 3", errormsge);
            callback("error");
        });

      });
  },

    //param:
    //  pool - pool from mysqlcontroller.js
    //  querystring - string query with ?
    //  querydata - array of data from ? of query string
    //  querytag - function name + reason for query
    // result:
    //  error - connection error
    //  true - successfully deleted

  deleteQuery: function(pool, querystring, querydata, querytag, callback) {
      var errormsge = "";

      pool.getConnection(function(err,connection){
        if (err) {
            errormsge = {
                querydata: querydata,
                request: querytag + " "+ err,
            };
            commonlib.writeErrorLogV2("mysqlcontroller.js","crud > deleteQuery - 1", errormsge);
            callback("error");
        }

        connection.query(querystring, querydata, function(err, result) {
            connection.release();
            connection.destroy();
            if (err) {
                errormsge = {
                    querydata: querydata,
                    request: querytag + " "+ err,
                };
                commonlib.writeErrorLogV2("mysqlcontroller.js","crud > deleteQuery - 2", errormsge);
                callback("error");
            }
            else{ callback("true"); }
        });

        connection.on('error', function(err) {
            connection.release();
            connection.destroy();
            errormsge = {
                querydata: querydata,
                request: querytag + " "+ err,
            };
            commonlib.writeErrorLogV2("mysqlcontroller.js","crud > deleteQuery - 3", errormsge);
            callback("error");
        });
    });
  }
};


module.exports = crud;
