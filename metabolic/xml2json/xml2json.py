#!/bin/python

import sys
import cobra

# argv: xml file name

xml = sys.argv[1]

model = cobra.io.read_sbml_model(xml)

model_name = xml.split(".xml")[0]

cobra.io.save_json_model(model, model_name + ".json")

