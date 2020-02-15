function motcomp = mc_block(ref_frame,mv,blocksize,r,c)
        
        mc_r = r + mv(1);
        mc_c = c + mv(2);
        if(mc_r<0 ||mc_r+blocksize-1>288||mc_c<0||mc_c+blocksize-1>352)
            sprintf('exeed size when doing motion compensation')
            mc_r
            mc_c
        end
        %size(ref_frame(mc_r:mc_r+blocksize-1,mc_c:mc_c+blocksize-1));
        motcomp=ref_frame(mc_r:mc_r+blocksize-1,mc_c:mc_c+blocksize-1);
        
end
