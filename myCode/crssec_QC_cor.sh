#!/bin/sh

# For reoriented images, where coronal is 127 xxx 127; axial is 127 127 xxx
GM_PATH=/data/users/rens/storage/project_demo/ADNI/raw_data
SS_PATH=/data/users/rens/storage/project_demo/ADNI/QC/crssec_QC
zoom_para=1.7
shave_para=40x20
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
	-viewport coronal -slice 127 127 60 \
        -zoom ${zoom_para} \
        -ss ${SS_PATH}/${sub_id}_cor60 &
        freeview -v ${GM_PATH}/${sub_id}/mri/norm.mgz \
        -f ${GM_PATH}/${sub_id}/surf/lh.pial:edgecolor=red \
        ${GM_PATH}/${sub_id}/surf/rh.pial:edgecolor=red \
        ${GM_PATH}/${sub_id}/surf/lh.white:edgecolor=blue \
        ${GM_PATH}/${sub_id}/surf/rh.white:edgecolor=blue \
        -viewport coronal -slice 127 127 80\
        -zoom ${zoom_para} \
        -ss ${SS_PATH}/${sub_id}_cor80 &
	freeview -v ${GM_PATH}/${sub_id}/mri/norm.mgz \
        -f ${GM_PATH}/${sub_id}/surf/lh.pial:edgecolor=red \
        ${GM_PATH}/${sub_id}/surf/rh.pial:edgecolor=red \
        ${GM_PATH}/${sub_id}/surf/lh.white:edgecolor=blue \
        ${GM_PATH}/${sub_id}/surf/rh.white:edgecolor=blue \
        -viewport coronal -slice 127 127 100\
        -zoom ${zoom_para} \
        -ss ${SS_PATH}/${sub_id}_cor100 &
	freeview -v ${GM_PATH}/${sub_id}/mri/norm.mgz \
        -f ${GM_PATH}/${sub_id}/surf/lh.pial:edgecolor=red \
        ${GM_PATH}/${sub_id}/surf/rh.pial:edgecolor=red \
        ${GM_PATH}/${sub_id}/surf/lh.white:edgecolor=blue \
        ${GM_PATH}/${sub_id}/surf/rh.white:edgecolor=blue \
        -viewport coronal -slice 127 127 127\
        -zoom ${zoom_para} \
        -ss ${SS_PATH}/${sub_id}_cor127 &
	freeview -v ${GM_PATH}/${sub_id}/mri/norm.mgz \
        -f ${GM_PATH}/${sub_id}/surf/lh.pial:edgecolor=red \
        ${GM_PATH}/${sub_id}/surf/rh.pial:edgecolor=red \
        ${GM_PATH}/${sub_id}/surf/lh.white:edgecolor=blue \
        ${GM_PATH}/${sub_id}/surf/rh.white:edgecolor=blue \
        -viewport coronal -slice 127 127 150 \
        -zoom ${zoom_para} \
        -ss ${SS_PATH}/${sub_id}_cor150 &
	freeview -v ${GM_PATH}/${sub_id}/mri/norm.mgz \
        -f ${GM_PATH}/${sub_id}/surf/lh.pial:edgecolor=red \
        ${GM_PATH}/${sub_id}/surf/rh.pial:edgecolor=red \
        ${GM_PATH}/${sub_id}/surf/lh.white:edgecolor=blue \
        ${GM_PATH}/${sub_id}/surf/rh.white:edgecolor=blue \
        -viewport coronal -slice 127 127 170 \
        -zoom ${zoom_para} \
        -ss ${SS_PATH}/${sub_id}_cor170
	############# Merge and cancatenate the screenshots
        sleep 8s
	convert ${SS_PATH}/${sub_id}_cor60.png -shave ${shave_para} ${SS_PATH}/consolidated/${sub_id}_cor60.png 
	convert ${SS_PATH}/${sub_id}_cor80.png -shave ${shave_para} ${SS_PATH}/consolidated/${sub_id}_cor80.png 
	convert ${SS_PATH}/${sub_id}_cor100.png -shave ${shave_para} ${SS_PATH}/consolidated/${sub_id}_cor100.png 
	convert ${SS_PATH}/${sub_id}_cor127.png -shave ${shave_para} ${SS_PATH}/consolidated/${sub_id}_cor127.png 
	convert ${SS_PATH}/${sub_id}_cor150.png -shave ${shave_para} ${SS_PATH}/consolidated/${sub_id}_cor150.png 
	convert ${SS_PATH}/${sub_id}_cor170.png -shave ${shave_para} ${SS_PATH}/consolidated/${sub_id}_cor170.png 
	sleep 1s
        convert +append \
	${SS_PATH}/consolidated/${sub_id}_cor60.png ${SS_PATH}/consolidated/${sub_id}_cor80.png ${SS_PATH}/consolidated/${sub_id}_cor100.png \
	${SS_PATH}/consolidated/${sub_id}_cor127.png ${SS_PATH}/consolidated/${sub_id}_cor150.png ${SS_PATH}/consolidated/${sub_id}_cor170.png \
	${SS_PATH}/consolidated/${sub_id}.png # Merge
	rm ${SS_PATH}/consolidated/${sub_id}_*
	echo '<a href="'./${sub_id}'.png"><img src="'./${sub_id}'.png" WIDTH=2000 > '${sub_id}'</a><br>' >> ${SS_PATH}/consolidated/0000.html
done
echo '</BODY></HTML>' >> ${SS_PATH}/consolidated/0000.html
