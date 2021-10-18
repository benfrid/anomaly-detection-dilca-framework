% Redundancy removal of attribute for ocontext selection
% T- index of the values stored correctly in H according to the position of
% attribute in training data.
% H- The atribute present or not after evaluation. 

% Author: Ben Fridolin
% Date: 01.07.2019

function [T,H]= redundancyRem(SUxgivenx,SymUncyandx,Att_no,index)
T=zeros(Att_no,Att_no);
for row=1:Att_no % For each target attribute Y
    
    for col=2:Att_no% Second attribute iteration X2
        if(SUxgivenx(row,index(row,1),index(row,col))>SymUncyandx(row,col))% first element in attribute iteration X1
            T(row,col)=1; %index(col) is the correct attribute value to be removed*
        end  
    end
    icheck=0;
    for n=2:Att_no % other elements in iteration
        if((T(row,n)~=1)&&icheck==0)
            i=n;
            icheck=1;
        else 
            continue;
        end
        if(n<Att_no)
        if(T(row,n+1)~=1)
            j=n+1;
            icheck=0;
        else
            continue;
        end
        end
        if(n<Att_no)
        if(SUxgivenx(row,index(row,i),index(row,j))>SymUncyandx(row,j))
            T(row,j)=1;
        end
        end
    end
end

H=zeros(Att_no,Att_no);
for row=1:Att_no
    for col=1:Att_no
        if(T(row,col)==1)
            T(row,col)=index(row,col);
            H(row,index(row,col))=1; % correcting the index to particular attribute and setting one where it needs to be removed
        end
    end
end
end