#!/bin/bash

# Copies c00.tf into 24 other files labelled sequentially. Each file is a
# different kubernetes cluster.
for i in {1..24}
do
    if [ "$i" -lt 10 ]; then
        cp c00.tf "c0$i.tf"
        sed -i -e "s/c0/c$i/g" "c0$i.tf"
    else
        cp c00.tf "c$i.tf"
        sed -i -e "s/c0/c$i/g" "c$i.tf"
    fi
done
