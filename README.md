# Stego-Post-processing
A simple yet effective post-processing method to enhance image steganography in spatial domain.

## Abstract
Most modern steganography methods focus on designing an effective cost function. To our best knowledge, there is no  related works concerned about modifying stego to enhance  steganography security.
In this paper, therefore, we propose a novel post-processing for stego image in the spatial domain. To ensure the correct extraction of hidden message, our method  restricts the modification amplitude of each pixel according to the characteristics of STCs (Syndrome-Trellis Codes). To enhance steganography security, our method traverses the stego image pixel by pixel, and modifies those pixels that can reduce the image residual difference between cover and stego under some criterion. Experimental results show that the proposed method can improve the security of current steganography especially for large payloads, e.g. larger than 0.3 bpp. In addition, the post-modification rate is rather low, for instance less than 8 ‱ pixels have been changed in the enhanced stego image for the five existing steganography methods for payload as large as 0.5 bpp.

## Usage
```matlab
cover = imread('cover.pgm');
stego = imread('stego.pgm');
enhanced_stego = stego_post_process(cover, stego);
```
## Citation
Please cite the following paper if the code helps your research.

B. Chen, W. Luo and P. Zheng, “Enhancing Steganography via Stego Post-processing by Reducing Image Residual Difference,” in Proc. 7th ACM Workshop Inf. Hiding Multimedia Secur. (IH&MMSec), 2019.

