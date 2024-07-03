import React, {useState, useEffect} from "react";
import { Divider } from "primereact/divider";

import FoodSelect from "./FoodSelect/FoodSelect";
import RecipeDeck from "./RecipeDeck/RecipeDeck";

export default function FoodFinder() {
  const [foodOptions, setFoodOptions] = useState([]);
  const [userFood, setUserFood] = useState([]);
  const [recipes, setRecipes] = useState([])
  const [minimalRating, setMinimalRating] = useState(0.0);
  const [onlyCold, setOnlyCold] = useState(false);

  useEffect(() => {
    const fetchData = async () => {
      try {
        const response = await fetch('/api/v1/products');
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
        const params = new URLSearchParams({
          product_ids: userFood.map(food => food.id).join(),
          cold: onlyCold,
          min_rating: minimalRating
        })

        const response = await fetch(`/api/v1/recipes/search?${params.toString()}`);
        const result = await response.json();
        setRecipes(result);
      } catch (error) {
        console.error('Error fetching data:', error);
      }
    };

    fetchData();

  }, [userFood, onlyCold, minimalRating]);

  return(
    <>
      <FoodSelect 
        food = {foodOptions} 
        userFood={userFood} 
        setUserFood={setUserFood}
        setOnlyCold={setOnlyCold}
        setMinimalRating={setMinimalRating}
        minimalRating={minimalRating}
      />
      <Divider />
      <RecipeDeck recipes={recipes} userFood={userFood} />
    </>
  )
}
