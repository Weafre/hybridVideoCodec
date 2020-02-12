function motcomp = mc_block(ref_frame,mv,blocksize,r,c)
        mc_r = r + mv(1);
        mc_c = c + mv(2);
        size(ref_frame(mc_r:mc_r+blocksize-1,mc_c:mc_c+blocksize-1));
        motcomp=ref_frame(mc_r:mc_r+blocksize-1,mc_c:mc_c+blocksize-1);
