function output = LatinSq_Substitution(input,L,opt1,opt2)
%=============================================================
% FUNCTION: LatinSq_Subsititution
% -- Subsititute bytes with bytes in a chain-like way
% Input:
%       input = a 256x256 matrix, 
%           L = a 256x256 Latin square with symbol set {0,1,...,255}
%        opt1 = 'row'/'column' substitutions
%        opt2 = 'encryption'/'decryption'
% Ouptut:
%      output = a 256x256 matrix
if ~exist('opt2','var')
    opt2 = 'encryption';
end

switch opt2
    case 'encryption'
        switch opt1
            case 'row'
                for i = 1:256
                    if i == 1
                        output(i,:) = L(1,input(i,:)+1);
                    else
                        idx = sub2ind([256,256],output(i-1,:)+1,input(i,:)+1);
                        output(i,:) = L(idx);
                    end
                end
            case 'col'
                for i = 1:256
                    if i == 1
                        output(:,i) = L(input(:,i)+1,1);
                    else
                        idx = sub2ind([256,256],input(:,i)+1,output(:,i-1)+1);
                        output(:,i) = L(idx);
                    end
                end
        end
    case 'decryption'
        switch opt1
            case 'row'
                LR = zeros(256);
                for i = 1:256
                    LR(i,L(i,:)+1) = 0:255;
                end
                for i = 256:-1:1
                    if i == 1
                        idx = sub2ind([256,256],ones(1,256),input(i,:)+1);
                        output(i,:) = LR(idx);
                    else
                        idx = sub2ind([256,256],input(i-1,:)+1,input(i,:)+1);
                        output(i,:) = LR(idx);
                    end
                end
            case 'col'
                LC = zeros(256);
                for i = 1:256
                    LC(L(:,i)+1,i) = 0:255;
                end
                for i = 256:-1:1
                    if i == 1
                        idx = sub2ind([256,256],input(:,i)+1,ones(256,1));
                        output(:,i) = LC(idx);
                    else
                        idx = sub2ind([256,256],input(:,i)+1,input(:,i-1)+1);
                        output(:,i) = LC(idx);
                    end
                end
        end
end
        
        