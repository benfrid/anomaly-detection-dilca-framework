% Main file
% Author: Ben Fridolin
% Date: 01.07.2019

% input files
trainingFilename='1_BT_music_normal.csv';
testFilename='2_BT_music_abnormal.csv';
acc_map='3_BT_music_accmap.csv';

% train_att  - distance between values in each attribute in training data
[train_att,label,Att_no,train_table]=mainFun(trainingFilename);

% test_att  - distance between values in each attribute in test data
[test_att,label_test,~,~]=mainFun(testFilename);

% Mapping of the test data and training data with respect to the order in
% train data
tesdis_dataIns =labelMap (testFilename,label,Att_no);
traindis_dataIns=labelMap (trainingFilename,label,Att_no);

% Mapping of the test data with respect to the order in
% test data
testonly_dataIns=labelMap (testFilename,label_test,Att_no);

% distance between training data instances
dis_Train=disInstance(train_att,traindis_dataIns,traindis_dataIns,Att_no);
OS_score_train=rankingData(dis_Train,length(dis_Train)); % OS score of train data
OS_score_max= max(OS_score_train); %Threshold

% distance between test and training data instances
dis_TT=disInstance(train_att,tesdis_dataIns,traindis_dataIns,Att_no);

% distance between test instances
dis_TestTest=disInstance(test_att,testonly_dataIns,testonly_dataIns,Att_no);

% Different ways to select k values 

% 1) OS_score with k=4 data instances, which has maximum distance

OS_score=rankingData(dis_TT,4);

% OS_score with all data instances

% OS_score_test=rankingData(dis_TT,length(dis_Train));
% k=80;
k=length(dis_Train); % 2) total length present in training data
OS_score_test=rankingData(dis_TT,k); 

OS_score_test1=rankingminData(dis_TT,k); % 3) mink algorithm to select k

% Accuracy metric to note the detected anomaly in acc_map file

detected=zeros(length(dis_TT),1);
for i=1:length(dis_TT)
    if(OS_score_test(i)>OS_score_max)
        detected(i,1)=1;
    end
end
maptable=readtable(acc_map);
maptable.detected=detected(:,1);

ab=table2array(maptable(:,2));

% Accuracy, Precision and Recall Metric
% TP,TN,FP,FN, 0-normal, 1-abnormal
% Manual..... Detected
% 0  0  TN ;
% 0  1  FP
% 1  1  TP
% 1  0  FN
TN=0; TP=0; FN=0; FP=0;
for i=1:length(dis_TT)
    manual=maptable.Manual(i);
    detect=maptable.detected(i);
    if(manual==0&&detect==0)
        TN=TN+1;
    elseif(manual==0&&detect==1)
        FP=FP+1;
    elseif(manual==1&&detect==1)
        TP=TP+1;
    elseif(manual==1&&detect==0)
        FN=FN+1;
    end
end    

Precision=(TP/(TP+FP));
Recall=(TP/(TP+FN));
Accuracy=(TP+TN)/(TP+TN+FP+FN);

% Training data plot 

[Y,e]=cmdscale(dis_Train,2);
extra=[0,-0.2;-0.1,-0.3;0.6,-0.2;1,-0.125;0.8,0.7;0.9,0.6;1.2,0.45];
figure(1);
plot(Y(:,1),Y(:,2),'*','MarkerEdgeColor','b');   
title('CMDS plot for train data with normal instances');
xlabel('Direction of 1st most variation in distance matrix');
ylabel('Direction of 2nd most variation in distance matrix'); 

% Test Instance MDS plot

[Y1,e1]=cmdscale(dis_TestTest,2);
figure(2);
for i=1:length(dis_TestTest)
    if(ab(i,1)==0)
    p1=plot(Y1(i,1),Y1(i,2),'*','MarkerEdgeColor','b');
    hold on;
    else
    p2=plot(Y1(i,1),Y1(i,2),'s','MarkerEdgeColor','r');   
    hold on;
    end
end
title('CMDS plot for test data with normal and abnormal instances');
xlabel('Direction of 1st most variation in distance matrix');
ylabel('Direction of 2nd most variation in distance matrix'); 
legend([p1 p2],{'Normal','Abnormal'});


% Plots

% Pattern mismatch, distance difference of training and test data instances

diff=abs(dis_Train-dis_TestTest);
figure(3);
imagesc(diff);
colorbar;
xlabel('Training instance');
ylabel('Test instance');
title('Mismatch between sequential order of training and test instance');

% figure(7);
% imagesc(dis_TT);
% colorbar;
% xlabel('Training instance');
% ylabel('Test instance');
% title('Distance between values in test and training data instances');

% figure(8);
% c = linspace(1,size(tesdis_dataIns,1),size(tesdis_dataIns,1));
% x=1:1:size(tesdis_dataIns,1);
% scatter(x,OS_score,[],c,'filled','p');
% hold on;
% yline(OS_score_max,'--b','Threshold');
% xlabel('Test instance index');
% ylabel('OS score');
% title('Anomaly detection with k=4');

figure(4);
x=1:1:size(tesdis_dataIns,1);
c = linspace(1,size(tesdis_dataIns,1),size(tesdis_dataIns,1));
scatter(x,OS_score_test,[],c,'filled','p');
hold on;
yline(OS_score_max,'-b','Threshold');
xlabel('Test instance index');
ylabel('OS score');
title('Anomaly detection');

figure(5);
c = categorical({'Message Type','Service path','Method','Parameter'});
c = reordercats(c,{'Message Type','Service path','Method','Parameter'});
att1=max(traindis_dataIns(:,1));
att2=max(traindis_dataIns(:,2));
att3=max(traindis_dataIns(:,3));
att4=max(traindis_dataIns(:,4));
values=[att1 att2 att3 att4];
bar(c,values);
title('Attribute Value plot');
ylabel('number of values');


% figure(6);
% imagesc(dis_Train);
% colorbar;
% xlabel('Training instance');
% ylabel('Training instance');
% title('Distance between values in training data instances');
%  
% for r=1:size(tesdis_dataIns,1)
% if(OS_score_test(r)>OS_score_max)
%     plot(x,OS_score_test(r),'*','Red');
%     hold on;
% else
%     scatter(x,OS_score_test(r),'o','green');
% end
% end
    

% for r=1:size(dis_Train,1)-1
%         Train_dist(r)=dis_Train(r,r+1);
% end
% for r=1:size(dis_TT,1)-1
%         Test_dist(r)=dis_TT(r,r+1);
% end