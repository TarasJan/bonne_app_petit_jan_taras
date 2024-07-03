import { Panel } from "primereact/panel";
import React from "react";

export default function DeckFooter() {
  return(
    <Panel header="Looking for more?">
      <i className="pi pi-search" style={{ fontSize: '2.5rem' }}></i>
      <p className="m-0">
          Change the ingredients in your selection to find more delicious recipes
      </p>
    </Panel>
  )
}