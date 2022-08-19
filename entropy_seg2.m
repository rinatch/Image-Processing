function [th]= entropy_seg2(I)
   J = rgb2gray(I);
   E = imadjust(J,stretchlim(J),[]); 
   Hist = imhist(E);
   [m,n] = size(E);
   p = (find(Hist))/(m*n);
   Pt = cumsum(p); 
   Ht =- cumsum(p.*log(p));
   HL =- sum(p.*log(p));
   
   %Calculate entropies and get the maximum
   Yt = log(Pt.*(1-Pt))+Ht./(Pt)+(HL-Ht)./(1-Pt);
   [~,th] = max(Yt);
   
   %Apply segmentation
   segImg = (E>th);
   
   %Display
   subplot(1, 2, 1);
   imshow(I);
   xlabel('Original image');
   subplot(1,2,2);
   imshow(segImg);
   xlabel('Segmented image');
   
end
