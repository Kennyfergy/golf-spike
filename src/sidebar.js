import React from "react";
import Drawer from "@mui/material/Drawer";
import List from "@mui/material/List";
import ListItem from "@mui/material/ListItem";
import ListItemText from "@mui/material/ListItemText";

export default function Sidebar({ open, onClose }) {
  return (
    <Drawer
      open={open}
      onClose={onClose}
      PaperProps={{
        style: { width: "300px" },
      }}
    >
      <List>
        {["Home", "Profile", "Settings"].map((text) => (
          <ListItem button key={text} onClick={onClose}>
            <ListItemText primary={text} />
          </ListItem>
        ))}
      </List>
    </Drawer>
  );
}
