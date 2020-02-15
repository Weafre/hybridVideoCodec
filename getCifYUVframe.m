function [ grayscale] = getCifYUVframe(filename, k, gop)
%GETCIFYUVFRAME gets a frame from a CIF color (420) video file
%
%   ycbcr = getCifYUVframe(filename, k) gets the k-th image; The output
%   is in the YUV color space
%   [ycbcr rgb] = getCifYUVframe(filename, k) The second output is in
%   the RGB color space
%

%ycbcr=[];
%rgb=[];
grayscale=[];
fid = fopen(filename,'r');
if fid < 0, fprintf('File %s does not exist!\n', filename); return; 
end
rows = 288; cols = 352;
bytes_per_frame = rows * cols;
byte_shift_unit=bytes_per_frame*1.5;
byte_shift0 = byte_shift_unit*(k-1);
for i=0:gop-1
fseek(fid,byte_shift0+byte_shift_unit*i,'bof');
tmpY = fread(fid, [cols rows], 'uchar');
%tmpU = fread(fid, [cols/2 rows/2], 'uchar');
%tmpV = fread(fid, [cols/2 rows/2], 'uchar');

grayscale(:,:,i+1) = tmpY';
%[X, Y]=meshgrid(2:2:rows,2:2:cols); % tmpU sampling grid
%[XI, YI]=meshgrid(1:rows,1:cols);   % required sampling grid
%U=interp2(X,Y,tmpU,XI,YI);
%V=interp2(X,Y,tmpV,XI,YI);
%ycbcr(:,:,2,i+1) = U';
%ycbcr(:,:,3,i+1) = V';
%fclose(fid);

%if nargout>1
 %rgb(:,:,:,i+1) = colorTransform(ycbcr(:,:,:,i+1));
 %grayscale(:,:,i+1)=ycbcr(:,:,1,i+1);%rgb2gray(rgb(:,:,:,i+1));
%end
end

