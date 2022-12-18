#!/bin/bash

for i in ~/.config/tmuxinator/*.yml
do
    tmuxinator start $(basename $i .yml) &
done
