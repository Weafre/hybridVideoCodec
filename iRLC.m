function [quantizedFrames,currseqIdx]=iRLC(seq,blocksize,frSize,seqIdx,numberOfFr)
%[quantizedFrs,currbit]=iRLC(seq,8,[288 352],1,3);
quantizedFrames=[];
vBlock=0;
hBlock=0;
vBlockMax=frSize(2)/blocksize;
hBlockMax=frSize(1)/blocksize;
lastEnding=0;

length=size(seq,1);
frIdx=0;
isRemainingFrame=true;
currseqIdx=0;
%sprintf('starting decoding')
for i=seqIdx:length
        if(seq(i,1)==0 && seq(i,2)==0)
            currseqIdx=i+1;
            %sprintf('currently doing the block: %d %d \n',vBlock,hBlock)
            tmp=seq(lastEnding+1:i,:);
            iRLC=Run_length(tmp,'dec');
            izzMtrx=izigzag(iRLC,blocksize,blocksize);
            quantizedFrames(hBlock*blocksize+1:hBlock*blocksize+blocksize,vBlock*blocksize+1:vBlock*blocksize+blocksize,frIdx+1) = izzMtrx;
            if(vBlock==vBlockMax-1)
                if(hBlock~=hBlockMax-1)
                    vBlock=0;
                    hBlock=hBlock+1;
                else
                    if(frIdx+1==numberOfFr)
                        break
                    else
                        frIdx=frIdx+1
                        vBlock=0;
                        hBlock=0;
                        
                    end;
                    
                end
            else
                vBlock=vBlock+1;
            end
            lastEnding=i;
    end
    
end
end