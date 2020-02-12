function [dict]=codebook(ma)

    % Generation du dictionnaire

    dict={};

    id=(1:ma);

    a=3;
    b=1;
    
    val=10;
    for i=0:val
        for j=1:length(id)

            dict{end+1,1}=[i id(j)-1];
            dict{end,2}=(a*i*ma+b*id(j)*val)/(a*val*ma+b*ma*val);

            dict{end+1,1}=[i -id(j)];
            dict{end,2}=(a*i*ma+b*id(j)*val)/(a*val*ma+b*ma*val);

        end
    end
  
    p=[dict{:,2}]*ma;
    p=(1.35.^(p));
    [p,ind]=sort(p);

    % Huffman
    code=huffmandict((1:size(dict,1)),p./sum(p));
    for i=1:size(dict,1)
        code{i,1}=dict{ind(i),1};
        dict{i,2}=code{size(dict,1)-i+1,2};
    end
  
    %sort dico
    for i=1:size(dict,1)
        dict{i,1}=code{i,1};
    end
    
    while 1
    u=0;
    for i=2:size(dict,1)
        if length(dict{i,2})<length(dict{i-1,2})
            memory=dict{i,1};
            dict{i,1}=dict{i-1,1};
            dict{i-1,1}=memory;

            memory=dict{i,2};
            dict{i,2}=dict{i-1,2};
            dict{i-1,2}=memory;
            u=1;
        end
    end
    if u==0
        break
    end
    end
    
end