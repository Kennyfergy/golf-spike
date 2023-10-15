const express = require("express");
const router = express.Router();
const pool = require("../modules/pool");

router.get("/users/:id", async (req, res) => {
  const userId = req.params.id;
  try {
    const result = await pool.query("SELECT * FROM users WHERE id = $1", [
      userId,
    ]);
    res.json(result.rows[0]);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Internal server error" });
  }
});

module.exports = router;
