# Train GPT-2 on TensorFlow via HuggingFace

Refer to https://github.com/huggingface/transformers/tree/main/examples/tensorflow/language-modeling

### Install requirements
```bash
pip install -r requirements.txt
```

```bash
# GPT2
python run_clm.py \
    --model_name_or_path gpt2 \
    --dataset_name wikitext \
    --dataset_config_name wikitext-2-raw-v1 \
    --per_device_train_batch_size 11 \
    --per_device_eval_batch_size 11 \
    --do_train \
    --do_eval \
    --output_dir /tmp/test-clm
```
```bash
# Medium
python run_clm.py \
    --model_name_or_path gpt2-medium \
    --dataset_name wikitext \
    --dataset_config_name wikitext-2-raw-v1 \
    --per_device_train_batch_size 4 \
    --per_device_eval_batch_size 4 \
    --do_train \
    --do_eval \
    --output_dir /tmp/test-clm
```
```bash
# Large
python run_clm.py \
    --model_name_or_path gpt2-large \
    --dataset_name wikitext \
    --dataset_config_name wikitext-2-raw-v1 \
    --per_device_train_batch_size 8 \
    --per_device_eval_batch_size 8 \
    --do_train \
    --do_eval \
    --output_dir /tmp/test-clm
```
```bash
# XL
python run_clm.py \
    --model_name_or_path gpt2-xl \
    --dataset_name wikitext \
    --dataset_config_name wikitext-2-raw-v1 \
    --per_device_train_batch_size 8 \
    --per_device_eval_batch_size 8 \
    --do_train \
    --do_eval \
    --output_dir /tmp/test-clm
```