%% bit
bitstream=bitstream2;
noGOP=1;
GOPStructure=3;
qu_scale=1;
blockSize=8;
frameSize=[288 352];
noBlock=(frameSize(1)/blockSize) * (frameSize(2)/blockSize);
noBlock=floor(noBlock);

q_mtx =     [16 11 10 16 24 40 51 61; 
             12 12 14 19 26 58 60 55;
             14 13 16 24 40 57 69 56; 
             14 17 22 29 51 87 80 62;
             18 22 37 56 68 109 103 77;
             24 35 55 64 81 104 113 92;
             49 64 78 87 103 121 120 101;
             72 92 95 98 112 100 103 99];
q_mtx=q_mtx*qu_scale;

%dict=load('dict.mat');
%dict=dict.dict;
mv_codebook=load('mv_codebook14.mat');
mv_codebook=mv_codebook.mv_codebook;
GOPCount=0;

isRemainingGOP=true;
decodedFrames=[];
bitIdx=0;
%% GOP Decoder
while isRemainingGOP
    sprintf('Starting reading I Frame')
    GOPDecodedFrames=[];
    frCount=0;
    %Decode I frame
    [seq,currBitIdx]=inverBitstream(bitstream,bitIdx,noBlock,dict_first_sym,dict_second_sym);
    
    bitstream=bitstream(currBitIdx+1:end);
    bitIdx=0;
    [quantizedFrames,~]=iRLC(seq,blockSize,frameSize,1,1);
    [rev_quantized_frames]=reverse_block_quantizer(quantizedFrames(:,:,1),blockSize,q_mtx);
    [tmp]=block_idct_frame(rev_quantized_frames,blockSize);
    frCount=frCount+1;
    GOPDecodedFrames(:,:,frCount)=tmp;
    sprintf('Finished decoding I frame')
    %Decode P frame
    while frCount<GOPStructure
        %sprintf('starting decode frame %d',frCount,' of GOP %d', GOPCount)
        [GOPDecodedFrames(:,:,frCount+1),currBitIdx]=interDecoder(bitstream,q_mtx,GOPDecodedFrames(:,:,frCount),frameSize,blockSize,dict_first_sym,dict_second_sym,mv_codebook,noBlock);
        
        bitstream=bitstream(currBitIdx+1:end);
        
        bitIdx=0;
        frCount=frCount+1;
        sprintf('Finished decoding P frame')
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
title('Decoded frame');
%axis image
%pause(1/30);
%% compute psnr
%distored=grayimgs(:,:,2)-decodedFrames(:,:,2);
%psnr=10*log10(255*255*288*352/sum(sum((distored.*distored))))
%%
%mse=immse(grayimgs(:,:,1),decodedFrames(:,:,1))
%psnr=10*log10(255*255/mse)
