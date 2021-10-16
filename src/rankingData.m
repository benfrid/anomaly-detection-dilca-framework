% OS_score calculated for k data instances with maxk algorithm

% Author: Ben Fridolin
% Date: 01.07.2019
function OS_score=rankingData(dis,k)

[dis_sorted,index]= maxk(dis,k,2); %finds the first four maximum values in each row
OS_score= zeros(size(dis,1),1);
for r=1:size(dis_sorted,1)
    for c=1:size(dis_sorted,2)
        OS_score(r)= dis_sorted(r,c)+OS_score(r);
    end
end

end
