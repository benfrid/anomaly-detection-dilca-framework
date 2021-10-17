% OS_score assigned according to mink algorithm .

% Author: Ben Fridolin
% Date: 01.07.2019

function OS_score_min=rankingminData(dis,k)

[dis_sorted,index]= mink(dis,k,2); %finds the first k minimum values in each row
OS_score_min= zeros(size(dis,1),1);
for r=1:size(dis_sorted,1)
    for c=1:size(dis_sorted,2)
        OS_score_min(r)= dis_sorted(r,c)+OS_score_min(r);
    end
end

end
