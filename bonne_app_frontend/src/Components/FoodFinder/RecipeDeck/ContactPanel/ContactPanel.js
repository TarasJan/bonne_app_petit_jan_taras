import React from "react";
import { Panel } from "primereact/panel";

export default function ContactPanel() {
    return(
    <Panel className="my-10" header="Missing an Ingredient? Message us!">
        <i className="pi pi-envelope" style={{ fontSize: '4.5rem' }}></i>
        <p>Are you looking for an ingredient / recipe that you cannot find?</p>
        <p>Message us at <a class="text-cyan-600" href="mailto:jan.taras29@gmail.com">jan.taras29@gmail.com</a></p>
        <p>We are constantly looking for ways to improve our recipe database.</p>
    </Panel>
    )
}