function [GOP_Bitstream] = GOP_Encoder(frames,GOP)

isRemainingGOPFrame=true;
encodedFrame=0;

while(isRemainingGOPFrame)
    currentFrameIdx=encodedFrame+1;
    
    if(encodedFrame == 0)
        intraCoding(frames(currentFrameIdx));
        encodedFrame = currentFrameIdx;
    else 
        interCoding(frames(currentFrameIdx));
        encodedFrame = encodedFrameIdx+1;
    end;
    if(encodedFrame==GOP)
        isRemainingGOPFrame = false;
    end;
GOP_Bitstream=1;
end;