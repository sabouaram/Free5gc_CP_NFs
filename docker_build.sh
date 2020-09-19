#!/bin/bash
array=(nrf ausf udm udr webconsole)
array1=( 29510 29509 29503 29504 5000)
for index in ${!array[*]}; do
    echo "------------------------BUILDING ${array[$index]} NF IMAGE and Exposing PORT ${array1[$index]} -----------------------------------------------" 
    sudo docker build --build-arg NF_NAME=${array[$index]} --build-arg PORT=${array1[$index]} -t ${array[$index]}:0.0.1 .
done
