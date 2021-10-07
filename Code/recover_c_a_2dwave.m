c_rec=nan(size(Waves,1)-4,size(Waves,2)-4); % recovered c
a_rec=nan(size(Waves,1)-4,size(Waves,2)-4); % recovered alpha

ind_waveeq3 = zeros(N,1);
ind_waveeq4 = zeros(N,1);
for i=1:N
    if(indicator(:,i)==[0,1,0,0,1,1,0,0,0,0,0]')
        ind_waveeq3(i) = 1;
    elseif(indicator(:,i)==[1,1,0,0,1,1,0,0,0,0,0]')
        ind_waveeq4(i) = 1;
    end
end
%% number of locations where the wave eq. is successfully recovered
sum(ind_waveeq3)+sum(ind_waveeq4)
%% recover speed c and attenuating factor alpha
tar = zeros(M+1,1);
tar(end) = 1;
vec_cons_3 = [1,-1,-1];
vec_cons_4 = [1,1,-1,-1];
diff56=0;
for i=1:length(Ix)
    for j=1:length(Iy)
        ind_trans = length(Iy)*(i-1)+j;
        if(ind_waveeq3(ind_trans)==1)
            Phi_s=[Phi_tensor(:,2,ind_trans),Phi_tensor(:,5,ind_trans),Phi_tensor(:,6,ind_trans)];
            Phi_s=[Phi_s;vec_cons_3];
            a_lsq = Phi_s\tar;
            a_rec(Ix(i)-2,Iy(j)-2) = 0;
            c_rec(Ix(i)-2,Iy(j)-2) = sqrt((abs(a_lsq(2))+abs(a_lsq(3)))/(2*(abs(a_lsq(1)))));
        elseif(ind_waveeq4(ind_trans)==1)
            Phi_s=[Phi_tensor(:,1,ind_trans),Phi_tensor(:,2,ind_trans),Phi_tensor(:,5,ind_trans),Phi_tensor(:,6,ind_trans)];
            Phi_s=[Phi_s;vec_cons_4];
            a_lsq = Phi_s\tar;
            a_rec(Ix(i)-2,Iy(j)-2) = a_lsq(1)/a_lsq(2);
            c_rec(Ix(i)-2,Iy(j)-2) = sqrt((abs(a_lsq(3))+abs(a_lsq(4)))/(2*(abs(a_lsq(2)))));      
        end
        diff56 = abs(a_lsq(end)-a_lsq(end-1));
    end
end
%%

%% RMSE, change c, c_rec to alpha, a_rec to calculate the RMSE for alpha
 rsum=0;
 for i=1:length(Ix)
     for j=1:length(Iy)
        rsum=rsum+(c(Ix(i),Iy(j))-c_rec(i,j))^2;
     end
 end

rmse = sqrt(rsum/(length(Ix)*length(Iy)))