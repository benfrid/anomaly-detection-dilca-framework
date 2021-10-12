% Maps the attribute value present in fileName with respect to the label
% present in 'label' 

% Author: Ben Fridolin
% Date: 01.07.2019

function dataInst= labelMap (fileName,label,Att_no)

sample= readtable(fileName);
for h=1:height(sample)
    for x=1:Att_no
        d(h,x)=table2array(sample(h,x));
        for v=1:length(label(x).Attlabel)
            if(strcmp(label(x).Attlabel(v),d(h,x)))
                dataInst(h,x)=v;
            end
        end
    end
end
end