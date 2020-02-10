function [bit]= genBitstream(seq, dict)
sql=size(seq,1);
dicl=size(dict,1);
bit=boolean([]);
for i=1:sql
    if(seq(i,2)>120)
        seq(i,2)=119;
    end
    for j=1:dicl
        if(sum(seq(i,:)==dict{j,1})== 2) 
            bit=cat(2,bit,dict{j,2});
            %bit(end+1:end+size(dict{j,2})+1)=dict{j,2}
            break   
        end
   end
end