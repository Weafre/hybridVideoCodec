function mode = blockCompare(lambda, MSE_inter,MSE_intra,seq_inter,seq_intra,H_first,H_second,H_mv)

% H_first : entropy first symbol
% H_second : entropy second symbol


R_intra = size(seq_intra,1)*(H_first+H_second);
R_inter = size(seq_inter,1)*(H_first+H_second) + H_mv*2 ;% H_mv=6

J_intra = MSE_intra+lambda*R_intra;
J_inter = MSE_inter + lambda*R_inter;

if J_inter<J_intra
    
    mode = 'inter';
else
    mode = 'intra';
end








