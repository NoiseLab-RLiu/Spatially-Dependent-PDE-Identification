[M,D,N] = size(Phi_tensor);

a_raw=zeros(D,N);
a_res=zeros(D,N);
%% define s
% for 1d
%vec_constraint = [1,1,1,-1,-1,-1,1];
% for 2d
vec_constraint = [1,1,1,1,-1,-1,-1,-1,-1,-1,1];
Cond=[];
tic
for i=1:N
    % select dictionary for location i
    Phi_s = squeeze(Phi_tensor(:,:,i));
    n = size(Phi_s,2);
    % normalize dictionary
    Phi_sn=zeros(size(Phi_s,1),size(Phi_s,2));
    for d=1:size(Phi_s,2)
        Phi_sn(:,d) = Phi_s(:,d)./norm(Phi_s(:,d));
    end
    % append constraint s to the normalized dictionary
    Phi_ext = [Phi_sn;vec_constraint];
    tar = zeros(size(Phi_s,1)+1,1);
    tar(end) = 1;
    % set lambda
    lam=0.2*max(abs(Phi_ext'*tar))/length(tar); % scaled by 1/length(tar) because MATLAB automatically scales the coefficient for ||Phi*a-tar||_2^2 by 1/(2*length(tar))
    % lasso
    [a_ext_tmp, s] = lasso(Phi_ext,tar,'Lambda',lam,'Intercept',false,'RelTol',1e-8,'MaxIter',10^7);
    a_raw(:,i) = a_ext_tmp;
    Cond=[Cond,corr(Phi_s(:,4),Phi_s(:,7))];
end
toc

figure
stem(Cond)

figure
imagesc((log10(abs((a_raw)))))
cbh = colorbar('XTickLabel',{'$\leq -5$','-4','-3','-2','-1','0'}, ...
               'XTick', -5:0,'TickLabelInterpreter','latex')
ylabel('Index of the entry $i$ in ${\bar{\mathbf{a}}}_n$','interpreter','latex')
xlabel('Location index $n$','interpreter','latex')
title('$log_{10}|{\bar{\mathbf{a}}}_n(i)|$','interpreter','latex')%
yticklabels({'1','2','3','4','5','6','7','8','9','10','11'})
xticks([1,200,400,600,784])
%xticks([1,10,20,30,40,51])
%xticks([1,20,40,60,80,97])
ax=gca
ax.FontSize=20;
caxis([-5 0])
colormap(hot)
set(gca,'TickLabelInterpreter','latex')

%exportgraphics(gcf,'A_mat_Heat5.png')
%exportgraphics(gcf,'A_mat_2dWaves5.png')

%% Thresholding
indicator = zeros(D,N);
for i=1:N
    [maxv,maxi] = max(abs(a_raw(:,i)));
    ind=find(abs(a_raw(:,i))>=1e-3*maxv);
    indicator(ind,i) = 1;
end
