import React from "react";
import { MultiSelect } from 'primereact/multiselect';

export default function FoodSelect({food, userFood, setUserFood}) {
    return (
        <>
        <div class="flex justify-center">
            <h1 class="text-2xl"> Ingredients </h1>
        </div>
        <div className="card flex justify-content-center">
            <MultiSelect value={userFood} onChange={(e) => setUserFood(e.value)} options={food} optionLabel="name" display="chip" 
                placeholder="Select Food you have..." maxSelectedLabels={5} className="w-full md:w-20rem" />
        </div>
        </>
    );
}