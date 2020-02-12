%function [GOPDecodedFrames]=main_decoder(frameSize,nOfFrames,blockSize,noframes,dict)
quantizedFrames=[];

noframes=2;
blockSize=8;
frameSize=[288 352];

GOPDecodedFrames=[];
 q_mtx =     [16 11 10 16 24 40 51 61; 
             12 12 14 19 26 58 60 55;
             14 13 16 24 40 57 69 56; 
             14 17 22 29 51 87 80 62;
             18 22 37 56 68 109 103 77;
             24 35 55 64 81 104 113 92;
             49 64 78 87 103 121 120 101;
             72 92 95 98 112 100 103 99];

bitstreamIdx=1;
i=1;
seq=inverBitstream(bitstream,dict);
[quantizedFrames,currBitIdx]=iRLC(seq,blockSize,frameSize,dict,bitstreamIdx,noframes);
GOPDecodedFrames=zeros(size(quantizedFrames));
while i<3
    [rev_quantized_frames]=reverse_block_quantizer(quantizedFrames(:,:,i),blockSize,q_mtx);
    [tmp]=block_idct_frame(rev_quantized_frames,blockSize);
    GOPDecodedFrames(:,:,i)=tmp;
    i=i+1;
end
%% showing images
figure(1)
image(uint8(GOPDecodedFrames(:,:,1)));
colormap(gray(256));
%axis image
%pause(1/30);
%% compute psnr
distored=grayimg-GOPDecodedFrames(:,:,2);
psnr=10*log10(255*255*288*352/sum(sum((distored.*distored))))

