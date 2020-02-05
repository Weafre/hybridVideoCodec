function [bitstream,quantized_frames] = GOP_Encoder(frames,GOP,dict)

isRemainingGOPFrame=true;
encodedFrame=0;
% block quantization matrix
 q_mtx =     [16 11 10 16 24 40 51 61; 
             12 12 14 19 26 58 60 55;
             14 13 16 24 40 57 69 56; 
             14 17 22 29 51 87 80 62;
             18 22 37 56 68 109 103 77;
             24 35 55 64 81 104 113 92;
             49 64 78 87 103 121 120 101;
             72 92 95 98 112 100 103 99];
quantized_frames=zeros(size(frames));
MSEs_X=zeros(GOP);

while(isRemainingGOPFrame)
    currentFrameIdx=encodedFrame+1;
    
    if(encodedFrame == 0)
        [bitstream,quantized_frames(:,:,currentFrameIdx),MSEs_X(currentFrameIdx)] = IntraCoding(frames(:,:,currentFrameIdx),8,q_mtx,dict);
        encodedFrame = currentFrameIdx;
    else 
        interCoding(frames(currentFrameIdx));
        encodedFrame = encodedFrame+1;
    end;
    if(encodedFrame==GOP)
        isRemainingGOPFrame = false;
    end;

end;
%GOP_Bitstream = quantized_frame;