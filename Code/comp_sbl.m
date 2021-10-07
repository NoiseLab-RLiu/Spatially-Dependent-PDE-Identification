Phi_e_r1 = permute(Phi_tensor,[1 3 2]);
Phi = reshape(Phi_e_r1, size(Phi_tensor,1)*size(Phi_tensor,3), size(Phi_tensor,2));
%% sbl
lambda=1e-3;
Learn_Lambda=0;
ETime = zeros(10,1);

for repeatance=1:10
X = zeros(size(Phi,2)-1,size(Phi,2));
ebar = zeros(size(Phi,2),1);
tic
for i=1:size(Phi,2)
    inds_kept = 1:size(Phi,2);
    inds_kept(i) = [];
    [X(:,i),gamma_ind,gamma_est,count,ebar(i)] = MSBL(Phi(:,inds_kept), Phi(:,i), lambda, Learn_Lambda);
end
[minebar,indminebar] = min(ebar);
ETime(repeatance) = toc;
end
mean(ETime)
%% lasso (proposed method)
%s=[1,1,1,-1,-1,-1,1]; % 1D
s=[1,1,1,1,-1,-1,-1,-1,-1,-1,1]; %2D

e = zeros(size(Phi,1)+1,1);
e(end)=1;

Phi_e = [normc(Phi);s];

ETime = zeros(10,1);

for repeatance=1:10
tic
[xl,stat] = lasso(Phi_e,e,'Lambda',max(abs(Phi_e'*e))*0.2/length(e),'Intercept',false,'RelTol',10^(-8));%,'UseCovariance',0)
ETime(repeatance) = toc;
end
mean(ETime)