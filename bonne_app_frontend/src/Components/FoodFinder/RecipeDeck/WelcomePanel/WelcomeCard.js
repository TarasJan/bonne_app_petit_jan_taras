import React from "react";
import { Panel } from "primereact/panel";

export default function WelcomePanel() {
    return(
    <Panel header="Bonjour! Welcome!">
        <p className="m-0">
            Welcome to the Bonne App! 
        </p>
        <p>Use the menu above to select up to 5 ingredients you have at home and discover delicious meals!</p>
    </Panel>
    )
}