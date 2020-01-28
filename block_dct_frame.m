function f=block_dct_frame(x,blocksize)

% need to be modified to handle special cases, image size
% we could use f = blkproc(x, [blockSize blockSize], @dct2);



f=zeros(size(x));

for i=1:blocksize:size(x,1)-blocksize+1
        for j=1:blocksize:size(x,2)-blocksize+1
        f(i:i+blocksize-1,j:j+blocksize-1)=dct2(x(i:i+blocksize-1,j:j+blocksize-1));
        end
    
end
