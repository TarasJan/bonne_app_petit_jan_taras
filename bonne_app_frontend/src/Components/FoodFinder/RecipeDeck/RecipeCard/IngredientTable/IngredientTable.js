
import React from 'react';
import { DataTable } from 'primereact/datatable';
import { Column } from 'primereact/column';

export default function IngredientTable({ingredients}) {
    return (
        <div className="card">
            <DataTable className='my-3' value={ingredients} tableStyle={{ minWidth: '50rem' }}>
                <Column field="name" header="Product"></Column>
                <Column field="amount" header="Amount"></Column>
                <Column field="unit" header="Unit"></Column>
            </DataTable>
        </div>
    );
}
      