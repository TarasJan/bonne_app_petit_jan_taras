import React from "react";
import { Divider } from 'primereact/divider';
import RecipeCard from "./RecipeCard/RecipeCard";
import WelcomePanel from "./WelcomePanel/WelcomeCard";


// <RecipeCard title="Banana Bread" author="Ada Wong" prepTime={20}/>
// <RecipeCard title="Apple Pie" author= "Dan Smith" prepTime={45}/>

export default function RecipeDeck({recipes}) {
  if(recipes.length == 0) {
   return(<WelcomePanel />)
  } else {
    return(
      <>
        { recipes.map(recipe =>
        <>
        <RecipeCard recipe= {recipe}/>
        <Divider/>
        </> 
        ) }
      </>
    )
  }
  
}