
import React from 'react';
import { DataTable } from 'primereact/datatable';
import { Column } from 'primereact/column';

export default function IngredientTable({ingredients}) {
    const products = [
      {
        "product_name": "Tomato",
        "unit": "can",
        "amount": 2
      },
      {
        "product_name": "Salt",
        "unit": "pinch",
        "amount": 1
      }
    ]

    return (
        <div className="card">
            <DataTable className='my-3' value={products} tableStyle={{ minWidth: '50rem' }}>
                <Column field="product_name" header="Product"></Column>
                <Column field="unit" header="Unit"></Column>
                <Column field="amount" header="Amount"></Column>
            </DataTable>
        </div>
    );
}
      