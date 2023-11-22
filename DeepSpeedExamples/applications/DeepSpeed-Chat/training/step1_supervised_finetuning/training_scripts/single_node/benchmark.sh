#!/usr/bin/env bash
export CUDA_VISIBLE_DEVICES=0,1
GPU_NUM=2
GLAKE=True
export GMLAKE_INFO=INFO
for BS in 5 15 25; do 
    bash ./training_scripts/single_node/finetune.sh "$GPU_NUM" "$BS" opt-13b $GLAKE 1 1 0   
    sleep 90
done 