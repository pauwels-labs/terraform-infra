#!/bin/bash

# Clean up existing cluster definitions
rm -rf c01.tf c02.tf c03.tf c04.tf c05.tf c06.tf c07.tf c08.tf c09.tf c1*.tf c2*.tf

# Copies c00.tf into 24 other files labelled sequentially. Each file is a
# different kubernetes cluster.
for i in {1..24}
do
    if [ "$i" -lt 10 ]; then
        cp c00.tf "c0$i.tf"
        sed -i -e "s/c0/c$i/g" "c0$i.tf"
        sed -i -e "s/cluster_index\[0\]/cluster_index[$i]/g" "c0$i.tf"
    else
        cp c00.tf "c$i.tf"
        sed -i -e "s/c0/c$i/g" "c$i.tf"
        sed -i -e "s/cluster_index\[0\]/cluster_index[$i]/g" "c$i.tf"
    fi
done
