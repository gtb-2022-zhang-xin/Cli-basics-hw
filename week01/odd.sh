#!/bin/bash
function odd-or-even() {
if [[ `expr $1 % 2` -eq 0 ]]
then
        echo "even"
else
	echo "odd"
fi
}
odd-or-even 12
