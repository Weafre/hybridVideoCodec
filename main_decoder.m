noGOP=3;
blockSize=8;
frameSize=[288 352];
noBlock=uint8(frameSize(1)*frameSize(2)/(blockSize*blockSize));
q_mtx =     [16 11 10 16 24 40 51 61; 
             12 12 14 19 26 58 60 55;
             14 13 16 24 40 57 69 56; 
             14 17 22 29 51 87 80 62;
             18 22 37 56 68 109 103 77;
             24 35 55 64 81 104 113 92;
             49 64 78 87 103 121 120 101;
             72 92 95 98 112 100 103 99];

bitstreamIdx=1;
dict=load('dict.mat');
dict=dict.dict;
mv_codebook=load('mv_codebook.mat');
mv_codebook=mv_codebook.mv_codebook;
GOPCount=0;
GOPStructure=1;
isRemainingGOP=true;
DecodedFrames=[];
%% GOP Decoder
while isRemainingGOP
    GOPDecodedFrames=[];
    frCount=0;
    %Decode I frame
    seq=inverBitstream(bitstream,dict,frameSize,blocksize);
    [quantizedFrames,currBitIdx]=iRLC(seq,blockSize,frameSize,dict,bitstreamIdx,1);
    [rev_quantized_frames]=reverse_block_quantizer(quantizedFrames(:,:,1),blockSize,q_mtx);
    [tmp]=block_idct_frame(rev_quantized_frames,blockSize);
    frCount=frCount+1;
    GOPDecodedFrames(:,:,frCount)=tmp;
    %Decode P frame
    while frCount<GOPStructure
        
    end
    if(frCount==GOPStructure)
        decodedFrames(:,:,GOPCount*GOPStructure+1:GOPCount*GOPStructure+GOPStructure)=GOPDecodedFrames;
        GOPCount=GOPCount+1;
        
    end
    if(GOPCount==noGOP)
        isRemainingGOP=0;
    end
    
end
%% showing images
figure(1)
image(uint8(decodedFrames(:,:,3)));
colormap(gray(256));
%axis image
%pause(1/30);
%% compute psnr
%distored=grayimg-GOPDecodedFrames(:,:,2);
%psnr=10*log10(255*255*288*352/sum(sum((distored.*distored))))

