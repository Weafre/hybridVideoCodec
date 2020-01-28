function [quantizedFrame]=iRLC(seq,blocksize,frSize)
quantizedFrame=[];
length=size(seq,1);
vBlock=0;
hBlock=0;
vBlockMax=frSize(2)/blocksize;
hBlockMax=frSize(1)/blocksize;
lastEnding=0;
for i=1:length
    if(seq(i,1)==0 && seq(i,2)==0)
        %sprintf('currently doing the block: %d %d \n',vBlock,hBlock)
        tmp=seq(lastEnding+1:i,:);
        iRLC=Run_length(tmp,'dec');
        izzMtrx=izigzag(iRLC,blocksize,blocksize);
        quantizedFrame(hBlock*blocksize+1:hBlock*blocksize+blocksize,vBlock*blocksize+1:vBlock*blocksize+blocksize) = izzMtrx;
        if(vBlock==vBlockMax-1)
            if(hBlock~=hBlockMax-1)
                vBlock=0;
                hBlock=hBlock+1;
            else
                return
            end
        else
            vBlock=vBlock+1;
        end
        lastEnding=i;
    end
    
end