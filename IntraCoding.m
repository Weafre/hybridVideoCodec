function [bitstream,XQ,MSE_X]=IntraCoding(current_frame,blockSize,q_mtx,dict_first_sym,dict_second_sym)


noBlock=(size(current_frame,1)/blockSize) * (size(current_frame,2)/blockSize);
noBlock=floor(noBlock);
T_DCT=block_dct_frame(current_frame,blockSize);

quantized_frame=block_quantizer(T_DCT,blockSize,q_mtx);
bitstream=RLC(quantized_frame,blockSize,dict_first_sym,dict_second_sym);
%
[seq,~]=inverBitstream(bitstream,0,noBlock,dict_first_sym,dict_second_sym);
[quantized_reved_bit_block,~]=iRLC(seq,blockSize,size(current_frame),1,1);
%rev_quantized_frame=quantized_reved_bit_block(:,:,1).*q_mtx;

%
rev_quantized_frame=reverse_block_quantizer(quantized_reved_bit_block(:,:,1),blockSize,q_mtx);

XQ=block_idct_frame(rev_quantized_frame,blockSize);
MSE_X=immse(current_frame(:),XQ(:));
%MSE_X=mean( (current_frame(:)-XQ(:)).^2);
end




        