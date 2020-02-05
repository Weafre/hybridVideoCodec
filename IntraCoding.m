function [bitstream,quantized_frame,MSE_X]=IntraCoding(current_frame,blockSize,q_mtx,dict)


% input_bpp = 8; % bits per pixel
% bitrate=4;

% block quantization matrix
% q_mtx =     [16 11 10 16 24 40 51 61; 
%             12 12 14 19 26 58 60 55;
%             14 13 16 24 40 57 69 56; 
%             14 17 22 29 51 87 80 62;
%             18 22 37 56 68 109 103 77;
%             24 35 55 64 81 104 113 92;
%             49 64 78 87 103 121 120 101;
%             72 92 95 98 112 100 103 99];



% block based transform



T_DCT=block_dct_frame(current_frame,blockSize);

quantized_frame=block_quantizer(T_DCT,blockSize,q_mtx);
bitstream=RLC(quantized_frame,blockSize,dict);
rev_quantized_frame=reverse_block_quantizer(quantized_frame,blockSize,q_mtx);

XQ=block_idct_frame(rev_quantized_frame,blockSize);

MSE_X=mean( (current_frame(:)-XQ(:)).^2);
end




        