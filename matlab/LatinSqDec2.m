function P = LatinSqDec2(C,K)

%% Initial Settings
C = double(C);


% Generate Key-dependent 256x256 Latin Squares
L = KeyedLatin(K,9);

%% Cipher rounds
for i = 8:-1:1
    % Extract a Keyed Latin Square
    tL = L(:,:,i);
    if i == 8
        CW = LatinSq_Whitening(C,L(:,:,9),'decryption');
    end
    % Latin Square Permutation
    CP = LatinSq_Permutation(CW,tL,'decryption');
    % Latin Square Substitution
    if mod(i,2) == 0
        CS = LatinSq_Substitution(CP,tL,'row','decryption');
    else
        CS = LatinSq_Substitution(CP,tL,'col','decryption');
    end
    % Latin Square Whitening
    CW = LatinSq_Whitening(CS,tL,'decryption');
end

P = CW;
