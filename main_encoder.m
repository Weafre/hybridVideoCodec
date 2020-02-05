%% Defining global variables
totalFrame=100;
numberOfFrames2Encode = 1;
GOP = 1;
startingFrame=1;
isRemainingFrame = true;
encodedFrame=0;
bitstream=[];
dict=load('dict.mat');
dict=dict.dict;
%% Encoding frames
while(isRemainingFrame)
if encodedFrame+GOP>numberOfFrames2Encode
    sprintf('Encoding finished')
    isRemainingFrame=false;
else 
[grayimg] = getCifYUVframe('videos/foreman_cif.yuv',startingFrame+encodedFrame,GOP);
%grayimg=grayimg*255;
%figure; imshow(gray);
[GOP_bitstream] = GOP_Encoder(grayimg,GOP,dict);
sprintf('encoding frame %d',encodedFrame)
bitstream=[bitstream GOP_bitstream];
encodedFrame = encodedFrame + GOP;

end;
end
save bitstream;

