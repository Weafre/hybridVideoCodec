function [mcFrame]=motionComp(re,mv,previousFrame,blocksize,frSize,dict)
[reFrame,~]=iRLC(re,blocksize,frSize,dict,1,1);
reFrame=reFrame(:,:,1);
size(reFrame)
mcFrame=zeros(size(reFrame));
mvIdx=1;
for i=0:blocksize:frSize(1)-blocksize
    for j=0:blocksize:frSize(2)-blocksize
        mcFrame(i+1:i+blocksize,j+1:j+blocksize)=reFrame(i+1:i+blocksize,j+1:j+blocksize)+mc_block(previousFrame,mv(mvIdx:mvIdx+1),blocksize,i+1,j+1);
        mvIdx=mvIdx+2;
    end
end

end