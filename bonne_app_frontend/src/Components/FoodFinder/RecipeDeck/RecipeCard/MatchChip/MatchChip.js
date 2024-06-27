import React from "react";
import { Chip } from "primereact/chip";

export default function MatchChip({matched, total}) {
  const matchScore = ((matched / total) * 100).toFixed(2)
  const matchLabel = `Match ${matchScore} %`;

  const colorClass = (matchScore > 50) ? 'bg-lime-600	' : "bg-amber-200"
  return(
  <Chip className={`${colorClass} mx-2`} label={matchLabel} icon="pi pi-chart-line" />
  )
}