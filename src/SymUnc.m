% Symmetric uncertainity value for one contigency table

% Author: Ben Fridolin
% Date: 01.07.2019

function [su_value,labels]=SymUnc(Yvalue,Xvalue)
        [tb1,~, ~,labels] = crosstab (Yvalue, Xvalue);
        row=size(tb1,1);
        col=size(tb1,2);
        tb1(row+1,:)=sum(tb1(1:row,: ));
        tb1(:,col+1)= sum(tb1,2);
        Py=zeros(row,1);
        hy=zeros(row,1);
        for i=1:row
        Py(i)= tb1(i,col+1)/tb1(row+1,col+1);
        hy(i)= Py(i)*log2(Py(i));
        end
        Hy=-sum(hy);
        Px=zeros(row,1);
        hx=zeros(row,1);
        for j=1:col
        Px(j)=tb1(row+1,j)/tb1(row+1,col+1);
        hx(j)= Px(j)*log2(Px(j));
        end
        Hx=-sum(hx);
        Hygivenx=0;
        for j=1:col
            pygivenx=zeros(row,1);
            hygivenx=zeros(row,1);
            for i=1:row
                if(tb1(i,j)~=0)
                pygivenx(i)=tb1(i,j)/tb1(row+1,j);
                hygivenx(i)= pygivenx(i)*log2(pygivenx(i));
                end
            end
            Hygivenx=Hygivenx-((Px(j)*sum(hygivenx)));
        end
        IGyandx=Hy-Hygivenx;
        su_value=(2*IGyandx)/(Hy+Hx);
end
   