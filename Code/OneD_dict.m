load('Heat_sp_dp.mat');

Uused = H(:,1:1:eind);
[N_x,Mused] = size(Uused);
method = 'FD';

Ux=zeros(N_x,Mused);
Uxx=zeros(N_x,Mused);

for k = 1:Mused
    Ux(:,k)=numder(Uused(:,k), dx, 1,method);
    Uxx(:,k)=numder(Uused(:,k), dx, 2,method); 
end

% time derivatives
Ut=zeros(N_x,Mused);
Utt=zeros(N_x,Mused);
for i = 1:N_x
        Ut(i,:) = numder(Uused(i,:),dt,1,method);
        Utt(i,:) = numder(Uused(i,:),dt,2,method);
end

% time-spatial derivatives
Utx=zeros(N_x,Mused);
Uttxx=zeros(N_x,Mused);
for k = 1:Mused
        Utx(:,k) = numder(Ut(:,k),dx,1,method);
        Uttxx(:,k) = numder(Utt(:,k),dx,2,method);
end

Sinhu=zeros(N_x,Mused);
for k = 1:Mused
        Sinhu(:,k) = sinh(Uused(:,k)*dx);
end

U1 = ones(N_x,Mused);

%% ROI for Heat eq.
Ix = 3:98;
It=2:1999;

%% Build dictionary
m = length(It);
N = length(Ix);
Theta_e_tens = zeros(m,7,N);
for i=1:length(Ix)
        Theta_e_tens(:,1,i) = squeeze(Ut(Ix(i),It));
        Theta_e_tens(:,2,i) = squeeze(Utt(Ix(i),It));
        Theta_e_tens(:,3,i) = squeeze(Uused(Ix(i),It).*Ux(Ix(i),It));
        Theta_e_tens(:,4,i) = squeeze(Uxx(Ix(i),It));
        Theta_e_tens(:,5,i) = squeeze(Utx(Ix(i),It));
        Theta_e_tens(:,6,i) = squeeze(Uttxx(Ix(i),It));
        Theta_e_tens(:,7,i) = squeeze(Sinhu(Ix(i),It));
end