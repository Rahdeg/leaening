const express = require("express");
const path = require("path");

const userRoutes = require("./routes/userRoutes");
const goalRoutes = require("./routes/goalRoutes");
const adminRoutes = require("./routes/adminRoutes");

const app = express();

app.set("view engine", "pug");
app.set("views", path.join(__dirname, "views"));

app.use(express.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, "public")));

app.get("/", (req, res) => {
  res.render("index", { title: "SAVIFY Home" });
});

app.use("/", userRoutes);
app.use("/goals", goalRoutes);
app.use("/admin", adminRoutes);

const PORT = 3000;
app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});
