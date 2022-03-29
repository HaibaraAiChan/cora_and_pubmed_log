#!/bin/bash

model=sage
file=cora
# aggre=lstm
# pMethod=range

hiddenList=(16 32 64 128 256)
layersList=(3 4 5 6)
aggreList=(mean lstm)
pMethodList=(random range)
eval=False

mkdir res/
mkdir res/${file}
mkdir res/${file}/${model}
for aggre in ${aggreList[@]}
do      
        mkdir res/${file}/${model}/${aggre}/
        for pMethod in ${pMethodList[@]}
        do
                mkdir res/${file}/${model}/${aggre}/${pMethod}
                for layers in ${layersList[@]}
                do
                        mkdir res/${file}/${model}/${aggre}/${pMethod}/layers_${layers}       
                        for hidden in ${hiddenList[@]}
                        do      
                                mkdir res/${file}/${model}/${aggre}/${pMethod}/layers_${layers}/h_${hidden} 
                                resPath=res/${file}/${model}/${aggre}/${pMethod}/layers_${layers}/h_${hidden}
                                
                                python calculate_time_mem.py \
                                --aggre $aggre \
                                --selection-method $pMethod \
                                --hidden $hidden \
                                --num-layers $layers \
                                --save-path ${resPath}/${file}_${model}_eval_${eval}_pseudo_ \
                                > ${resPath}/${file}_${model}_eval_${eval}_mem.log
                    
                                python calculate_compute_efficiency.py \
                                --aggre $aggre \
                                --selection-method $pMethod \
                                --hidden $hidden \
                                --num-layers $layers \
                                --save-path ${resPath}/${file}_${model}_eval_${eval}_pseudo_ \
                                > ${resPath}/${file}_${model}_eval_${eval}_eff.log
                                
                                
                                
                        done
                done
        done
done
python num_file_check.py \
        --filepath res/ \
        > cora_error.log
        
        
        
# model=sage
# file=arxiv
# aggre=mean
# eval=False

# python calculate_time_mem.py \
# --save-path ${model}/res/${aggre}/${file}_${model}_eval_${eval}_pseudo_ \
# > ${model}/res/${aggre}/${file}_${model}_eval_${eval}_mem.log

# python calculate_compute_efficiency.py \
# --save-path ${model}/res/${aggre}/${file}_${model}_eval_${eval}_pseudo_ \
# > ${model}/res/${aggre}/${file}_${model}_eval_${eval}_eff.log
