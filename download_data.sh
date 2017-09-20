#!/bin/sh

cd raw_data

# Use Rscript
for FILE in epa ants
do 
    echo "${FILE}"
    export FILE

    Rscript ${FILE}_download.r
done

# Use retriever
for FILE in gentry-forest-transects mammal-community-db community-abundance-misc breed-bird-survey forest-inventory-analysis
do
    echo "${FILE}"
    export FILE
    
    retriever install sqlite ${FILE} -f ${FILE}.sqlite3
done

