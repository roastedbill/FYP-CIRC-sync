#!/bin/sh
freeview -v $1/mri/norm.mgz \
        -f $1/surf/lh.pial:edgecolor=red \
        $1/surf/rh.pial:edgecolor=red \
        $1/surf/lh.white:edgecolor=blue \
        $1/surf/rh.white:edgecolor=blue \
	-slice 127 127 35 
