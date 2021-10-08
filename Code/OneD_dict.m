%% Please load the dataset from "Data" folder before running this code
%% Burgers eq
% Uused = Waves;
% Ix = 41:91;
% It=2:200;
%% Heat eq
Uused = H(:,1:1:eind);
Ix = 3:99;
It=2:eind-1;
%% 
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

Sinu=zeros(N_x,Mused);
for k = 1:Mused
        Sinu(:,k) = sin(Uused(:,k));
end
%% Build dictionary
M = length(It);
N = length(Ix);
Phi_tensor = zeros(M,7,N);
for i=1:length(Ix)
        Phi_tensor(:,1,i) = squeeze(Ut(Ix(i),It));
        Phi_tensor(:,2,i) = squeeze(Utt(Ix(i),It));
        Phi_tensor(:,3,i) = squeeze(Uused(Ix(i),It).*Ux(Ix(i),It));
        Phi_tensor(:,4,i) = squeeze(Uxx(Ix(i),It));
        Phi_tensor(:,5,i) = squeeze(Utx(Ix(i),It));
        Phi_tensor(:,6,i) = squeeze(Uttxx(Ix(i),It));
        Phi_tensor(:,7,i) = squeeze(Sinu(Ix(i),It));
end
