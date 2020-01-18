%% Transdorm coding 8x8 DCT

addpath('lossless');

%% Load and show an image

x=double(imread('lena.pgm'));
figure; image(uint8(x)); axis image; colormap(gray(256)); axis off; 

input_bpp = 8; % bits per pixel
bitrate=4;
dyn = 2^input_bpp;
delta = 2^(input_bpp-bitrate);
% block quantization matrix
q_mtx =     [16 11 10 16 24 40 51 61; 
            12 12 14 19 26 58 60 55;
            14 13 16 24 40 57 69 56; 
            14 17 22 29 51 87 80 62;
            18 22 37 56 68 109 103 77;
            24 35 55 64 81 104 113 92;
            49 64 78 87 103 121 120 101;
            72 92 95 98 112 100 103 99];



%% simpified block based transform

blockSize=8;

T_DCT=block_dct_frame(x,blockSize);

TQ=block_quantizer(T_DCT,blockSize,q_mtx);

TINV=reverse_block_quantizer(TQ,blockSize,q_mtx);

XQ=block_idct_frame(TINV,blockSize);
PSNR_X = 10*log10(dyn^2/ mean( (x(:)-XQ(:)).^2  ));

MSE_X=mean( (x(:)-XQ(:)).^2);

fprintf('PSNR on X: %5.2f\nMSE on X: %5.2f\n', PSNR_X,MSE_X);

figure; image(uint8(XQ)); axis image; colormap(gray(256)); axis off; 

title ('reconstructed image');


        