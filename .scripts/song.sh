#! /bin/bash

if [ -z "$(mpc current)" ]; then
    echo  ""
else
    echo  " $(mpc current -f '%artist% - %title%')"
fi