function  [output_signal, rep_imp] = channel( input_signal )
%This function represents a model of the ADSL channel. 
%for a basic ADSL line, ie: 256 channels
    %INPUT: The frame that needs to be transmitted through the channel
    
    %OUTPUT: output_signal: the signal at the exit of the channel
    %        remp_imp: the impulsionnal response

%%
%Parameters of the line
    % frequency bandwith
    half_bandwidth = [0:1104000/256:1104000-(1104000/256)];
    bandwidth = [0:2208000/512:2208000-(2208000/512)];
    
    %Constants 
    perme_vide = 4*pi*10^-7 ;        %vacuum permeability u0
    permi_vide = 1/(36*pi)*10^-9 ;   %vacuum permitivity e0
    permi_rela = 2;                  %relative permitivity between the two isulators
    Te = 1/1104000;                  %sample time

    %parameters of the line
    d = 0.001           ;            % diameter of the wire
    D = 1.5*d            ;           % distance between the two wires
    permi = 2 * permi_vide ;         % permitivity of the line
    conduct = 5.65*10^7     ;        % conductivity of copper (1/resistivity)
    longueur = 3000;

    %primary parameters of the line
    L = (perme_vide/pi)*log(2*D/d);                                     %Linear Inductance
    C = (pi*permi_vide*permi_rela)/(log(2*D/d));                        %Linear capacity
    G = C*10^-3*2*pi*half_bandwidth;                                        %Linear conductance
    R = sqrt((perme_vide*half_bandwidth)/(pi*conduct))/(d*sqrt(1-(d/D)^2)); %Linear electrical resistance

    %Size of the number of discret samples
    tableau_temps = [0:1:511];   % We need not forget that when we want our impulse response we need the full period of 512 points. We therefor need to perform a hermetian symmetry to obtain a signal on 512 samples.
    tableau_temps2 = [0:1:255];
    
 %%
 
    %The gamma parameter
    gamma = sqrt(  (R + j*L*2*pi*half_bandwidth).*(G + j*C*2*pi*half_bandwidth)  );

    %Frequency response without reflection
    rep_freq = 1/2*exp(-gamma*longueur);

    %Frequency response with reflexion
    %rep_freq = 0.5 * (1 + 50/100) * exp(- gamma * longueur)  ./ (1 - 50/100 * 50/100 * exp(-2 * gamma * longueur));
%     figure;
%     plot(tableau_temps2*Te, abs(rep_freq));
   
    %Symetric frequency response
    rep_freq_sym = fliplr(conj(rep_freq));
    

    %Total frequency response
    rep_freq_tot = [rep_freq ,0 , rep_freq_sym(2:256)];
%     figure;
%     plot(tableau_temps*Te, abs(rep_freq_tot));

    %Impulsionnal response
    rep_imp = abs(ifft(rep_freq_tot));

%tracé en fonction des canaux
%plot(tableau_temps, rep_imp);

    %Impulsionnal response 
%     figure; 
%     plot(tableau_temps*Te, abs(rep_imp));
%     title('impulsionnal response');

    %convolution of the input signal with the impulsionnal response
    output_signal = filter(rep_imp, 1 , input_signal);
    
    %output_signal = conv(input_signal,rep_imp,'same')
    rep_imp_moitie = rep_imp(1:256);
    rep_freq_moitie = fft(rep_imp_moitie);
%     figure;
%     plot(half_bandwidth, abs(rep_freq_moitie));
%     title('impulsionnal response');
    
end

