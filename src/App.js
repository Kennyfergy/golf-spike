import React, { useEffect, useState } from "react";
import axios from "axios";

function App() {
  const [handicap, setHandicap] = useState(null);

  useEffect(() => {
    const userId = 1;

    axios
      .get(`/api/handicap/calculate/${userId}`)

      .then((response) => {
        setHandicap(response.data.user_handicap);
        console.log(response.data);
      })
      .catch((error) => {
        console.error("Error fetching data: ", error);
      });
  }, []);

  return (
    <div className="App">
      <header className="App-header">
        <h1>Golf Spike</h1>
        {handicap ? <p>User's Handicap: {handicap}</p> : <p>Loading...</p>}
      </header>
    </div>
  );
}

export default App;
