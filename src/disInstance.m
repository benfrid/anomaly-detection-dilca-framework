% Calculates the distance between the data instance present in testIns and
% dataIns by finding their values from d that were calculated from training
% data.

% Author: Ben Fridolin
% Date: 01.07.2019

function dis=disInstance(d,testIns,dataIns,Att_no)

dis=zeros(length(testIns),length(dataIns));
    for d1=1:length(testIns)
        for d2=1:length(dataIns)
            %if(d1~=d2)
                data=0;
                for X=1:Att_no
                    if(testIns(d1,X)==0)
                        data=data+5;
                    else
                    data=(d(X,testIns(d1,X),dataIns(d2,X)).^2)+data;
                    end
                end
                dis(d1,d2)=sqrt(data);
            %end
        end
    end
end