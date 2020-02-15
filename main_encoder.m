%% Defining global variables
totalFrame=100;
numberOfFrames2Encode = 2;
GOP = 2;
startingFrame=1;
isRemainingFrame = true;
encodedFrame=0;
bitstream=[];
dict=load('dict.mat');
dict=dict.dict;
mv_codebook=load('mv_codebook.mat');
mv_codebook=mv_codebook.mv_codebook;
alpha=1000;
search=8;
%% Encoding frames
while(isRemainingFrame)
if encodedFrame>=numberOfFrames2Encode
    sprintf('Encoding finished')
    isRemainingFrame=false;
else 
    [grayimg] = getCifYUVframe('videos/foreman_cif.yuv',startingFrame+encodedFrame,GOP);
    %grayimg=grayimg*255;
    %figure; imshow(gray);
    [GOP_bitstream,~,MSEs] = GOP_Encoder(grayimg,GOP,dict,mv_codebook,alpha,search);
    sprintf('encoded frame %d',encodedFrame)
    bitstream=[bitstream GOP_bitstream];
    encodedFrame = encodedFrame + GOP;

end;
end
save bitstream;

