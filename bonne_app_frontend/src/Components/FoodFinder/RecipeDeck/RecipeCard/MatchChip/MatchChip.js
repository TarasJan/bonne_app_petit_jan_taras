import React from "react";
import { Chip } from "primereact/chip";

export default function MatchChip({ingredients, userFood}) {
  const total = userFood.length
  const userFoodIds = userFood.map(food => food.id)
  const ingredientsIds = ingredients.map(ingredient => ingredient.product_id)
  
  const matches = userFoodIds.filter(x => ingredientsIds.includes(x)).length;

  const matchScore = ((matches / total) * 100).toFixed(2)
  const matchLabel = `Match ${matchScore} %`;

  const colorClass = (matchScore > 50) ? 'bg-lime-600	' : "bg-amber-200"
  return(
  <Chip className={`${colorClass} mx-2`} label={matchLabel} icon="pi pi-chart-line" />
  )
}