% Helia Vafaei - 99522347

clear, clc;

% set the position of the figure in the screen
set(gcf, 'Position',  [200, 60, 1000, 700])

% read photo from storage
image = imread('image.png');

% show colormap photo in imshow
subplot(2,3,1), imshow(image), title('Original image'); 

% convert RGB image or colormap to grayscale
gray_img = rgb2gray(image);

% show grayscale photo with imshow
subplot(2,3,2), imshow(gray_img), title('Grayscale image'); 

% save gray_img with lossless compression format (PNG) in computer
imwrite(gray_img, 'gray_photo.png');

% calculate the energy of the gray photo by sum of gray levels
energy = sum(gray_img(:));
fprintf('Energy of photo = %d\n', energy);

% add Gaussian noise with mean 0 and variance 0.03
gau_img = imnoise(gray_img, 'gaussian', 0, 0.03);

% save gau_img in computer
imwrite(gau_img, 'gau_img.png');

% show gaussian noisy photo with imshow
subplot(2,3,3), imshow(gau_img), title('Grayscale image with gaussian noise'); 

% calculate SNR for before adding noise
SNR = snr(double(gray_img(:)), double(gray_img(:)) - double(gray_img(:)));
fprintf('SNR(before) = %d\n', SNR);

% calculate SNR for after adding noise
SNR = snr(double(gray_img(:)), double(gray_img(:)) - double(gau_img(:)));
fprintf('SNR(after) = %d\n', energy);

% convert to frequency domain
ft = fftshift(log(abs(fft2(gau_img))));
subplot(2,3,4), imshow(ft, []), title('Grayscale image with gaussian noise (in freq)'); 

% averaging filter to reduce the noise from gua_img
mat=ones(5,5)/25;
img1=imfilter(gau_img, mat);
subplot(2,3,5), imshow(img1), title('Reduce noises with average filter'); 

% save img1 in computer
imwrite(img1, 'img1.png');

% median filter to reduce the noise from gua_img
img2=medfilt2(gau_img);
subplot(2,3,6), imshow(img2), title('Reduce noises with median filter'); 

% save img2 in computer
imwrite(img2, 'img2.png');

% calculate PSNR for averaging filter method
[psnr1, snr1] = psnr(gau_img, img1);
fprintf('\n The Peak-SNR value for average filter is %0.4f', psnr1);

% calculate PSNR for median filter method
[psnr2, snr2] = psnr(gau_img, img2);
fprintf('\n The Peak-SNR value for median filter is %0.4f', psnr2);
