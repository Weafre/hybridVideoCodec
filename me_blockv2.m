function [mv, MSE] = me_blockv2(B, r,c,ref,blocksize,search)
%ME Motion estimation
%    MVF = ME(cur, ref, brow, bcol, search);
%    Computes a motion vector field between the current block and reference
%    image, using a given block size and search area
%    
%    Returns the MSE associated to the output MV
%
search_area=8;
delta1= {[-8 0],[0 8],[0 0],[8 0],[0 -8], };
delta2= {[0 0] };
delta3= {[0 0] };
%delta2= {[-4 0],[0 4 ],[0 0],[4 0],[0 -4], };
%delta3= {[-2 0],[0 2],[0 0],[2 0],[0 -2], };
delta={delta1 delta2 delta3};
[rows, cols]=size(ref);

dcolmin=0;drowmin=0;
dcolpre=0;drowpre=0;
% Best cost initialized at the highest possible value
SSDmin=blocksize*blocksize*256*256; 
if(search==1)
    for i=1:3
        for d2=1:length(delta{i})
            drow=delta{i}{d2}(1);
            dcol=delta{i}{d2}(2);
            if ((r+drow+drowpre>0)&&(r+drow+blocksize-1+drowpre<=rows)&& ...
                        (c+dcol+dcolpre>0)&&(c+dcol+blocksize-1+dcolpre<=cols))
                R=ref(r+drow+drowpre:r+drow+blocksize-1+drowpre, c+dcol+dcolpre:c+dcol+blocksize-1+dcolpre);
                SSD=sum(sum((B-R).*(B-R)));
                if (SSD<SSDmin) 
                    SSDmin=SSD;
                    dcolmin=dcol+dcolpre;
                    drowmin=drow+drowpre;
                end   
            end
        end
        dcolpre=dcolmin;
        drowpre=drowmin;
    end
else 
    for dcol=-search_area:search_area
                for drow=-search_area:search_area
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
                        end
                    end % 
                end % 
    end % loop on candidate vectors     
end
    
mv(1)=drowmin;
mv(2)=dcolmin;
MSE = SSDmin;

end
