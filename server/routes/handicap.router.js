const express = require("express");
const router = express.Router();
const pool = require("../modules/pool");

router.get("/calculate/:userId", async (req, res) => {
  const userId = req.params.userId;
  try {
    // Fetch last 20 rounds of golf scores, related course data, and user gender from the database
    const result = await pool.query(
      `
      SELECT 
        ur.front_9_score, ur.back_9_score, 
        uc.men_course_rating, uc.men_course_slope, 
        uc.women_course_rating, uc.women_course_slope,
        u.is_male
      FROM user_rounds ur 
      JOIN user_courses uc ON ur.course_id = uc.id
      JOIN users u ON ur.user_id = u.id
      WHERE ur.user_id = $1 
      ORDER BY ur.date DESC 
      LIMIT 20`,
      [userId]
    );

    // Calculate score differentials considering gender
    const scoreDifferentials = result.rows.map((row) => {
      const totalScore = row.front_9_score + row.back_9_score;
      const courseRating = row.is_male
        ? row.men_course_rating
        : row.women_course_rating;
      const courseSlope = row.is_male
        ? row.men_course_slope
        : row.women_course_slope;
      const scoreDifferential =
        ((totalScore - courseRating) * 113) / courseSlope;
      return scoreDifferential;
    });

    // Sort score differentials, select the lowest 8, and calculate average
    const bestDifferentials = scoreDifferentials
      .sort((a, b) => a - b)
      .slice(0, 8);
    const avgDifferential =
      bestDifferentials.reduce((a, b) => a + b, 0) / bestDifferentials.length;

    // Calculate and send the handicap index
    const handicapIndex = avgDifferential * 0.96;
    res.json({ handicap: handicapIndex.toFixed(1) });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Internal server error" });
  }
});

module.exports = router;
