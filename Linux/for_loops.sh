#!/bin/bash

for package in ${packages[@]}
do 
if [ ! $(which $package) ]
then 
apt install -y $package
di
done
