import React from "react";
import { Chip } from 'primereact/chip';


export default function ClockChip({minutes, title}) {
  const label = `${title}: ${minutes} min`
  return (
    <Chip  className="m-2" label={label} icon="pi pi-clock" />
  )
}