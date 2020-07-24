clc; clear; close all;

imgPath = "DIP3E_CH04_Original_Images/";
f = imread(imgPath+"Fig0424(a)(rectangle).tif");

F = fft2(f);
S = abs(F);
imshow(S, []);

%%
Fc = fftshift(F);
imshow(abs(Fc), []);

%%
S2 = log(1+abs(Fc));
imshow(S2, []);

%%
F = ifftshift(Fc);
phi = atan2(imag(F), real(F));