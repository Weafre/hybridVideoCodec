function [bitstream_B,MSE_B,XQ]=blockIntraCoding(current_block,q_mtx,dict_first_sym,dict_second_sym)

blocksize=size(current_block,1);

B_DCT=dct2(current_block);

quantized_block=fix(B_DCT./q_mtx);

bitstream_B=RLC(quantized_block, blocksize,dict_first_sym,dict_second_sym);
[seq,~]=inverBitstream(bitstream_B,0,1,dict_first_sym,dict_second_sym);
[quantized_reved_bit_block,~]=iRLC(seq,blocksize,size(current_block),1,1);
rev_quantized_frame=quantized_reved_bit_block(:,:,1).*q_mtx;
%rev_quantized_frame=quantized_block.*q_mtx;
XQ=idct2(rev_quantized_frame);

MSE_B=mean( (current_block(:)-XQ(:)).^2);
end




        