#!/bin/bash

FILES=/path/to/*



for x in *" "*; do
  mv -- "$x" "${x// /_}"
done
