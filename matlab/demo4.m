function demo4(N,X)

%% 1. Encryption and Decryption Speed
imshow(N);
M = imread(N); %<--------- replace any of your interested 256x256 images here
[rows columns numberOfColorChannels] = size(M);
if numberOfColorChannels > 1
    P = rgb2gray(M);
   
else
    P = M;
end
str = strcat('C:\wamp\www\bhavya\resultimages\gray', X)
imwrite(P, str, 'jpg');
K = RandomKey;
tic
%imwrite(P, 'a22.jpg', 'jpg');
C = LatinSqEnc2(double(P),K);
t(1,1) = toc
tic
%imwrite(P, 'a32.jpg', 'jpg');
D = LatinSqDec2(C,K);
t(1,2) = toc
str = strcat('C:\wamp\www\bhavya\resultimages\cipher1', X)
str1 = strcat('C:\wamp\www\bhavya\resultimages\decipher1', X)
imwrite(uint8(C), str, 'jpg');
imwrite(uint8(D), str1, 'jpg');
figure(1),subplot(2,3,1),imshow(P,[]),title('Plaintext Image P')
subplot(2,3,2),imshow(C,[]),title('Ciphertext Image C = Enc(P,K)')
subplot(2,3,3),imshow(D,[]),title('Deciphertext Image D = Dec(C,K)' )
subplot(2,3,4),imhist(uint8(P)),title('Histogram of P')
subplot(2,3,5),imhist(uint8(C)),title('Histogram of C')
subplot(2,3,6),imhist(uint8(D)),title('Histogram of D')

%% 2. Probabilistic Encryption
C2 = LatinSqEnc2(double(P),K);
D2 = LatinSqDec2(C2,K);
str = strcat('C:\wamp\www\bhavya\resultimages\cipher2', X)
str1 = strcat('C:\wamp\www\bhavya\resultimages\decipher2', X)
imwrite(uint8(C2), str, 'jpg');
imwrite(uint8(D2), str1, 'jpg');
%imwrite(P, 'b12.jpg', 'jpg');
figure(2),subplot(2,4,1),imshow(C,[]),title('Ciphertext Image C_1')
subplot(2,4,2),imshow(C2,[]),title('Ciphertext Image C_2')
subplot(2,4,3),imshow(imabsdiff(C,C2),[]),title('|C_1-C_2|')
subplot(2,4,4),imhist(uint8(imabsdiff(C,C2))),title('Histogram of |C_1-C_2|'),axis square
subplot(2,4,5),imshow(D,[]),title('Deciphertext Image D_1')
subplot(2,4,6),imshow(D2,[]),title('Deciphertext Image D_2')
subplot(2,4,7),imshow(imabsdiff(D,D2),[]),title('|D_1-D_2|')
subplot(2,4,8),imhist(uint8(imabsdiff(D,D2))),title('Histogram of |D_1-D_2|'),axis square

%% 3. Robustness to Noise in Ciphertext
r = round(rand(1)*65536);
Cn = C;
Cn(r) = 0;
Dn = LatinSqDec2(Cn,K);

Cn2 = C;
Cn2(125:135,125:135) = 0;
Dn2 = LatinSqDec2(Cn2,K);
str = strcat('C:\wamp\www\bhavya\resultimages\cipher3', X)
str1 = strcat('C:\wamp\www\bhavya\resultimages\decipher3', X)
str2 = strcat('C:\wamp\www\bhavya\resultimages\cipher31', X)
str3 = strcat('C:\wamp\www\bhavya\resultimages\decipher31', X)
imwrite(uint8(Cn), str, 'jpg');
imwrite(uint8(Dn), str1, 'jpg');
imwrite(uint8(Cn2), str2, 'jpg');
imwrite(uint8(Dn2), str3, 'jpg');
figure(3),subplot(2,3,1),imshow(P,[]),title('Plaintext Image P')
subplot(2,3,2),imshow(Cn,[]),title('Noisy Ciphertext Image C_n')
subplot(2,3,3),imshow(Dn,[]),title('Deciphertext Image D_n')
subplot(2,3,4),imshow(C,[]),title('Ciphertext Image C')
subplot(2,3,5),imshow(Cn2,[]),title('Noisy Ciphertext Image C_n_2')
subplot(2,3,6),imshow(Dn2,[]),title('Deciphertext Image D_n_2')

%% 4. Sensitivity to Key Changes
K2 = K;
b = randi(64);
K2(b)= dec2hex(bitxor(uint8(hex2dec(K(b))),1)); % randomly change 1bit in K

CK = LatinSqEnc2(P,K2);
DK = LatinSqDec2(CK,K2);
str = strcat('C:\wamp\www\bhavya\resultimages\cipher4', X)
str1 = strcat('C:\wamp\www\bhavya\resultimages\decipher4', X)
imwrite(uint8(CK), str, 'jpg');
imwrite(uint8(DK), str1, 'jpg');
figure(4)
subplot(2,3,1),imshow(C,[]),title('Ciphertext Image C = Enc(P,K)')
subplot(2,3,2),imshow(CK,[]),title('Ciphertext Image C_K_2 = Enc(P,K_2)')
subplot(2,3,3),imshow(imabsdiff(C,CK),[]),title('|C-C_K_2|')
subplot(2,3,4),imshow(D,[]),title('Deciphertext Image D = Dec(C,K)' )
subplot(2,3,5),imshow(DK,[]),title('Deciphertext Image D_K_2 = Dec(C_K_2,K_2)')
subplot(2,3,6),imshow(imabsdiff(D,DK),[]),title('|D-D_K_2|')

%% 5. Sensitivity to Plaintext Changes
P2 = P;
P2(r) = 0;
C2 = LatinSqEnc2(P2,K);
D2 = LatinSqDec2(C2,K);
str = strcat('C:\wamp\www\bhavya\resultimages\plain5', X)
str1 = strcat('C:\wamp\www\bhavya\resultimages\cipher5', X)
str2 = strcat('C:\wamp\www\bhavya\resultimages\decipher5', X)
imwrite(uint8(P2), str, 'jpg');
imwrite(uint8(C2), str1, 'jpg');
imwrite(uint8(D2), str2, 'jpg');
figure(5)
subplot(3,3,1),imshow(P,[]),title('Plaintext Image P')
subplot(3,3,2),imshow(C,[]),title('Ciphertext Image C = Enc(P,K)')
subplot(3,3,3),imshow(D,[]),title('Deciphertext Image D = Dec(C,K)' )
subplot(3,3,4),imshow(P2,[]),title('Plaintext Image P_2')
subplot(3,3,5),imshow(C2,[]),title('Ciphertext Image C_2 = Enc(P_2,K)')
subplot(3,3,6),imshow(D2,[]),title('Deciphertext Image D_2 = Dec(C_2,K)' )
subplot(3,3,7),imshow(uint8(imabsdiff(P,P2))),title('|P-P_2|')
subplot(3,3,8),imshow(imabsdiff(C,C2),[]),title('|C-C_2|')
subplot(3,3,9),imshow(imabsdiff(D,DK),[]),title('|D-D_K_2|')
quit force
