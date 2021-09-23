Theta_e_r1 = permute(Theta_e_tens,[1 3 2]);
Theta = reshape(Theta_e_r1, size(Theta_e_tens,1)*size(Theta_e_tens,3), size(Theta_e_tens,2));
%% sbl
lambda=1e-3;
Learn_Lambda=0;
X = zeros(size(Theta,2)-1,size(Theta,2));
ebar = zeros(size(Theta,2),1);
tic
for i=1:size(Theta,2)
    inds_kept = 1:size(Theta,2);
    inds_kept(i) = [];
    [X(:,i),gamma_ind,gamma_est,count,ebar(i)] = MSBL(Theta(:,inds_kept),Theta(:,i), lambda, Learn_Lambda);
end
toc

[minebar,indminebar] = min(ebar);

%% lasso (proposed method)
s=[1,1,1,-1,-1,-1,1]; % 1D
%s=[1,1,1,1,-1,-1,-1,-1,-1,-1,1]; %2D

e = zeros(size(Theta,1)+1,1);
e(end)=1;

Theta_e = [normc(Theta);s];
tic
xl = lasso(Theta_e,e,'Lambda',max(abs(Theta_e'*e))*0.2/length(e),'Intercept',false)
toc