function [bitRe, bitMv,bitFlag,decodedFrame,MSE]=InterCoding(currentFrame,ref_frame,blocksize,q_mtx,search,dict_first_sym,dict_second_sym,mv_codebook,alpha)
bitRe=[];
bitMv=[];
bitFlag=[];
decodedFrame=zeros(size(currentFrame));

for i=1:blocksize:size(currentFrame,1)-blocksize+1
        
        for j=1:blocksize:size(currentFrame,2)-blocksize+1
            
        [bitstream_re,bitstr_mv, Flag, block]=blockInterCoding(currentFrame(i:i+blocksize-1,j:j+blocksize-1),i,j , ref_frame,blocksize,q_mtx,search,dict_first_sym,dict_second_sym,mv_codebook,alpha);
         decodedFrame(i:i+blocksize-1,j:j+blocksize-1)=block;
         
         bitRe=[bitRe bitstream_re];
         bitMv=[bitMv bitstr_mv];
         bitFlag=[bitFlag Flag];
        end
    
end

%imshow(decodedFrame()/255)

%decodedFrame(1:10,1:10)
%colormap(gray(256));
MSE=immse(currentFrame(:),decodedFrame(:));
%MSE=mean( (currentFrame(:)-decodedFrame(:)).^2);
end






