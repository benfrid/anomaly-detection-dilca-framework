% provides the distance matrix, if there are four attributes, dis is of
% dimension 4xpxp, where p is the number of values present in each attribute, 

% Author: Ben Fridolin
% Date: 01.07.2019

function dis=DILCA(H,sample,Att_no)
condygivenX=zeros(1,Att_no);
Xnum=zeros(1,Att_no);
for target =1:Att_no 
[tb2,~, ~,~] = crosstab (table2array(sample(:,target)), table2array(sample(:,2)));
 row=size(tb2,1);
 for d1=1:row
    for d2=1:row 
        condygivenx=zeros(1,Att_no);
        xnum=zeros(1,Att_no);
        for predict= 1:Att_no
                    if(H(target,predict)==0)
                    [tb2,~, ~,labelss] = crosstab (table2array(sample(:,target)), table2array(sample(:,predict)));    
                    col=size(tb2,2);
                    tb2(row+1,:)=sum(tb2(1:row,:));
                    cond=zeros(1,col);
                        for j=1:col 
                        pygivenx_d1=tb2(d1,j)/tb2(row+1,j);
                        pygivenx_d2=tb2(d2,j)/tb2(row+1,j);
                        cond(j)=(pygivenx_d1-pygivenx_d2).^2;
                        end
                        condygivenx(predict)=sum(cond);
                        xnum(predict)=col;
                    end
        end
condygivenX(target)=sum(condygivenx);
Xnum(target)= sum(xnum);
dis(target,d1,d2)= sqrt(condygivenX(target)/Xnum(target));
    end
 end
end     
end
