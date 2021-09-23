tar = zeros(M+1,1);
tar(end) = 1;
vec_cons_2 = [1,-1];
a_rec = nan(N+2,1);
for i=1:length(Ix)
        ind_trans = i;
        Theta_s=[Theta_e_tens(:,1,ind_trans),Theta_e_tens(:,4,ind_trans)];
        Theta_s=[Theta_s;vec_cons_2];
        %Theta_s=[Theta_s;vec_cons_4];
        a_lsq = Theta_s\tar;
        %A_lsq=[A_lsq,a_lsq];
        a_rec(Ix(i),1) = -a_lsq(2)/a_lsq(1);         
 end

a_rec(Ix(77))=nan;