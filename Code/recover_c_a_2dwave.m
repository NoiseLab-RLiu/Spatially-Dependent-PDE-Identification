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
for i=1:length(Ix)
    for j=1:length(Iy)
        ind_trans = length(Iy)*(i-1)+j;
        if(ind_waveeq3(ind_trans)==1)
            Theta_s=[Theta_e_tens(:,2,ind_trans),Theta_e_tens(:,5,ind_trans),Theta_e_tens(:,6,ind_trans)];
            Theta_s=[Theta_s;vec_cons_3];
            a_lsq = Theta_s\tar;
            a_rec(Ix(i)-2,Iy(j)-2) = 0;
            c_rec(Ix(i)-2,Iy(j)-2) = sqrt((abs(a_lsq(2))+abs(a_lsq(3)))/(2*(abs(a_lsq(1)))));
        elseif(ind_waveeq4(ind_trans)==1)
            Theta_s=[Theta_e_tens(:,1,ind_trans),Theta_e_tens(:,2,ind_trans),Theta_e_tens(:,5,ind_trans),Theta_e_tens(:,6,ind_trans)];
            Theta_s=[Theta_s;vec_cons_4];
            a_lsq = Theta_s\tar;
            a_rec(Ix(i)-2,Iy(j)-2) = a_lsq(1)/a_lsq(2);
            c_rec(Ix(i)-2,Iy(j)-2) = sqrt((abs(a_lsq(3))+abs(a_lsq(4)))/(2*(abs(a_lsq(2)))));
        end
    end
end