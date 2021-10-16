% This function does the context selection and also calculates the distance
% between the values in each attribute from the given csv file ( fileName )

% Author: Ben Fridolin
% Date: 01.07.2019

function [d,label,Att_no,sample]=mainFun(fileName)
sample = readtable(fileName);
Att_no=width(sample);
SymUnc_value= zeros(Att_no,Att_no);
SUxgivenx= zeros(Att_no,Att_no,Att_no);

% SU Y given X
for target=1:Att_no
    for predict=1:Att_no
        if(target~=predict)
            Yvalue=string(table2array(sample(:,target)));
            Xvalue=string(table2array(sample(:,predict)));
            [su_value,labelValue]=SymUnc(Yvalue,Xvalue);
            label(predict).Attlabel=labelValue(:,2);
            SymUnc_value(target,predict)=su_value;
        end
    end
    label(target).Attlabel=labelValue(:,1);
end


% Relevant behavior
[SymUncyandx,index]=sort(SymUnc_value,2,'descend');

% SU XgivenX for each Y
for target=1:Att_no
    for predict=1:Att_no
        for predict2=1:Att_no
            if(predict~=predict2)
            %if((target~=predict)&&(target~=predict2))
              Yvalue=string(table2array(sample(:,predict)));
              Xvalue=string(table2array(sample(:,predict2)));  
              su_value=SymUnc(Yvalue,Xvalue);
              SUxgivenx(target,predict,predict2)=su_value;
            end
        end
    end
end

%Redundancy Removal
[T,H]= redundancyRem(SUxgivenx,SymUncyandx,Att_no,index);

%DILCA

d=DILCA(H,sample,Att_no);
d1 =squeeze(d(1,:,:));
d2 =squeeze(d(2,:,:));
d3 =squeeze(d(3,:,:));
d4 =squeeze(d(4,:,:));


%Attribte Model impact

% I=zeros(1,Att_no);
% for Att_Index=1:Att_no
%     value_Att=[3,4,14,9];
%     a=value_Att(Att_Index);
%     for k=1:a-1
%         for l=k+1:a
%             I(Att_Index)=I(Att_Index)+d(Att_Index,k,l);
%         end
%     end
%     I(Att_Index)=I(Att_Index)/(a*(a-1)/2);
% end
% 
% figure(8);
% str={'Message type','Paths','Methods','Parameters'};
% colors=[0.8500,0.3250,0.0980;0.8500,0.3250,0.0980;0.8500,0.3250,0.0980;0.8500,0.3250,0.0980];
% wordcloud(str,I,'Color',colors);

end
