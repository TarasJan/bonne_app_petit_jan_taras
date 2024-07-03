import React, {useState} from "react";
import { MultiSelect } from 'primereact/multiselect';
import { Panel } from "primereact/panel";
import { Checkbox } from "primereact/checkbox";
import { Divider } from "primereact/divider";
import { Rating } from "primereact/rating";

export default function FoodSelect({food, userFood, setUserFood, setOnlyCold, setMinimalRating, minimalRating}) {
    const [toggle, setToggle] = useState(false)

    const itemTemplate = (option) => {
        return (
            <div className="flex align-items-center">
                <span>{option.name}</span>
                <span className="text-gray-300">{`(${option.mentions} recipes)`}</span>
            </div>
        );
    };

    const onToggleChange = () => {
        setOnlyCold(!toggle)
        setToggle(!toggle)
    }

    return (
        <Panel header="Ingredients">
        <div className="card flex justify-content-center flex-row">
            <MultiSelect value={userFood} onChange={(e) => setUserFood(e.value)} options={food} optionLabel="name" display="chip" 
              filter itemTemplate={itemTemplate}  placeholder="Select Food you have..." maxSelectedLabels={5} className="w-full md:w-20rem" />
        </div>
        <Divider/>
            <p>
                <div className="flex bg-slate-300 align-items-center p-1">
                    <Checkbox inputId="no_time" name="cold" value={toggle} onChange={onToggleChange} checked={toggle} />
                    <label htmlFor="cold" className="ml-2">No way to cook? Show cold dishes only</label>
                </div>
            </p>
            <p>
                <div className="flex bg-slate-300 align-items-center p-1">
                    <Rating cancel={false} value={minimalRating} onChange={(e) => setMinimalRating(e.value)} >Minimal Rating</Rating>
                    <label htmlFor="cold" className="ml-2">Minimal Rating</label>
                </div>
            </p>
        </Panel>
    );
} 