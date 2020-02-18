function [bitstream,decodedFrames,MSEs_X] = GOP_Encoder(frames,GOP,dict,mv_codebook,alpha,search,fid)

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
decodedFrames=zeros(size(frames));
MSEs_X=zeros(GOP);
bitstream=[];
blocksize=8;

while(isRemainingGOPFrame)
    currentFrameIdx=encodedFrame+1;
    
    if(encodedFrame == 0)
        [bitIntra,decodedFrames(:,:,currentFrameIdx),MSEs_X(currentFrameIdx)] = IntraCoding(frames(:,:,currentFrameIdx),8,q_mtx,dict);
        encodedFrame = encodedFrame+1;
        bitstream=[bitstream bitIntra];
        fprintf(fid,'----Size of I frame (in k.byte):               %4.2f \n',size(bitIntra,2)/8192);
        sprintf('finished intra')
    else 
        [bitRe, bitMv,bitFlag,decodedFrames(:,:,currentFrameIdx),MSEs_X(currentFrameIdx)]=InterCoding(frames(:,:,currentFrameIdx),decodedFrames(:,:,currentFrameIdx-1),blocksize,q_mtx,search,dict,mv_codebook,alpha);
        encodedFrame = encodedFrame+1;
        bitstream=[bitstream bitFlag bitMv bitRe];
        
        fprintf(fid,'----Size of P frame (in k.byte):               %4.2f \n',(size(bitFlag,2)+size(bitMv,2)+size(bitRe,2))/8192);
        %bitFlag(1:100)
        %sprintf('finished 1 inter')
    end
    if(encodedFrame==GOP)
        isRemainingGOPFrame = false;
    end

    end
end
%GOP_Bitstream = quantized_frame;