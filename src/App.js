import React, { useEffect, useState } from "react";
import { useDispatch, useSelector } from "react-redux";
import Sidebar from "./sidebar";
import "./App.css";

function App() {
  const dispatch = useDispatch();
  const handicapIndex = useSelector((state) => state.handicapIndex);
  const [sidebarOpen, setSidebarOpen] = useState(false); // State to manage sidebar

  useEffect(() => {
    dispatch({
      type: "FETCH_HANDICAP_REQUEST",
      payload: { userId: "3" },
    });
  }, [dispatch]);

  return (
    <div className="App">
      <header className="App-header">
        <h1>Golf Spike</h1>
        <button onClick={() => setSidebarOpen(true)}>Open Sidebar</button>{" "}
        {/* Button to open sidebar */}
        <div className="card">
          <h2>User Handicap Index</h2>
          <h3>{handicapIndex}</h3>
        </div>
      </header>
      <Sidebar open={sidebarOpen} onClose={() => setSidebarOpen(false)} />{" "}
      {/* Sidebar Component */}
    </div>
  );
}

export default App;
