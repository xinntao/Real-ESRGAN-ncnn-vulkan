# Real-ESRGAN ncnn Vulkan

![CI](https://github.com/xinntao/Real-ESRGAN-ncnn-vulkan/workflows/CI/badge.svg)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://github.com/xinntao/Real-ESRGAN-ncnn-vulkan/blob/master/LICENSE)
[![Open issue](https://img.shields.io/github/issues/xinntao/Real-ESRGAN-ncnn-vulkan)](https://github.com/xinntao/Real-ESRGAN-ncnn-vulkan/issues)
[![Closed issue](https://img.shields.io/github/issues-closed/xinntao/Real-ESRGAN-ncnn-vulkan)](https://github.com/xinntao/Real-ESRGAN-ncnn-vulkan/issues)

This project is the [ncnn](https://github.com/Tencent/ncnn) implementation of [**Real-ESRGAN**](https://github.com/xinntao/Real-ESRGAN).
*Real-ESRGAN ncnn Vulkan* heavily borrows from [realsr-ncnn-vulkan](https://github.com/nihui/realsr-ncnn-vulkan).
Many thanks to [nihui](https://github.com/nihui), [ncnn](https://github.com/Tencent/ncnn) and [realsr-ncnn-vulkan](https://github.com/nihui/realsr-ncnn-vulkan) :grin:

Real-ESRGAN aims at developing **Practical Algorithms for General Image Restoration**. We also optimize it for anime images.

### Contents

- [TODO List](#hourglass_flowing_sand-todo-list)
- [Usages](#computer-usages)

---

If Real-ESRGAN is helpful in your photos/projects, please help to :star: this repo or recommend it to your friends. Thanks:blush: <br>
Other recommended projects:<br>
:arrow_forward: [Real-ESRGAN](https://github.com/xinntao/Real-ESRGAN): A practical algorithm for general image restoration<br>
:arrow_forward: [GFPGAN](https://github.com/TencentARC/GFPGAN): A practical algorithm for real-world face restoration <br>
:arrow_forward: [BasicSR](https://github.com/xinntao/BasicSR): An open-source image and video restoration toolbox<br>
:arrow_forward: [facexlib](https://github.com/xinntao/facexlib): A collection that provides useful face-relation functions.<br>
:arrow_forward: [HandyView](https://github.com/xinntao/HandyView): A PyQt5-based image viewer that is handy for view and comparison. <br>

### :book: Real-ESRGAN: Training Real-World Blind Super-Resolution with Pure Synthetic Data

> [[Paper](https://arxiv.org/abs/2107.10833)] &emsp; [Project Page] &emsp; [Demo] <br>
> [Xintao Wang](https://xinntao.github.io/), Liangbin Xie, [Chao Dong](https://scholar.google.com.hk/citations?user=OSDCB0UAAAAJ), [Ying Shan](https://scholar.google.com/citations?user=4oXBp9UAAAAJ&hl=en) <br>
> Tencent ARC Lab; Shenzhen Institutes of Advanced Technology, Chinese Academy of Sciences

<p align="center">
  <img src="https://raw.githubusercontent.com/xinntao/Real-ESRGAN/master/assets/teaser.jpg">
</p>
<p align="center">
  <img src="https://raw.githubusercontent.com/xinntao/public-figures/master/Real-ESRGAN/cmp_realesrgan_anime_1.png">
</p>

## :hourglass_flowing_sand: TODO List

- [ ] Support further cheap arbitrary resize (*e.g.*, bicubic, bilinear) for the model outputs
- [ ] Bug: Some PCs will output black images
- [ ] Add the guidance for ncnn model conversion
- [ ] Support face restoration - GFPGAN

## :computer: Usages

### Example Command

```shell
realesrgan-ncnn-vulkan.exe -i input.jpg -o output.png -n realesr-animevideov3 -s 2
```

### Full Usages

```console
Usage: realesrgan-ncnn-vulkan.exe -i infile -o outfile [options]...

  -h                   show this help"
  -i input-path        input image path (jpg/png/webp) or directory"
  -o output-path       output image path (jpg/png/webp) or directory"
  -s scale             upscale ratio (can be 2, 3, 4. default=4)"
  -t tile-size         tile size (>=32/0=auto, default=0) can be 0,0,0 for multi-gpu"
  -m model-path        folder path to the pre-trained models. default=models"
  -n model-name        model name (default=realesr-animevideov3, can be realesr-animevideov3 | realesrgan-x4plus | realesrgan-x4plus-anime | realesrnet-x4plus)"
  -g gpu-id            gpu device to use (default=auto) can be 0,1,2 for multi-gpu"
  -j load:proc:save    thread count for load/proc/save (default=1:2:2) can be 1:2,2,2:2 for multi-gpu"
  -x                   enable tta mode"
  -f format            output image format (jpg/png/webp, default=ext/png)"
  -v                   verbose output"
```

- `input-path` and `output-path` accept either file path or directory path
- `scale` = scale level
- `tile-size` = tile size, use smaller value to reduce GPU memory usage, default selects automatically
- `load:proc:save` = thread count for the three stages (image decoding + model upscaling + image encoding), using larger values may increase GPU usage and consume more GPU memory. You can tune this configuration with "4:4:4" for many small-size images, and "2:2:2" for large-size images. The default setting usually works fine for most situations. If you find that your GPU is hungry, try increasing thread count to achieve faster processing.
- `format` = the format of the image to be output, png is better supported, however webp generally yields smaller file sizes, both are losslessly encoded

If you encounter crash or error, try to upgrade your GPU driver

- Intel: https://downloadcenter.intel.com/product/80939/Graphics-Drivers
- AMD: https://www.amd.com/en/support
- NVIDIA: https://www.nvidia.com/Download/index.aspx

## :earth_asia: Other Open-Source Code Used

- https://github.com/Tencent/ncnn for fast neural network inference on ALL PLATFORMS
- https://github.com/webmproject/libwebp for encoding and decoding Webp images on ALL PLATFORMS
- https://github.com/nothings/stb for decoding and encoding image on Linux / MacOS
- https://github.com/tronkko/dirent for listing files in directory on Windows

## :scroll: BibTeX

    @InProceedings{wang2021realesrgan,
        author    = {Xintao Wang and Liangbin Xie and Chao Dong and Ying Shan},
        title     = {Real-ESRGAN: Training Real-World Blind Super-Resolution with Pure Synthetic Data},
        booktitle = {International Conference on Computer Vision Workshops (ICCVW)},
        date      = {2021}
    }

## :e-mail: Contact

If you have any question, please email `xintao.wang@outlook.com` or `xintaowang@tencent.com`.
