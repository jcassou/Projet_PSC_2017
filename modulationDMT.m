function [data_reel] = modulationDMT(data_qam)

%% Concernant les variables %%
% data_qam : symboles QAM en colonne

data_dmt = ifft(data_qam);

%% Transformation en signal r�el %%
len = length(data_dmt);
data_reel = zeros(2*len,1);
j = 1;

for i=1:len
    data_reel(j) = data_dmt(i);
    data_reel(j+1) = 0;
    j = j+2;
end

for i=1:2:2*len
    data_reel(i+1) = imag(data_reel(i));
    data_reel(i) = real(data_reel(i));
end

end
