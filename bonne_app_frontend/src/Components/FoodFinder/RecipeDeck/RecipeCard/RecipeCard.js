import React from "react";
import { Card } from "primereact/card";
import { Rating } from "primereact/rating";
import { Accordion, AccordionTab } from 'primereact/accordion';

import MatchChip from "./MatchChip/MatchChip";
import ClockChip from "./ClockChip/ClockChip";
import CookingChip from "./CookingChip/CookingChip";
import IngredientTable from "./IngredientTable/IngredientTable";


export default function RecipeCard({recipe, userFood}) {
  const {
    title, 
    author, 
    ratings,
    prep_time: prepTime, 
    cook_time: cookTime, 
    ingredients
  } = recipe

  return(
    <Card title={title} subTitle= { `by ${author}` }>
      <Rating value={ratings} cancel={false} />
      <ClockChip title="Prep Time" minutes={prepTime} />
      <CookingChip minutes={cookTime} />
      
      <MatchChip ingredients={ingredients} userFood={userFood} />
      <Accordion>
        <AccordionTab header="Ingredients">
          <IngredientTable ingredients={ingredients} userFood={userFood} />
        </AccordionTab>
        <AccordionTab header="Text">
            <p className="m-0">
                Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa
                quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas
                sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.
                Consectetur, adipisci velit, sed quia non numquam eius modi.
            </p>
        </AccordionTab>
      </Accordion>
    </Card>
  )
}