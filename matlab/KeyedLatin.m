function L = KeyedLatin(K,m)
%=============================================================
% FUNCTION: KeyedLatin
% -- Generates n Latin square of order d dependent on key K
% Output:
%       L = 256-by-256-by-m matrix, each of whose layer is a 256x256 Latin
%       square using the symbol set {1,2,...,256}
%=============================================================
%% Define LCG and LSG
% Linear Congruential Generatior (LCG) PRNG
a = 1664525;
c = 1013904223; % LCG parameters suggested in Numerical Recipe
LCG = @(q) mod(a.*q+c,2^32);
% Latin Square Generator (LSG) using Row-Shiftings
LSG_r = @(Qseed,v) mod(Qseed+v,256);
LSG = @(Qseed,Qshift) blkproc(Qshift,[1,1],@(v) LSG_r(Qseed,v));

%% Define Key Conversions 
% Convert Hex Key string to dec sequence
KeyHex2Bin = @(K) blkproc(K,[1,8],@(k) hex2dec(k));

%% Generate n Latin squares of order 256
KDec = KeyHex2Bin(K); % KDec is a 1x8 array
for n = 1:m
    for i = 1:64
        if i == 1
            q(i,:) = LCG(KDec);
        else
            q(i,:) = LCG(q(i-1,:)); 
        end
    end
    Q1 = [q(1:32,:)]; % a 256-element LCG squence
    Q2 = [q(33:64,:)];% a 256-element LCG squence
    KDec = q(end,:);  % update Key
    [tmp,Qseed] =  sort(Q1(:));
    [tmp,Qshift] = sort(Q2(:));
    L(:,:,n) = LSG(Qseed',Qshift);
end

    
    