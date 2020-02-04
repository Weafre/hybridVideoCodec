function [seq]=inverBitstream(bitstr, dict)
seq=[];
currIdx=0;
currL=4;
dicl=size(dict,1);
EOB=false;
codeword=[];
while ~EOB
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
                    currIdx=currIdx+currL;
                    currL=50;
                    break
                end
            end
        end
        currL=currL+1;
    end
    if(currIdx==size(bitstr,2))
        EOB=true;
    end
end
end
   
