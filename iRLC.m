function [quantizedFrame]=iRLC(seq,blocksize,frSize)
quantizedFrame=[];
length=size(seq,2);
vBlock=0;
hBlock=0;
vBlockMax=frSize(2);
hBlockMax=frSize(1);
for i=1:length
if(seq(i,1)==0 && seq(i,2)==0)
    tmp=seq(1:i,:);
    iRLC=Run_length(tmp,'dec');
    izzMtrx=izigzag(iRLC,blocksize,blocksize);
    if(vBlock==vBlockmax)
        vBlock=1;
        hBlock=hBlock+1;
    else
        vBlock=vBlock+1;
    quantizedFrame[hBlock*blocksize:hBlock*blocksize+blocksize,vBlock*blocksize:vBlock*blocksize+blocksize] = izzMtrx;
    
    end
end