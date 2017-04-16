% %---------------------------3D----------------------------
% close all;
% 
% I_Str = ;
% II_Str = ;
% III_Str = ;
% IV_Str = ;
% V_Str = ;
% 
% 
% % [numberLines,numberColumns,numberAltitude] = size(img1_2d);
% 
% 
% for i=1:numberLines
%     for j = 1:numberColumns
%         for k =1:numberAltitude
%         I(i,j,k)= I_Str.family(i,j,k);
%         II(i,j,k)= II_Str.family(i,j,k);
%         III(i,j,k)= III_Str.family(i,j,k);
%         IV(i,j,k)= IV_Str.family(i,j,k);
%         V(i,j,k)= V_Str.family(i,j,k);
%         end
%     end
% end
% 
% 
% 
% 
% %--------------------------2D---------------------------------






I = load('/Users/danieldahis/Desktop/Slice9 I- 40,18,9.mat');
II = load('/Users/danieldahis/Desktop/Slice9 II - 15,17,9.mat');
III = load('/Users/danieldahis/Desktop/Slice9 III - 14,16,9.mat');
IV = load('/Users/danieldahis/Desktop/Slice9 IV - 35,18,9.mat');
V = load('/Users/danieldahis/Desktop/Slice9 V - 15,20,9.mat');

I = I.slicey9_postProcessing;
% figure;imagesc(I);
II = II.slicey9_postProcessing;
% figure;imagesc(II);
III = III.slicey9_postProcessing;
% figure;imagesc(III);
IV = IV.slicey9_postProcessing;
% figure;imagesc(IV);
V = V.slicey9_postProcessing;
% figure;imagesc(V);

[numLin,numCol] = size(I);

z = cat(3,I,II,III,IV,V);
res = mean(z,3);

%Method I: Roundup on the mean(values) and postProcessing I

% figure;xlabel('Res 1');imagesc(res);
% 
% figure;title('Res Roundup');imagesc(round(res));
% 
% 
for i=1:numLin
    for j =1:numCol
        if(isThereAnotherFamilyAround(i,j,res,numLin,numCol) ==0)
        mostCommon = MostCommonFamilyAround(i,j,res,numLin,numCol);
        res(i,j) = mostCommon;
        else
        res(i,j) = res(i,j);
        end
    end
end
% 
figure;title('Res Roundup PostProcessing');imagesc(round(res));




% %Method II: Normalizing by the Surrounding Families and and taking the
% %greatest value and postProcessingI
res1 = res;
% 
% figure;title('Res Roundup');imagesc(round(res1));
% 
for i=1:numLin
    for j =1:numCol
        mostCommon = MostCommonFamilyAround(i,j,round(res),numLin,numCol);
        res1(i,j) = mostCommon;
    end
end
% 
% 
% figure;xlabel('Res 1');imagesc(res1);



for i=1:numLin
    for j =1:numCol
        if(isThereAnotherFamilyAround(i,j,res1,numLin,numCol) ==0)
        mostCommon = MostCommonFamilyAround(i,j,res1,numLin,numCol);
        res1(i,j) = mostCommon;
        else
        res1(i,j) = res1(i,j);
        end
    end
end

figure;title('Res Roundup');imagesc(round(res1));

