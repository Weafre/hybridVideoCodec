function [bit]= genBitstream(seq, dict_first_sym,dict_second_sym)
sql=size(seq,1);
dicl=size(dict_first_sym,1);
dic2=size(dict_second_sym,1);
bit=boolean([]);
for i=1:sql
    if(seq(i,2)>255)
        seq(i,2)=255;
    end
    if(seq(i,2)< -255)
        seq(i,2)= -255;
    end
    
    
    for j=1:dicl
        if(seq(i,1)==dict_first_sym{j,1}) 
            bit=cat(2,bit,dict_first_sym{j,2});
            %bit(end+1:end+size(dict{j,2})+1)=dict{j,2}
            break   
        end
    end
    for j=1:dic2
        if(seq(i,2)==dict_second_sym{j,1}) 
            bit=cat(2,bit,dict_second_sym{j,2});
            %bit(end+1:end+size(dict{j,2})+1)=dict{j,2}
            break   
        end
        
    end
   
    
    
    
end