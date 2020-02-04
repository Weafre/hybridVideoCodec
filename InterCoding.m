function [inter_block,mv,flag]=InterCoding(current_block,r,c , ref_frame,blocksize,q_mtx,search)



%% block intra coding


[ quantized_block,MSE_qz]=blockIntraCoding(current_block,q_mtx);
   

 

%% block bsed motion estimation
[ mv, MSE_me] = me_block(current_block,r,c, ref_frame, blocksize, search);
block_comp = mc_block(ref_frame,mv,blocksize,r,c);

residual=current_block-block_comp;

[quantized_residual,MSE_me_qz]=blockIntraCoding(residual,q_mtx);



%% 

% J_inter=inter_lagrange(mv,quantized_residual,MSE_me,MSE_me_qz);
% J_intra=intera_lagrange(quantized_block,MSE_qz);
% 

%if J_inter<J_intra
if 3<4
    inter_block=quantized_residual;
    flag=1;
else
    inter_block=quantized_block;
    flag=0;
    
end
    









