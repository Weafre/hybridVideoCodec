function [sym]=Run_length(S,type)
%n=sum(sym(:,1))+size(sym,1)
if type =='enc'
    alphabet=[];
    nb_sym=[];
    sym=[];
    m=1;
    for i=1:length(S)
        if S(i)==0
            m=m+1;
            if(m>63)
                nb_sym(end+1)=m-1;
                alphabet(end+1)=S(i);
                sym(end+1,1)=0;sym(end,2)=S(i);
                return
            end
        else
            
            nb_sym(end+1)=m-1;
            alphabet(end+1)=S(i);
            sym(end+1,1)=m-1;sym(end,2)=S(i);
            m=1;
        end
        
    end
   
    alphabet(end+1)=S(end);
    nb_sym(end+1)=m-1;
    sym(end+1,1)=0;sym(end,2)=0;
    
else
    %n=sum(S(:,1))+size(S,1)-1;
    n=65;
    sym=zeros(1,n);
    idx2=[];
    for i=1:size(S,1)
        for j=1:S(i,1)
            idx2(end+1)=0;
        end
        idx2(end+1)=S(i,2);
    end
    sym(1:length(idx2))=idx2;
    sym=sym(1:n-1);
end