function [interFrame,currIdx]=interDecoder(bitstream,q_mtx,ref_frame,frameSize,blockSize,dict,mv_codebook,noBlock)

bitIdx =0;

flags=bitstream(bitIdx+1:bitIdx+noBlock);
vMax=uint8(frameSize(1)/blockSize);
hMax=uint8(frameSize(2)/blockSize);
currIdx=bitIdx+noBlock;
mv=[];
re=[];
for i=1:noBlock
    if(flags(i)==0)
        continue
    elseif(flags(i)==1)
        mv(end+1,:)=mv2bs(bitstream(1,currIdx+1:currIdx+10),mv_codebook,'dec');
        currIdx=currIdx+10;
    end
end
%sprintf('finshed reading mv %d', currIdx/10)

blockCount=0;
mvCount=0;
interFrame=zeros(frameSize);
for i=1:blockSize:frameSize(1)-blockSize+1
        for j=1:blockSize:frameSize(2)-blockSize+1

            if(flags(blockCount+1)==0)
                
                %convert from bit stream to pair sequence
                [seq,id]=inverBitstream(bitstream,dict,1,currIdx);
                currIdx=id;
                %sequence to quantized block
                [quantizedBlock,~]=iRLC(seq,blockSize,[blockSize blockSize],dict,1,1);
                %reverse quantization
                [rev_quantized_block]=reverse_block_quantizer(quantizedBlock(:,:,1),blockSize,q_mtx);
                %invert dct
                [tmp]=block_idct_frame(rev_quantized_block,blockSize);
                interFrame(i:i+blockSize-1,j:j+blockSize-1)=tmp;
                blockCount=blockCount+1;
            else
                %compute resual
                [seq,id]=inverBitstream(bitstream,dict,1,currIdx);
                currIdx=id;
                [quantizedRe,~]=iRLC(seq,blockSize,[blockSize blockSize],dict,1,1);
                [rev_quantized_Re]=reverse_block_quantizer(quantizedRe(:,:,1),blockSize,q_mtx);
                [Resual]=block_idct_frame(rev_quantized_Re,blockSize);
                %obtain mc block from ref frame
                [reBlock]=mc_block(ref_frame,mv(mvCount+1,:),blockSize,i,j);
                %block=resual +motion compensated block
                size(Resual);
                size(reBlock);
                interFrame(i:i+blockSize-1,j:j+blockSize-1)=Resual+reBlock;
                mvCount=mvCount+1;
                blockCount=blockCount+1;
            end
        end
    
end
sprintf('finshed decoding frame')
end