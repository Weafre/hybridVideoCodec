%% Defining global variables
totalFrame=100;
numberOfFrames2Encode = 50;
GOP = 1;
startingFrame=1;
isRemainingFrame = true;
encodedFrame=0;
%% Encoding frames
while(isRemainingFrame)
if encodedFrame+GOP>totalFrame
    print("Encoding finished \n");
    isRemainingFrame=false;
else 
[ycbcr,rgb,gray] = getCifYUVframe('videos/foreman_cif.yuv',startingFrame+encodedFrame,GOP);
GOPBitstream = GOP_Encoder(gray,GOP);
encodedFrame = encodedFrame + GOP;
end;
end
