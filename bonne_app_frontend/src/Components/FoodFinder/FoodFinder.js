import React, {useState, useEffect} from "react";
import { Divider } from "primereact/divider";

import FoodSelect from "./FoodSelect/FoodSelect";
import RecipeDeck from "./RecipeDeck/RecipeDeck";


export default function FoodFinder() {
  const [foodOptions, setFoodOptions] = useState([]);
  const [userFood, setUserFood] = useState([]);
  const [recipes, setRecipes] = useState([])

  useEffect(() => {
    const fetchData = async () => {
      try {
        const response = await fetch('http://127.0.0.1:3001/api/v1/products/most_common');
        const result = await response.json();
        setFoodOptions(result);
      } catch (error) {
        console.error('Error fetching data:', error);
      }
    };

    fetchData();
  }, []);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const query = userFood.map(food => food.id).join()
        const response = await fetch(`http://127.0.0.1:3001/api/v1/recipes/search?product_ids=${query}`);
        const result = await response.json();
        setRecipes(result);
      } catch (error) {
        console.error('Error fetching data:', error);
      }
    };

    fetchData();

  }, [userFood]);

  return(
    <>
      <FoodSelect food = {foodOptions} userFood={userFood} setUserFood={setUserFood}/>
      <Divider />
      <RecipeDeck recipes={recipes} />
    </>
  )
}
