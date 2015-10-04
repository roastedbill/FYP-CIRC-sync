#!/bin/sh

# For reoriented images, where coronal is 127 xxx 127; axial is 127 127 xxx

############## Constants

GM_PATH=/data/users/rens/storage/project_demo/ADNI/raw_data
SS_PATH=/data/users/rens/storage/project_demo/ADNI/QC/crssec_QC_3_aixs
zoom_para=1.8
shave_para=10

############## Set up FSL and FreeSurfer
export FSL_DIR=//apps/arch/Linux_x86_64/fsl/5.0.6
export FREESURFER_HOME=//apps/arch/Linux_x86_64/freesurfer/5.3.0
source ${FREESURFER_HOME}/SetUpFreeSurfer.sh
source ${FSL_DIR}/etc/fslconf/fsl.sh


echo '<HTML><TITLE>results</TITLE><BODY BGCOLOR="#aaaaff">' > ${SS_PATH}/consolidated/0000.html
for file in ${GM_PATH}/*/mri/norm.mgz
do
	sub_id=$(echo ${file##$GM_PATH} | cut -d "/" -f2) # Subject ID
        echo ${sub_id}
	############## Screenshots
	freeview -v ${GM_PATH}/${sub_id}/mri/norm.mgz \
        -f ${GM_PATH}/${sub_id}/surf/lh.pial:edgecolor=red \
        ${GM_PATH}/${sub_id}/surf/rh.pial:edgecolor=red \
        ${GM_PATH}/${sub_id}/surf/lh.white:edgecolor=blue \
        ${GM_PATH}/${sub_id}/surf/rh.white:edgecolor=blue \
	-viewport sagittal -slice 80 127 127 \
        -zoom $zoom_para -ss ${SS_PATH}/${sub_id}_sag1 &
        freeview -v ${GM_PATH}/${sub_id}/mri/norm.mgz \
        -f ${GM_PATH}/${sub_id}/surf/lh.pial:edgecolor=red \
        ${GM_PATH}/${sub_id}/surf/rh.pial:edgecolor=red \
        ${GM_PATH}/${sub_id}/surf/lh.white:edgecolor=blue \
        ${GM_PATH}/${sub_id}/surf/rh.white:edgecolor=blue \
        -viewport sagittal -slice 127 127 127 \
        -zoom $zoom_para -ss ${SS_PATH}/${sub_id}_sag2 &
	freeview -v ${GM_PATH}/${sub_id}/mri/norm.mgz \
        -f ${GM_PATH}/${sub_id}/surf/lh.pial:edgecolor=red \
        ${GM_PATH}/${sub_id}/surf/rh.pial:edgecolor=red \
        ${GM_PATH}/${sub_id}/surf/lh.white:edgecolor=blue \
        ${GM_PATH}/${sub_id}/surf/rh.white:edgecolor=blue \
        -viewport sagittal -slice 160 127 127 \
        -zoom $zoom_para -ss ${SS_PATH}/${sub_id}_sag3 &
	freeview -v ${GM_PATH}/${sub_id}/mri/norm.mgz \
        -f ${GM_PATH}/${sub_id}/surf/lh.pial:edgecolor=red \
        ${GM_PATH}/${sub_id}/surf/rh.pial:edgecolor=red \
        ${GM_PATH}/${sub_id}/surf/lh.white:edgecolor=blue \
        ${GM_PATH}/${sub_id}/surf/rh.white:edgecolor=blue \
        -viewport coronal -slice 127 127 80 \
        -zoom $zoom_para -ss ${SS_PATH}/${sub_id}_cor1 &
	freeview -v ${GM_PATH}/${sub_id}/mri/norm.mgz \
        -f ${GM_PATH}/${sub_id}/surf/lh.pial:edgecolor=red \
        ${GM_PATH}/${sub_id}/surf/rh.pial:edgecolor=red \
        ${GM_PATH}/${sub_id}/surf/lh.white:edgecolor=blue \
        ${GM_PATH}/${sub_id}/surf/rh.white:edgecolor=blue \
        -viewport coronal -slice 127 127 127 \
        -zoom $zoom_para -ss ${SS_PATH}/${sub_id}_cor2 &
	freeview -v ${GM_PATH}/${sub_id}/mri/norm.mgz \
        -f ${GM_PATH}/${sub_id}/surf/lh.pial:edgecolor=red \
        ${GM_PATH}/${sub_id}/surf/rh.pial:edgecolor=red \
        ${GM_PATH}/${sub_id}/surf/lh.white:edgecolor=blue \
        ${GM_PATH}/${sub_id}/surf/rh.white:edgecolor=blue \
        -viewport coronal -slice 127 127 160 \
        -zoom $zoom_para -ss ${SS_PATH}/${sub_id}_cor3 &
	freeview -v ${GM_PATH}/${sub_id}/mri/norm.mgz \
        -f ${GM_PATH}/${sub_id}/surf/lh.pial:edgecolor=red \
        ${GM_PATH}/${sub_id}/surf/rh.pial:edgecolor=red \
        ${GM_PATH}/${sub_id}/surf/lh.white:edgecolor=blue \
        ${GM_PATH}/${sub_id}/surf/rh.white:edgecolor=blue \
        -viewport axial -slice 127 160 127 \
        -zoom $zoom_para -ss ${SS_PATH}/${sub_id}_axi1 &
	freeview -v ${GM_PATH}/${sub_id}/mri/norm.mgz \
        -f ${GM_PATH}/${sub_id}/surf/lh.pial:edgecolor=red \
        ${GM_PATH}/${sub_id}/surf/rh.pial:edgecolor=red \
        ${GM_PATH}/${sub_id}/surf/lh.white:edgecolor=blue \
        ${GM_PATH}/${sub_id}/surf/rh.white:edgecolor=blue \
        -viewport axial -slice 127 127 127 \
        -zoom $zoom_para -ss ${SS_PATH}/${sub_id}_axi2 &
	freeview -v ${GM_PATH}/${sub_id}/mri/norm.mgz \
        -f ${GM_PATH}/${sub_id}/surf/lh.pial:edgecolor=red \
        ${GM_PATH}/${sub_id}/surf/rh.pial:edgecolor=red \
        ${GM_PATH}/${sub_id}/surf/lh.white:edgecolor=blue \
        ${GM_PATH}/${sub_id}/surf/rh.white:edgecolor=blue \
        -viewport axial -slice 127 80 160 \
        -zoom $zoom_para -ss ${SS_PATH}/${sub_id}_axi3
	############# Merge and cancatenate the screenshots
        sleep 10s
	convert ${SS_PATH}/${sub_id}_sag1.png -shave ${shave_para}x0 ${SS_PATH}/consolidated/${sub_id}_sag1.png 
	convert ${SS_PATH}/${sub_id}_sag2.png -shave ${shave_para}x0 ${SS_PATH}/consolidated/${sub_id}_sag2.png 
	convert ${SS_PATH}/${sub_id}_sag3.png -shave ${shave_para}x0 ${SS_PATH}/consolidated/${sub_id}_sag3.png 
	convert ${SS_PATH}/${sub_id}_cor1.png -shave ${shave_para}x0 ${SS_PATH}/consolidated/${sub_id}_cor1.png 
	convert ${SS_PATH}/${sub_id}_cor2.png -shave ${shave_para}x0 ${SS_PATH}/consolidated/${sub_id}_cor2.png 
	convert ${SS_PATH}/${sub_id}_cor3.png -shave ${shave_para}x0 ${SS_PATH}/consolidated/${sub_id}_cor3.png 
	convert ${SS_PATH}/${sub_id}_axi1.png -shave ${shave_para}x0 ${SS_PATH}/consolidated/${sub_id}_axi1.png 
	convert ${SS_PATH}/${sub_id}_axi2.png -shave ${shave_para}x0 ${SS_PATH}/consolidated/${sub_id}_axi2.png 
	convert ${SS_PATH}/${sub_id}_axi3.png -shave ${shave_para}x0 ${SS_PATH}/consolidated/${sub_id}_axi3.png 
	sleep 1s
        convert +append \
	${SS_PATH}/consolidated/${sub_id}_sag1.png ${SS_PATH}/consolidated/${sub_id}_sag2.png ${SS_PATH}/consolidated/${sub_id}_sag3.png \
	${SS_PATH}/consolidated/${sub_id}_cor1.png ${SS_PATH}/consolidated/${sub_id}_cor2.png ${SS_PATH}/consolidated/${sub_id}_cor3.png \
	${SS_PATH}/consolidated/${sub_id}_axi1.png ${SS_PATH}/consolidated/${sub_id}_axi2.png ${SS_PATH}/consolidated/${sub_id}_axi3.png \
	${SS_PATH}/consolidated/${sub_id}.png # Merge
	rm ${SS_PATH}/consolidated/${sub_id}_*
	echo '<a href="'./${sub_id}'.png"><img src="'./${sub_id}'.png" WIDTH=2000 > '${sub_id}'</a><br>' >> ${SS_PATH}/consolidated/0000.html
done
echo '</BODY></HTML>' >> ${SS_PATH}/consolidated/0000.html
