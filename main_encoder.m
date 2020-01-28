%% Defining global variables
totalFrame=100;
numberOfFrames2Encode = 50;
GOP = 6;
startingFrame=1;
isRemainingFrame = true;
encodedFrame=0;
%% Encoding frames
while(isRemainingFrame)
if encodedFrame+GOP>totalFrame
    sprintf('Encoding finished')
    isRemainingFrame=false;
else 
[ycbcr,rgb,grayimg] = getCifYUVframe('videos/foreman_cif.yuv',startingFrame+encodedFrame,GOP);
grayimg=grayimg*255;
%figure; imshow(gray);
[GOP_bitstream,MSEs_X] = GOP_Encoder(grayimg,GOP);
encodedFrame = encodedFrame + GOP;
%figure(1)
%image(uint8(main_decoder(GOP_bitstream(:,:,1),8,GOP)));
%colormap(gray(256));
%axis image
%pause(1/30);
end;
end


