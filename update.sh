#!/bin/bash
set -e

new_script=$(mktemp)
cp update-phase2.sh $new_script
$new_script
