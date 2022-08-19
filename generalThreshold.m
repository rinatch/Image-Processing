function[threshold_value] = generalThreshold(~)

close all;
clc;

%vec = load('intensity2.mat');
%vec = vec.intensity;
total=zeros(1,255);
mean1=0;
mean2=0;
variance_1=0;
variance_2=0;   
thresh=0; %Initial threshold value
%figure;
rgb_img=imread("input.png"); %Read the image
resized_image=imresize(rgb_img,[768 1024]); %Resizing the image
img_gray=0.21*resized_image(:,:,1) + 0.72*resized_image(:,:,2) + 0.07*resized_image(:,:,3);
%imshow(rgb_img); %Gray scale image
%title('Original Image');
[row,col]=size(img_gray);
intensity=zeros(1,256);

%Determining the intensity of every pixel
for i=1:row
    for j=1:col
       intensity(img_gray(i,j)+1)=intensity(img_gray(i,j)+1)+1;
    end
end
%prob1=intensity./(row*col); % Probability of each pixel
       

while ~(thresh==255) 
    %Calcualting the sum of each class
    cumulative1=sum(intensity(1:thresh+1));
    cumulative2=sum(intensity(thresh+1:255));
    %Calcualting the mean of each class
    for temp=1:256
       
       if temp<thresh+1
           if cumulative1 ~=0
                mean1=mean1+((temp*intensity(temp))/cumulative1);
           end
       else
           if cumulative2 ~=0
                mean2=mean2+((temp*intensity(temp))/cumulative2);
           end
       end
    end 
   %Calcualting the variance of each class
   for temp=1:256

       if temp<thresh
            if cumulative1 ~=0
                variance_1=variance_1+((temp-mean1)*(temp-mean1))*(intensity(temp)/cumulative1);
            end
           
       else
           if cumulative2 ~=0
                variance_2=variance_2+((temp-mean2)*(temp-mean2))*(intensity(temp)/cumulative2);
           end
       end
    end
   %Calcualting the between class variance
   variance_3=(cumulative1*variance_1)+(cumulative2*variance_2);
   total(thresh+1)=variance_3;
   thresh=thresh+1;
   mean1=0;
   mean2=0;
   variance_1=0;
   variance_2=0;
       
end
smallest=find(total==(min(total))); 
threshold_value=(smallest-1);
disp([' Threshold Value is ' num2str(uint8(threshold_value))]);
figure;
im=im2bw(img_gray,threshold_value/255); %Converting to binary using th obtained value
imshow(im);
title(['Threshold: ' num2str(threshold_value)]);
end
