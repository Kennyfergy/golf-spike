const express = require("express");
const app = express();
const bodyParser = require("body-parser");
const handicapRouter = require("./routes/handicap.router.js");
// const roundsRouter = require("./routes/rounds.router.js");
const port = process.env.PORT || 5000;

/** ---------- MIDDLEWARE ---------- **/
app.use(bodyParser.json()); // needed for angular requests
app.use(express.static("build"));

/** ---------- ROUTES ---------- **/

app.use("/api/handicap", handicapRouter);
// app.use("/api/rounds", roundsRouter);

/** ---------- START SERVER ---------- **/
app.listen(port, function () {
  console.log("Listening on port: ", port);
});
