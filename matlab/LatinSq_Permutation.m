function output = LatinSq_Permutation(input,L,opt)
%=============================================================
% FUNCTION: LatinSq_Permutation
% -- Permutate image pixels 
% Input:
%       input = a 256x256 matrix, 
%           L = a 256x256 Latin square with symbol set {0,1,...,255}
%         opt = 'encryption'/'decryption'
% Ouptut:
%      output = a 256x256 matrix
%=============================================================
if ~exist('opt','var')
    opt = 'encryption';
end

switch opt
    case 'encryption'
        % row permutations
        for i = 1:256
            tmp(i,:) = input(i,L(i,:)+1);
        end
        % column permutations
        for i = 1:256
            output(:,i) = tmp(L(:,i)+1,i);
        end

    case 'decryption'
        % column permutations
        for i = 1:256
            tmp(L(:,i)+1,i) = input(1:256,i);
        end
        % row permutations
        for i = 1:256
            output(i,L(i,:)+1) = tmp(i,1:256);
        end
                
end
        
        