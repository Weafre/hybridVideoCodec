%% Defining global variables
totalFrame=100;
numberOfFrames2Encode = 4;
GOP = 2;
startingFrame=1;
isRemainingFrame = true;
encodedFrame=0;
bitstream=[];
dict=load('dict.mat');
dict=dict.dict;
mv_codebook=load('mv_codebook.mat');
mv_codebook=mv_codebook.mv_codebook;
alpha=0;
search=1;%0 means full search, 1 mean 2dlog search
%% prepare log file
fid = fopen('encodingLog.txt', 'a');
if fid == -1
  error('Cannot open log file.');
end
fprintf(fid, '%s: %s  \n', datestr(now, 0),'START ENCODER');
fprintf(fid,'----Number of frame to encode:                 %d \n',numberOfFrames2Encode);
fprintf(fid,'----GOP Structure:                             %d \n',GOP);
fprintf(fid,'----Alpha:                                     %4.2f \n',alpha);
fprintf(fid,'----Search(0 for full search, 1 for 2D Log):   %d \n',search);



%% Encoding frames
tic;
while(isRemainingFrame)
if encodedFrame>=numberOfFrames2Encode
    sprintf('Encoding finished')
    isRemainingFrame=false;
else 
    [grayimg] = getCifYUVframe('videos/foreman_cif.yuv',startingFrame+encodedFrame,GOP);
    %grayimg=grayimg*255;
    %figure; imshow(gray);
    [GOP_bitstream,~,MSEs] = GOP_Encoder(grayimg,GOP,dict,mv_codebook,alpha,search,fid);
    sprintf('encoded frame %d',encodedFrame)
    bitstream=[bitstream GOP_bitstream];
    encodedFrame = encodedFrame + GOP;

end;
end
timeeslape=toc;
bitstream2=bitstream;

fprintf(fid, '%s: %s \n', datestr(now, 0), 'ENCODING FINISHED');
fprintf(fid,'----Size of encoded video(in k.byte):          %4.2f \n',size(bitstream,2)/8192);
fprintf(fid,'----Encoding duration(s):                      %4.2f \n',timeeslape);
fclose(fid);
%save bitstream;

