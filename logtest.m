yourMsg = 'I am aghfghlive.';
fid = fopen('encodingLog.txt', 'a');
if fid == -1
  error('Cannot open log file.');
end
fprintf(fid, '%s: %s\n', datestr(now, 0), yourMsg);
fprintf(fid,'----Size of encoded video sequence:            %4.2f \n',67);
fclose(fid);