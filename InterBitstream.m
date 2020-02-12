function [re,mv]=InterBitstream(bitMv,bitRe, dict,mv_codebook)
re=[];
currIdx=0;
currL=4;
dicl=size(dict,1);
EOB=false;
codeword=[];
%% reading resual
while ~EOB
    currL=5;
    %currIdx
    while currL<50    
        %currL
        %size(bitstr)
        codeword=bitRe(currIdx+1:currIdx+currL);
        %codeword
        for i=1:dicl
            if(size(dict{i,2},2)==currL)
                if(isequal(bitRe(currIdx+1:currIdx+currL), dict{i,2}))
                    re(end+1,1)=dict{i,1}(1);
                    re(end,2) = dict{i,1}(2);
                    currIdx=currIdx+currL;
                    currL=50;
                    break
                end
            end
        end
        currL=currL+1;
    end
    if(currIdx==size(bitRe,2))
        EOB=true;
    end
end
%% reading motion vector
finish=0;
currIdx=0;
len=size(bitMv,2)
mv=[]
while finish==0
    codeword=bitMv(currIdx+1:currIdx+10)
    tmp=mv2bs(codeword,mv_codebook,'dec')
    mv=[mv tmp];
    currIdx=currIdx+10;
    if(currIdx>=len)
        finish=1;
        break
    end
    
end

end
   
