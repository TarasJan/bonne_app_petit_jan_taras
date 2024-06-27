import React from "react";
import { Chip } from 'primereact/chip';
import ClockChip from "../ClockChip/ClockChip";

export default function CookingChip({minutes}) {
  if(minutes > 0) {
    return(<ClockChip minutes={minutes} title="Cooking Time" />)
  } else {
    return (
      <Chip  className="bg-cyan-400 m-2" label="No cooking needed!" icon="pi pi-thumbs-up" />
    )
  }
  
}