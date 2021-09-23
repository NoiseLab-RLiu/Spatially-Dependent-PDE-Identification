[M,D,N] = size(Theta_e_tens);
Theta_e = zeros((M+1)*N,D*N);

%% define s
% for 1d
%vec_constraint = [1,1,1,-1,-1,-1,1];
% for 2d
vec_constraint = [1,1,1,1,-1,-1,-1,-1,-1,-1,1];
%% Solving coefficients parallelly
tar = zeros(M+1,1);
tar(end) = 1;
TAR = zeros((M+1)*N,1);
Res_fact = zeros(D,N);
for i=1:N
    Theta_s = squeeze(Theta_e_tens(:,:,i));
    Theta_sn=zeros(size(Theta_s,1),size(Theta_s,2));
    for d=1:size(Theta_s,2)
        Theta_sn(:,d) = Theta_s(:,d)./norm(Theta_s(:,d));
    end
    Theta_ext = [Theta_sn;vec_constraint];
    Theta_e((i-1)*(M+1)+1:i*(M+1),(i-1)*D+1:i*D) = Theta_ext;
    TAR((i-1)*(M+1)+1:i*(M+1)) = tar;
    rescale_factor = vecnorm(Theta_s)./vecnorm(Theta_sn);
    Res_fact(:,i) = rescale_factor';
end

lam=0.2*max(abs(Theta_e'*TAR))/length(TAR);%-5

tic
[A_ext_tmp,stat] = lasso(Theta_e,TAR,'Lambda',lam,'Intercept',false,'MaxIter',5000);
toc
A_mat = reshape(A_ext_tmp,D,N);

%% Thresholding
indicator = zeros(D,length(Ix)*length(Iy));
for i=1:length(Ix)*length(Iy)
    [maxv,maxi] = max(abs(A_mat(:,i)));
    ind=find(abs(A_mat(:,i))>=1e-3*maxv);
    indicator(ind,i) = 1;
end
