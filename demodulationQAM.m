function [dataOut] = demodulationQAM(dataCanal, type_QAM_bits_allocation,i)

% dataCanal = symb�les re�us apr�s d�modulation DMT
% type_QAM_bits_allocation : vecteur colonne contenant le type de QAM donn� par bit-allocation
% i : num�ro du canal que l'on traite

nb_bits_symbole = log2(type_QAM_bits_allocation(i));
signal_demod = qamdemod(dataCanal,type_QAM_bits_allocation(i));
dataOutMatrix = de2bi(signal_demod,nb_bits_symbole);
dataOut = dataOutMatrix(:);


end
