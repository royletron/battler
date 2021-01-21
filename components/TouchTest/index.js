import { useState } from "react";
import styles from "./styles.module.css";

export default function TouchTest() {
  const [pos, setPos] = useState("");
  const onClick = (evt) => {
    setPos(`x: ${evt.pageX} y:${evt.pageY}`);
  };
  return (
    <div onClick={onClick} className={styles.this}>
      {pos}
    </div>
  );
}
