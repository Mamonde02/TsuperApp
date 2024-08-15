//main app
var app = require("./app");

// server
//var port = process.env.PORT || 8084;
var port = 8089

app.listen(port, function(){
  console.log("App listening on port " + port);
});

require('./routes')(app);