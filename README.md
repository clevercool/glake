# Train LLM via HuggingFace

## Environment

```bash
conda create -n hg python==3.8
conda activate hg
```
### Install Pytorch
```bash
# Pytorch 1.13.1 CUDA 11.6
# pip install torch==1.13.1+cu116 torchvision==0.14.1+cu116 torchaudio==0.13.1 --extra-index-url https://download.pytorch.org/whl/cu116
pip3 install torch torchvision torchaudio
```

### Install TensorFlow
```bash
# TensorFlow 2.8 CUDA 11
pip install tensorflow==2.8.0
pip install protobuf==3.19.0
```
### Install Jax
```bash
# Jax 0.4.6 CUDA 11
pip install "jax[cuda11_cudnn82]" -f https://storage.googleapis.com/jax-releases/jax_cuda_releases.html


```


### Install Transformer 
```bash
# Transformer 4.27.2
pip install transformers==4.27.2
```