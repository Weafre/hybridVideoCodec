function [mv,MSE_B_me] = me_block(B,r,c, ref, blocksize, search)



        
SSDmin=blocksize*blocksize*256*256; 
[rows, cols]=size(ref);

for dcol=-search:search,
            for drow=-search:search,
                % Check: inside image
                if ((r+drow>0)&&(r+drow+blocksize-1<=rows)&& ...
                        (c+dcol>0)&&(c+dcol+blocksize-1<=cols))
                    % Reference macroblock
                    R=ref(r+drow:r+drow+blocksize-1,c+dcol:c+dcol+blocksize-1);
                    SSD=sum(sum((B-R).*(B-R)));
                    
                    % If current candidate is better than previous
                    % best candidate, than update the best candidate
                    if (SSD<SSDmin) 
                        SSDmin=SSD;
                        dcolmin=dcol;
                        drowmin=drow;
                    end;
                end; % 
            end; % 
end; % loop on candidate vectors
        % Store the best MV and the associated cost
        mv(1)=drowmin;
        mv(2)=dcolmin;
    
        MSE_B_me=SSDmin;
end  



 