function xq = qu(x,delta)
% QU Uniform quantization
%

%% Encoder
ind = floor(x/delta);

%% Decoder
xq = delta*ind + (delta/2); 