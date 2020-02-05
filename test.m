a=[0 1 1 0 1 0 1 0 ];

%a=dec2bin(student_id,16)
file = fopen('output.txt','wb');
fwrite(file,a,'uint8');
%fclose(file)
%array=fread('output.txt')