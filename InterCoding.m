function [bitstr]=InterCoding(currentFrame,r,c,ref_frame,blocksize,q_mtx,search,dict)
bitstr=[];
for i=1:blocksize:size(currentFrame,1)-blocksize+1
        for j=1:blocksize:size(currentFrame,2)-blocksize+1
        [bitstream_bl,~]=blockInterCoding(currentFrame(i:i+blocksize-1,j:j+blocksize-1),r,c , ref_frame,blocksize,q_mtx,search,dict);
         bitstr=[bitstr bitstream_bl];
        end
    
end
end






