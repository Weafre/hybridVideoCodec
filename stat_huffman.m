
%%
first_sym = seq(:,1);
second_sym = seq(:,2);

range_first = 0:64;
p_first = ones(1,length(range_first))./length(range_first);

h = hist(first_sym,range_first);
p_first = p_first + h./sum(h);

p_first = p_first./sum(p_first);

[code_first,~]=huffmandict(range_first,p_first);
dict_first_sym = {};
for i = 1:length(range_first)
    

dict_first_sym{i,1} = range_first(i);
dict_first_sym{i,2} = code_first{i,2};

end 
figure;
bar(range_first,p_first)
xlabel('Symbol')
ylabel('Probability')

% figure;
% hist(first_sym,range_first)
title ('First symbol');

entrop(p_first)
%% Second symbol

range_second = -512:512;
p_second = ones(1,length(range_second))./length(range_second);

h_second = hist(second_sym,range_second);
p_second = p_second + h_second./sum(h_second);

p_second = p_second./sum(p_second);


[code_second,~]=huffmandict(range_second,p_second);
dict_second_sym = {};
for i = 1:length(range_second)
    

dict_second_sym{i,1} = range_second(i);
dict_second_sym{i,2} = code_second{i,2}();

end 




figure;
bar(range_second,p_second)
xlabel('Symbol')
ylabel('Probability')

% figure;
% hist(second_sym)
title ('Second symbol');

entrop(p_second)





