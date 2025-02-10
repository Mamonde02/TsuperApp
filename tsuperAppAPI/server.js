//main app
var app = require("./app");

// server
//var port = process.env.PORT || 8084;
var port = 8089

app.listen(port, function () {
  console.log("App listening on port " + port);
});

app.get("/", (req, res) => {
  res.send("Welcome to Tsuper App API!!:)");
});

app.get("/tsuper", (req, res) => {
  res.send("TESTING Tsuper App API!!:)");
});


require('./routes')(app);