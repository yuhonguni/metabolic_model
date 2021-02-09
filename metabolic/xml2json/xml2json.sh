#!/bin/bash

# transform .xml to .json

for xml in P450*.xml
do
    python xml2json.py $xml
done

for xml in ROS*.xml
do
    python xml2json.py $xml
done

for xml in fattyAcid*.xml
do
    python xml2json.py $xml
done
