#!/usr/bin/env bash
git clone -b release/2.0 https://github.com/pytorch/pytorch
cd pytorch
git submodule sync
git submodule update --init --recursive
cp ../GMLake/src/CUDACachingAllocator.cpp ./c10/cuda
cp ../GMLake/include/cuda_vmm_allocator.h ./c10/cuda
vim -c ":%s/target_link_libraries(c10_cuda PUBLIC c10 torch::cudart)/target_link_libraries(c10_cuda PUBLIC c10 torch::cudart caffe2::cuda)/g" -c ":wq" ./c10/cuda/CMakeLists.txt
TORCH_CUDA_ARCH_LIST="8.0" USE_CUDA=1 python setup.py install
cp ./torch/lib/libc10_cuda.so /localdata_ssd/jlxu/anaconda3/envs/dsc/lib/python3.10/site-packages/torch/lib/libc10_cuda.so