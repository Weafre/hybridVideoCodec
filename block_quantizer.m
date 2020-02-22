function [y]=block_quantizer(x,blockSize,q_mtx)
y = [];
temp = 0;

for i=1:blockSize:size(x,1)-blockSize+1
        for j=1:blockSize:size(x,2)-blockSize+1
        y(i:i+blockSize-1,j:j+blockSize-1)=fix((x(i:i+blockSize-1,j:j+blockSize-1))./q_mtx);
        
        tem = y(i,j);
        y(i,j) = y(i,j)- temp;
        
        temp = tem;
        
        
        
        end
    
end