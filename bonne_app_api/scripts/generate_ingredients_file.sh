#! /bin/bash

cat tmp/recipes.json| jq '.[].ingredients' | grep '"' | tr -d "\"" > tmp/ingredients.txt