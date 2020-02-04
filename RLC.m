function [bit]=RLC(quantizedFrame, blocksize,dict)
bit=[];
seq=[];
for i=1:blocksize:size(quantizedFrame,1)-blocksize+1
        for j=1:blocksize:size(quantizedFrame,2)-blocksize+1
        tmp=zigzag(quantizedFrame(i:i+blocksize-1,j:j+blocksize-1));
        seq=vertcat(seq,Run_length(tmp,'enc'));
        
        end
    
end
bit=genBitstream(seq,dict);
end