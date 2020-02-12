function mvbit= mv2bs(mv,codebook,type)
if(type == 'enc')
    mvbit=[ codebook(codebook(:,1)==mv(1),2:end) codebook(codebook(:,1)==mv(2),2:end) ];
end
if(type == 'dec')
    mvbit=zeros(1,2);
    for i=1:17
        if(isequal(codebook(i,2:6),mv(1:5)))
            mvbit(1)=codebook(i,1);
        end
        if(isequal(codebook(i,2:6),mv(6:10)))
            mvbit(2)=codebook(i,1);
        end
      
    end
    %mv
    %mvbit=[ codebook(isequal(codebook(:,2:6),mv(1:5)),1)  codebook(isequal(codebook(:,2:6),mv(6:10)),1) ];
end

end