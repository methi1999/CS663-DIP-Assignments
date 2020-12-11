function [trainvecspace, testvecspace, imgrownum, imgcolnum, corrtraintag, corrtesttag] = yaledataloader()
%Directory Location
yaledir = '../../../CroppedYale';
%people =  dir(orldir);
%LOAD TRAINING DATA
imgrownum = 192;
imgcolnum = 168;
trainnumface =39;
totimg= 64;
trainnumimg =40;
%testnumimg= totimg-trainnumimg;
trainvecspace = zeros(imgrownum*imgcolnum,trainnumface*trainnumimg);
testvecspace = zeros(imgrownum*imgcolnum,trainnumface*(totimg-trainnumimg));
toremove = [];
corrtraintag =[];
corrtesttag=[];
for i = 1:trainnumface
    if i ~= 14
        if i < 10
            currsubfolderDir = append(yaledir,'/yaleB0',num2str(i));
        else
            currsubfolderDir = append(yaledir,'/yaleB',num2str(i));
        end
        myFiles = dir(fullfile(currsubfolderDir,'*.pgm'));
        totimg = size(myFiles,1);
        %disp(totimg)
        if totimg < 64
            for j = (totimg+1):64
                toremove= [toremove ((i-1)*(totimg-trainnumimg)+j-trainnumimg)];
            end
        end
        for k = 1:totimg%length(myFiles)
            baseFileName = myFiles(k).name;
            fullFileName = fullfile(currsubfolderDir, baseFileName);
            currface = imread(fullFileName);
            %disp(size(currface))
            currcolvec = reshape(currface,[size(currface,1)*size(currface,2) 1]);
            %disp(size(currcolvec))
            if k <= trainnumimg
                trainvecspace(:,(i-1)*trainnumimg+k)=currcolvec;
                corrtraintag = [corrtraintag i];
            else
                testvecspace(:,(i-1)*(64-trainnumimg)+k-trainnumimg)=currcolvec;
                corrtesttag = [corrtesttag i];
            end
            %imshow(img)
        end
    end
end
%disp(toremove)
%testvecspace = testvecspace(:,any(testvecspace));
%testvecspace(:,toremove) = [];
%corrtraintag(~any(trainvecspace,1)) = [];
%corrtesttag(~any(testvecspace,1)) = [];
trainvecspace( :, ~any(trainvecspace,1) ) = [];
testvecspace(:, all(testvecspace==0) ) = [];