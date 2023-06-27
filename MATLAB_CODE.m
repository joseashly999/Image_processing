% Processing Two satellit images using MATLAB

ice1=imread("1_SnowPoolsBefore_20180113_md-2048px.jpg");
ice2=imread("2_SnowPoolsAfter_20200119_md-2048px.jpg");
[BWbefore,maskedbefore] = myiceimage(ice1);
%imshow(maskedbefore);
[BWafter,maskedafter] = myiceimage(ice2)
imshow(maskedafter);
(nnz(BWafter) - nnz(BWbefore)) / nnz(BWbefore) * 100




% Function


function [BW,maskedRGBImage] = myiceimage(RGB)
%------------------------------------------------------


% Convert RGB image to chosen color space
I = rgb2ycbcr(RGB);

% Define thresholds for channel 1 based on histogram settings
channel1Min = 15.000;
channel1Max = 255.000;

% Define thresholds for channel 2 based on histogram settings
channel2Min = 38.000;
channel2Max = 236.000;

% Define thresholds for channel 3 based on histogram settings
channel3Min = 122.000;
channel3Max = 255.000;

% Create mask based on chosen histogram thresholds
sliderBW = (I(:,:,1) >= channel1Min ) & (I(:,:,1) <= channel1Max) & ...
    (I(:,:,2) >= channel2Min ) & (I(:,:,2) <= channel2Max) & ...
    (I(:,:,3) >= channel3Min ) & (I(:,:,3) <= channel3Max);
BW = sliderBW;

% Invert mask
BW = ~BW;

% Initialize output masked image based on input image.
maskedRGBImage = RGB;

% Set background pixels where BW is false to zero.
maskedRGBImage(repmat(~BW,[1 1 3])) = 0;

end
