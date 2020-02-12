function [bitstream_B,MSE_B]=blockIntraCoding(current_block,q_mtx,dict)

% r
% input_bpp = 8; % bits per pixel
% bitrate=4;

% block quantization matrix
% current_frame=double(imread('lena.pgm'));
% blockSize=8;
%  q_mtx =     [16 11 10 16 24 40 51 61; 
%             12 12 14 19 26 58 60 55;
%             14 13 16 24 40 57 69 56; 
%             14 17 22 29 51 87 80 62;
%             18 22 37 56 68 109 103 77;
%             24 35 55 64 81 104 113 92;
%             49 64 78 87 103 121 120 101;
%             72 92 95 98 112 100 103 99];
% block based transform
blocksize=size(current_block,1)

B_DCT=dct2(current_block);

quantized_block=fix(B_DCT./q_mtx);

bitstream_B=RLC(quantized_block, blocksize,dict);
seq=inverBitstream(bitstream_B,dict);
[quantized_reved_bit_block,~]=iRLC(seq,blocksize,size(current_block),dict,1,1);
rev_quantized_frame=quantized_reved_bit_block(:,:,1).*q_mtx;
%rev_quantized_frame=quantized_block.*q_mtx;
XQ=idct2(rev_quantized_frame);

MSE_B=mean( (current_block(:)-XQ(:)).^2);
end




        