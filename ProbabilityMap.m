close all;

% Test
fls = dir( 'Resul*.mat' );
for fi=1:numel(fls)
    A{fi} = importdata( fls(fi).name, ' ', 9 );
    % ...
end
% % End test
for fi=1:numel(fls)
    res0{fi} = A{fi};
    res00{fi} = res0{fi}(:,:,9);
end



res1 = load('Resul1.mat');
res2 = load('Resul2.mat');
res3 = load('Resul3.mat');
res4 = load('Resul4.mat');
res5 = load('Resul5.mat');
res6 = load('Resul6.mat');
res7 = load('Resul7.mat');
res8 = load('Resul8.mat');
res9 = load('Resul9.mat');
res10 = load('Resul10.mat');

res1 = res1.img_resul(:,:,9);
res2 = res2.img_resul(:,:,9);
res3 = res3.img_resul(:,:,9);
res4 = res4.img_resul(:,:,9);
res5 = res5.img_resul(:,:,9);
res6 = res6.img_resul(:,:,9);
res7 = res7.img_resul(:,:,9);
res8 = res8.img_resul(:,:,9);
res9 = res9.img_resul(:,:,9);
res10 = res10.img_resul(:,:,9);

[numberLines,numberColumns] = size(res1);


for i = 1:numberLines
    for j = 1:numberColumns
         
    Res1(i,j) = res1(i,j).family;
    Res2(i,j) = res2(i,j).family;
    Res3(i,j) = res3(i,j).family;
    Res4(i,j) = res4(i,j).family;
    Res5(i,j) = res5(i,j).family;
    Res6(i,j) = res6(i,j).family;
    Res7(i,j) = res7(i,j).family;
    Res8(i,j) = res8(i,j).family;
    Res9(i,j) = res9(i,j).family;
    Res10(i,j) = res10(i,j).family;
    end
end

for k = 1: numel(res00)
    for i = 1:numberLines
        for j = 1:numberColumns
            res000(i,j,k) = res00{k}(i,j).family;
        end
    end
end


figure;imagesc(Res1);
% figure;imagesc(Res2);
% figure;imagesc(Res3);
% figure;imagesc(Res4);
% figure;imagesc(Res5);

%Depois substituir aqui por um conjunto de slices (13)
listOfSlices = cat(3,Res1,Res2,Res3,Res4,Res5,Res6,Res7,Res8,Res9,Res10);
[none11,none22,numberSlices1] = size(res000);
[none1,none2,numberSlices] = size(listOfSlices);

for slice = 2:numberSlices1
pause;

clustersReferenceImage = unique(Res1);
clustersChangebleImage = unique(listOfSlices(:,:,slice));


%Realiza o processo de equalizacao entre dois slices.
for clRef = 1:numel(clustersReferenceImage)
    for clChang = 1:numel(clustersChangebleImage)
        
        Res11 = Res1;
        Res22 = listOfSlices(:,:,slice);
        
        Res11(Res11 ~= clustersReferenceImage(clRef)) = 0;
        Res11(Res11 == clustersReferenceImage(clRef)) = 1;
        
        Res22(Res22 ~= clustersReferenceImage(clChang)) = 0;
        Res22(Res22 == clustersReferenceImage(clChang)) = 1;
        
        error = nnz(Res11 - Res22);
        
        distBetweenClusters(clRef,clChang) = error;
        
    end
end

for clRef = 1:numel(clustersReferenceImage)
    correspondentValues(clRef) = find(distBetweenClusters(clRef,:) == min(distBetweenClusters(clRef,:)));
end

Res11 = Res1;
Res22 = listOfSlices(:,:,slice);

for clChangg = 1:numel(correspondentValues)
    Res22(Res22 == correspondentValues(clChangg)) = clChangg+numel(correspondentValues);
end

Res22 = Res22 - numel(correspondentValues);
figure;imagesc(Res22);

end



