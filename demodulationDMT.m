function [suite_symboles_out] = demodulationDMT(signal_recu)

% signal_recu = signal re�u apr�s passage dans le canal
   
%% Suppression complexe conjugu� + pr�fixe cyclique %%
%signal_recu=signal_recu(v+1:2*N+v);
 
%% FFT %%
suite_symboles_out = fft(signal_recu);
    
%% Egalisation %%
%signal_fft = x./h_eval_mod; % �galisation
    

end
