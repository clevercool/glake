#!/usr/bin/env bash
# glake config 
export autoGC=100
export fragLimit=268435556
export reuseLimit=10
export defragLevel=0 # 0-greedy 1-lazy

# runtime parameter config
GPU_NUM=$1
BS=$2
MODEL=$3
ZERO_STAGE=3
GLAKE=$4 # True or False
if [ "$GLAKE" == "True" ]; then
    export vmmDefragment=1
else
    export vmmDefragment=0
fi
L=$5
R=$6
O=$7
# MODEL_NAME=$(echo ${MODEL} | cut -d / -f 2)
MODEL_NAME=$MODEL
echo $MODEL_NAME
OUTPUT=./release_output/output_${MODEL_NAME}
echo $OUTPUT
mkdir -p $OUTPUT 
LORA_NAME=""
TAG=${MODEL_NAME}_G${GPU_NUM}_B${BS}_GLAKE-${GLAKE}_L${L}_R${R}_O${O}_GC${autoGC}_FL${fragLimit}_RL${reuseLimit}
export traceFile=${TRACE_PATH}/trace_${TAG}.log
#

if [ "$MODEL_NAME" == "opt-13b" -o "$MODEL_NAME" == "opt-6.7b" -o "$MODEL_NAME" == "opt-1.3b" -o "$MODEL_NAME" == "opt-30b" ]; then
    LORA_NAME=decoder.layers.
elif [ "$MODEL_NAME" == "bloom-7b1" ]; then 
    LORA_NAME=h.
elif [ "$MODEL_NAME" == "gpt-neox-20b" ]; then 
    LORA_NAME=gpt_neox.layers.
elif [ "$MODEL_NAME" == "vicuna-13b-v1.3" -o "$MODEL_NAME" == "vicuna-7b-v1.3" -o  "$MODEL_NAME" == "llama-13b-hf" ]; then 
    LORA_NAME=model.layers.
fi

#echo $LORA_NAME

MASTER_PORT=$(shuf -n 1 -i 10000-65535)
MAIN_ARGS=( --data_path Dahoas/rm-static Dahoas/full-hh-rlhf Dahoas/synthetic-instruct-gptj-pairwise yitingxie/rlhf-reward-datasets
   --data_split 2,4,4 \
   --model_name_or_path /localdata_ssd/model/${MODEL} \
   --per_device_train_batch_size ${BS} \
   --per_device_eval_batch_size 1 \
   --max_seq_len 512 \
   --learning_rate 1e-3 \
   --weight_decay 0.1 \
   --num_train_epochs 1 \
   --gradient_accumulation_steps 1 \
   --lr_scheduler_type cosine \
   --num_warmup_steps 0 \
   --seed 1234 \
   --zero_stage 3 \
   --deepspeed \
   --output_dir $OUTPUT \
)

if [ "$L" -eq 1 ]; then 
    MAIN_ARGS+=( --lora_dim 128 --lora_module_name ${LORA_NAME} )
fi

if [ "$R" -eq 1 ]; then 
    MAIN_ARGS+=( --gradient_checkpointing )
fi

if [ "$O" -eq 1 ]; then 
    MAIN_ARGS+=( --offload )
fi

# Get the current date
CURRENT_DATE=$(date +%Y-%m-%d-%H-%M-%s)

deepspeed --num_gpus ${GPU_NUM} --master_port ${MASTER_PORT} main.py \
    ${MAIN_ARGS[@]} \
    &> $OUTPUT/training_${TAG}_${CURRENT_DATE}.log