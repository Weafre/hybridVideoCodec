%% Defining global variables
totalFrame=100;
numberOfFrames2Encode = 5;
GOP = 5;
startingFrame=2;
isRemainingFrame = true;
encodedFrame=0;
bitstream=[];
mv_codebook=load('mv_codebook14.mat');
mv_codebook=mv_codebook.mv_codebook;
alpha=20;
search=0;%0 means full search, 1 mean 2dlog search
qu_scale=1;
frameSize=[288,352];
%% prepare log file
fid = fopen('encodingLog2.txt', 'a');
if fid == -1
  error('Cannot open log file.');
end
fprintf(fid, '%s: %s  \n', datestr(now, 0),'START ENCODER');
fprintf(fid,'----Number of frame to encode:                 %d \n',numberOfFrames2Encode);
fprintf(fid,'----Frame Size:                                %d %d \n',frameSize(1),frameSize(2));
fprintf(fid,'----GOP Structure:                             %d \n',GOP);
fprintf(fid,'----Alpha:                                     %4.2f \n',alpha);
fprintf(fid,'----Search(0 for full search, 1 for 2D Log):   %d \n',search);
fprintf(fid,'----Quantization scale:                        %d \n',qu_scale);
fprintf(fid,'----Size of frame(k.byte)        PSNR\n');
                                            

%% Encoding frames
tic;
while(isRemainingFrame)
if encodedFrame>=numberOfFrames2Encode
    sprintf('Encoding finished')
    isRemainingFrame=false;
else 
    [grayimgs] = getCifYUVframe('videos/foreman_cif.yuv',startingFrame+encodedFrame,GOP,frameSize);
    [GOP_bitstream,~,MSEs] = GOP_Encoder(grayimgs,GOP,dict_first_sym,dict_second_sym,mv_codebook,alpha,search,fid,qu_scale);
    encodedFrame = encodedFrame + GOP;
    sprintf('Encoded frame: %d',encodedFrame)
    bitstream=[bitstream GOP_bitstream];
    

end;
end
timeeslape=toc;
bitstream2=bitstream;

fprintf(fid,'----Size of encoded video(in k.byte):          %4.2f \n',size(bitstream,2)/8192);
fprintf(fid,'----Encoding duration(s):                      %4.2f \n',timeeslape);
fprintf(fid, '%s: %s \n', datestr(now, 0), 'ENCODING FINISHED');
fclose(fid);
%%
save bitstream;

