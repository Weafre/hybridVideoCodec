function [seq]=inverBitstream(bit, dict)
seq=[];
currIdx=1;
currL=4;
dicl=size(dict,1);
EOB=false;
while(~EOB)
for i=1:dicl
    if(sum(bit(currIdx+1:currIdx+currL)==dict{i,2})==currL)
        [seq(end+1,1),seq(end+1,2)] = dict{i,1};
        currIdx=currIdx+currL;

        currL=4;
        break
    else
        currL=currL+1;
        i=1;

    end
        if(currIdx==size(bit,2)
            return
        end
end