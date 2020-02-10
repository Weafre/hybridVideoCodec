function [bitstream_bl, MSE_bl]=blockInterCoding(current_block,r,c , ref_frame,blocksize,q_mtx,search,dict)



%% block intra coding
[bitstream_Intra,MSE_Intra]=blockIntraCoding(current_block,q_mtx,dict);
%% block bsed motion estimation
[mv, ~] = me_block(current_block,r,c, ref_frame, blocksize, search);
block_comp = mc_block(ref_frame,mv,blocksize,r,c);
residual=current_block-block_comp;
[bitstream_re,~]=blockIntraCoding(residual,q_mtx,dict);



%% 

% J_inter=inter_lagrange(mv,quantized_residual,MSE_me,MSE_me_qz);
% J_intra=intera_lagrange(quantized_block,MSE_qz);
% 

%if J_inter<J_intra
if 3<4
    bitstream_bl=quantized_residual;
else
    bitstream_bl=quantized_block;
    
end
    


end






