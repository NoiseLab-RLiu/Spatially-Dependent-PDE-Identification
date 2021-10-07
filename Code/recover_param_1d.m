%% For Heat eq.
tar = zeros(M+1,1);
tar(end) = 1;
vec_cons_2 = [1,-1];
a_rec = nan(N+2,1);
for i=1:length(Ix)
        ind_trans = i;
        Phi_s=[Phi_tensor(:,1,ind_trans),Phi_tensor(:,4,ind_trans)];
        Phi_s=[Phi_s;vec_cons_2];
        a_lsq = Phi_s\tar;
        a_rec(Ix(i),1) = -a_lsq(2)/a_lsq(1);         
 end


 rsum=0;
 for i=1:length(Ix)
     rsum=rsum+(alpha(Ix(i))-a_rec(Ix(i)))^2;
 end

rmse = sqrt(rsum/length(Ix))

%% For Burgers eq.
nu = 0.15*ones(length(Ix),1);
tar = zeros(M+1,1);
tar(end) = 1;
vec_cons_3 = [1,1,-1];
nu_rec = nan(N,1);
summ = 0;
for i=1:length(Ix)
        ind_trans = i;
        Phi_s=[Phi_tensor(:,1,ind_trans),Phi_tensor(:,3,ind_trans),Phi_tensor(:,4,ind_trans)];
        Phi_s=[Phi_s;vec_cons_3];
        a_lsq = Phi_s\tar;
        summ = summ+abs(a_lsq(2)-a_lsq(1));
        nu_rec(i) = -a_lsq(3)/a_lsq(1);
 end


 rsum=0;
 for i=1:length(Ix)
     rsum=rsum+(nu(i)-nu_rec(i))^2;
 end

rmse = sqrt(rsum/length(Ix)) 