function [seq,currBitIdx]=inverBitstream(bitstr, dict,noBLock,bitIdx)
seq=[];
currIdx=bitIdx;
currL=4;
dicl=size(dict,1);
EOF=false;
codeword=[];
blockCount=0;
while ~EOF
    currL=5;
    %currIdx
    while currL<50    
        %currL
        %size(bitstr)
        codeword=bitstr(currIdx+1:currIdx+currL);
        %codeword
        for i=1:dicl
            if(size(dict{i,2},2)==currL)
                if(isequal(bitstr(currIdx+1:currIdx+currL), dict{i,2}))
                    seq(end+1,1)=dict{i,1}(1);
                    seq(end,2) = dict{i,1}(2);
                    if(dict{i,1}(1)==0 && dict{i,1}(2)==0)
                        blockCount=blockCount+1;
                    end
                    currIdx=currIdx+currL;
                    currL=50;
                    break
                end
            end
        end
        currL=currL+1;
    end
    if(blockCount==noBLock)
        currBitIdx=currIdx;
        EOF=true;
    end
end
end
   
