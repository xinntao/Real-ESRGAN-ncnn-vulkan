# RealESRGAN ncnn Vulkan

![CI](https://github.com/xinntao/realesrgan-ncnn-vulkan/workflows/CI/badge.svg)
![download](https://img.shields.io/github/downloads/xinntao/realesrgan-ncnn-vulkan/total.svg)

ncnn implementation of Real-World Super-Resolution via Kernel Estimation and Noise Injection super resolution.

realesrgan-ncnn-vulkan uses [ncnn project](https://github.com/Tencent/ncnn) as the universal neural network inference framework.

## [Download](https://github.com/nihui/realesrgan-ncnn-vulkan/releases)

Download Windows/Linux/MacOS Executable for Intel/AMD/Nvidia GPU

**https://github.com/nihui/realesrgan-ncnn-vulkan/releases**

This package includes all the binaries and models required. It is portable, so no CUDA or Caffe runtime environment is needed :)

## About RealEsrgan

Real-World Super-Resolution via Kernel Estimation and Noise Injection (CVPRW 2020)

https://github.com/jixiaozhong/RealSR

Xiaozhong Ji, Yun Cao, Ying Tai, Chengjie Wang, Jilin Li, and Feiyue Huang

*Tencent YouTu Lab*

Our solution is the **winner of CVPR NTIRE 2020 Challenge on Real-World Super-Resolution** in both tracks.

https://arxiv.org/abs/2005.01996

## Usages

### Example Command

```shell
realsr-ncnn-vulkan.exe -i input.jpg -o output.png -s 4
```

### Full Usages

```console
Usage: realsr-ncnn-vulkan -i infile -o outfile [options]...

  -h                   show this help
  -v                   verbose output
  -i input-path        input image path (jpg/png/webp) or directory
  -o output-path       output image path (jpg/png/webp) or directory
  -s scale             upscale ratio (4, default=4)
  -t tile-size         tile size (>=32/0=auto, default=0) can be 0,0,0 for multi-gpu
  -m model-path        realsr model path (default=models-DF2K_JPEG)
  -g gpu-id            gpu device to use (default=0) can be 0,1,2 for multi-gpu
  -j load:proc:save    thread count for load/proc/save (default=1:2:2) can be 1:2,2,2:2 for multi-gpu
  -x                   enable tta mode
  -f format            output image format (jpg/png/webp, default=ext/png)
```

- `input-path` and `output-path` accept either file path or directory path
- `scale` = scale level, 4 = upscale 4x
- `tile-size` = tile size, use smaller value to reduce GPU memory usage, default selects automatically
- `load:proc:save` = thread count for the three stages (image decoding + waifu2x upscaling + image encoding), using larger values may increase GPU usage and consume more GPU memory. You can tune this configuration with "4:4:4" for many small-size images, and "2:2:2" for large-size images. The default setting usually works fine for most situations. If you find that your GPU is hungry, try increasing thread count to achieve faster processing.
- `format` = the format of the image to be output, png is better supported, however webp generally yields smaller file sizes, both are losslessly encoded

If you encounter crash or error, try to upgrade your GPU driver

- Intel: https://downloadcenter.intel.com/product/80939/Graphics-Drivers
- AMD: https://www.amd.com/en/support
- NVIDIA: https://www.nvidia.com/Download/index.aspx

## Build from Source

1. Download and setup the Vulkan SDK from https://vulkan.lunarg.com/
  - For Linux distributions, you can either get the essential build requirements from package manager
```shell
dnf install vulkan-headers vulkan-loader-devel
```
```shell
apt-get install libvulkan-dev
```
```shell
pacman -S vulkan-headers vulkan-icd-loader
```

2. Clone this project with all submodules

```shell
git clone https://github.com/nihui/realsr-ncnn-vulkan.git
cd realsr-ncnn-vulkan
git submodule update --init --recursive
```

3. Build with CMake
  - You can pass -DUSE_STATIC_MOLTENVK=ON option to avoid linking the vulkan loader library on MacOS

```shell
mkdir build
cd build
cmake ../src
cmake --build . -j 4
```

## Sample Images

### Original Image

![origin](images/0.png)

### Upscale 4x with ImageMagick Lanczo4 Filter

```shell
convert origin.jpg -resize 400% output.png
```

![browser](images/im.png)

### Upscale 4x with srmd scale=4 noise=-1

```shell
srmd-ncnn-vulkan.exe -i origin.jpg -o 4x.png -s 4 -n -1
```

![waifu2x](images/srmd.png)

### Upscale 4x with realsr model=DF2K scale=4 tta=1

```shell
realsr-ncnn-vulkan.exe -i origin.jpg -o output.png -s 4 -x -m models-DF2K
```

![realsr](images/2.png)

## Original RealSR Project

- https://github.com/jixiaozhong/RealSR

## Other Open-Source Code Used

- https://github.com/Tencent/ncnn for fast neural network inference on ALL PLATFORMS
- https://github.com/webmproject/libwebp for encoding and decoding Webp images on ALL PLATFORMS
- https://github.com/nothings/stb for decoding and encoding image on Linux / MacOS
- https://github.com/tronkko/dirent for listing files in directory on Windows
