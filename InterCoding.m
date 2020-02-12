function [bitRe, bitMv]=InterCoding(currentFrame,ref_frame,blocksize,q_mtx,search,dict,mv_codebook)
bitRe=[];
bitMv=[];
for i=1:blocksize:size(currentFrame,1)-blocksize+1
        for j=1:blocksize:size(currentFrame,2)-blocksize+1
        [bitstream_re,bitstr_mv]=blockInterCoding(currentFrame(i:i+blocksize-1,j:j+blocksize-1),i,j , ref_frame,blocksize,q_mtx,search,dict,mv_codebook);
         bitRe=[bitRe bitstream_re];
         bitMv=[bitMv bitstr_mv];
        end
    
end
end






