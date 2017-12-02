#!/bin/bash
set -e

new_script=$(mktemp)
cp phase2-update.sh $new_script
chmod u+x $new_script
( $new_script )
