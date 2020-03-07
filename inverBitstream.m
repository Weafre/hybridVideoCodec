function [seq,currBitIdx]=inverBitstream(bitstr,bitIdx, noBlock, dict_first_sym,dict_second_sym)

seq=[];
currIdx=bitIdx;
% currL=4;
dic1=size(dict_first_sym,1);
dic2=size(dict_second_sym,1);
EOB=false;
%codeword=[];
blockCount=0;

while 1
    currL1=1;
    currL2=1;
    EOS = false;
    %currIdx
    while currL1<9
        %currL
        %size(bitstr)
        %codeword=bitstr(currIdx+1:currIdx+currL)
        %codeword
        for i=1:dic1
            if(size(dict_first_sym{i,2},2)==currL1)
                %currIdx
                %currL1
                if(isequal(bitstr(currIdx+1:currIdx+currL1), dict_first_sym{i,2}))
                    
                    seq(end+1,1)=dict_first_sym{i,1};
                    %seq(end,2) = dict{i,1}(2);
                    currIdx=currIdx+currL1;
                    
                    EOS = true;
                    %currL=10;
                    break
                end
            end
        end
        currL1=currL1+1;
        if EOS
            break
        end
        
    end
    
    %%
    
    while currL2<12
        %currL
        %size(bitstr)
        %codeword=bitstr(currIdx+1:currIdx+currL2);
        %codeword
        EOS2 = false;
        for i=1:dic2
            %currL2
            %currIdx
            if(size(dict_second_sym{i,2},2)==currL2)
                if(isequal(bitstr(currIdx+1:currIdx+currL2), dict_second_sym{i,2}))
                    seq(end,2)=dict_second_sym{i,1};
                   
                    %seq(end,2) = dict_second_sym{i,1}(2);
                    currIdx=currIdx+currL2;
                    
                    %currL2=12;
                    EOS2 = true;
                    break
                end
            end
        end
        currL2=currL2+1;
        if EOS2
            break
        end
    end
    if(seq(end,1)==0 && seq(end,2)==0)
       blockCount=blockCount+1;
    end
    if(blockCount==noBlock)
        currBitIdx=currIdx;
        %sprintf('you r done')
        break
    end
end
end
   
