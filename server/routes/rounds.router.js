const express = require("express");
const router = express.Router();
const pool = require("../modules/pool");

//next step grabbing all user rounds played
// router.get("/user/totalRounds/:id", async (req, res) => {
//   try {
//     const userId = req.params.id;
//     const { rows } = await pool.query(
//       `
//       SELECT COUNT(*) as total_rounds
//       FROM user_rounds
//       WHERE user_id = $1;
//     `,
//       [userId]
//     );
//     res.send({ totalRounds: rows[0].total_rounds });
//   } catch (err) {
//     console.error(err);
//     res.status(500).json({ error: "Failed to fetch total rounds." });
//   }
// });
//SELECT COUNT(id) FROM user_rounds WHERE user_id = [USER_ID];

// app.get('/api/user/:userId/rounds-count', async (req, res) => {
//     try {
//         const { userId } = req.params;
//         const result = await db.query('SELECT COUNT(id) as count FROM user_rounds WHERE user_id = $1', [userId]);
//         res.send({ count: result.rows[0].count });
//     } catch (err) {
//         res.status(500).json({ error: 'Failed to fetch data' });
//     }
// });
