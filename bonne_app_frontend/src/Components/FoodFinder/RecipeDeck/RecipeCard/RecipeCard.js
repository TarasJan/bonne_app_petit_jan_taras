import React from "react";
import { Card } from "primereact/card";
import { Rating } from "primereact/rating";
import MatchChip from "./MatchChip/MatchChip";
import ClockChip from "./ClockChip/ClockChip";
import CookingChip from "./CookingChip/CookingChip";
import IngredientTable from "./IngredientTable/IngredientTable";


export default function RecipeCard({recipe}) {
  const {
    title, 
    author, 
    ratings,
    prep_time: prepTime, 
    cook_time: cookTime, 
  } = recipe

  return(
    <Card title={title} subTitle= { `by ${author}` }>
      <Rating value={ratings} cancel={false} />
      <ClockChip title="Prep Time" minutes={prepTime} />
      <CookingChip minutes={cookTime} />
      
      <MatchChip matched={1} total={3} />

      <IngredientTable/>
      <p className="m-0">
          Lorem ipsum dolor sit amet, consectetur adipisicing elit. Inventore sed consequuntur error repudiandae 
          numquam deserunt quisquam repellat libero asperiores earum nam nobis, culpa ratione quam perferendis esse, cupiditate neque quas!
      </p>
    </Card>
  )
}