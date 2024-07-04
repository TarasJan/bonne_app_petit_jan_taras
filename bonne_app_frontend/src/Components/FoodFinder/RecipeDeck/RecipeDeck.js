import React from "react";
import { Divider } from 'primereact/divider';
import RecipeCard from "./RecipeCard/RecipeCard";
import WelcomePanel from "./WelcomePanel/WelcomePanel";
import DeckFooter from "./DeckFooter/DeckFooter";
import ContactPanel from "./ContactPanel/ContactPanel";


export default function RecipeDeck({recipes, userFood}) {
  if(recipes.length === 0) {
   return(
    <>
    <WelcomePanel />
    <ContactPanel />
    </>
  )
  } else {
    return(
      <>
        { recipes.map(recipe =>
        <>
        <RecipeCard recipe={recipe} userFood={userFood} />
        <Divider/>
        </> 
        ) }
        
        <DeckFooter/>
        <ContactPanel />
      </>
    )
  }
  
}