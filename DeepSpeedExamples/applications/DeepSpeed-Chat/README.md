# Train DeepSpeed-Chat on PyTorch via DeepSpeed

refer to [DeepSpeedExamples/applications/DeepSpeed-Chat at master · microsoft/DeepSpeedExamples · GitHub](https://github.com/microsoft/DeepSpeedExamples/tree/master/applications/DeepSpeed-Chat)

## Environment 

```bash
conda create -n hg python==3.10
conda activate hg
```

## Dependency

```bash
pip install deepspeed>=0.9.0
pip install -r requirements.txt
```

## Train 3 Steps with One Single Script on Single Gpu

```bash
python train.py --actor-model facebook/opt-1.3b --reward-model facebook/opt-350m --deployment-type single_gpu
```

## Train 3 Steps Respectively

```bash
## step1 Supervised Fine-Tuning
# Move into the first step of the pipeline
cd training/step1_supervised_finetuning/
# Run the training script
bash training_scripts/single_gpu/run_1.3b.sh
# Evaluate the model
bash evaluation_scripts/run_prompt.sh
```

```bash
## step3 Reinforcement Learning with Human Feedback
# Move into the final step of the pipeline
cd training/step3_rlhf_finetuning/
# Run the training script ; you need assign specific path to the variables 
bash training_scripts/single_gpu/run_1.3b.sh $actor-model-directory$ $reward-model-directory$  '' '' ./output
```

```bash
## step2 Reward Model
# Move into the second step of the pipeline
cd training/step2_reward_model_finetuning
# Run the training script
bash training_scripts/single_gpu/run_350m.sh
# Evaluate the model
bash evaluation_scripts/run_eval.sh
```

## 