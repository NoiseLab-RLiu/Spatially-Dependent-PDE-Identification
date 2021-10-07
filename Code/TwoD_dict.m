%%  Please load the dataset from "Data" folder before running this code
%%    
% space derivatives
Uused = Waves;
[N_x,N_y,Mused] = size(Uused);
method = 'FD';

Ux=zeros(N_x,N_y,Mused);
Uxx=zeros(N_x,N_y,Mused);
Uy = zeros(N_x,N_y,Mused);
Uyy=zeros(N_x,N_y,Mused);
Uxy=zeros(N_x,N_y,Mused);
dy=dx;
for k = 1:Mused
    Utmp=Uused(:,:,k);
    for i = 1:N_y
        Ux(:,i,k)=numder(Utmp(:,i), dx, 1,method);
        Uxx(:,i,k)=numder(Utmp(:,i), dx, 2,method);
    end
    for i = 1:N_x
        Uy(i,:,k)=numder(Utmp(i,:), dy, 1,method);
        Uyy(i,:,k)=numder(Utmp(i,:), dy, 2,method);
    end
    Utmp=Ux(:,:,k);
    for i = 1:size(Ux,1)
        uxy=numder(Utmp(i,:), dy, 1,method);
        Uxy(i,:,k)=uxy;
    end    
end

% time derivatives
Ut=zeros(N_x,N_y,Mused);
Utt=zeros(N_x,N_y,Mused);
for i = 1:N_x
    for j=1:N_y
        Ut(i,j,:) = numder(Uused(i,j,:),dt,1,method);
        Utt(i,j,:) = numder(Uused(i,j,:),dt,2,method);
    end
end

% time-spatial derivatives
Utx=zeros(N_x,N_y,Mused);
Uttxx=zeros(N_x,N_y,Mused);
for k = 1:Mused
    for j=1:N_y
        Utx(:,j,k) = numder(Ut(:,j,k),dx,1,method);
        Uttxx(:,j,k) = numder(Utt(:,j,k),dx,2,method);
    end
end

Uty=zeros(N_x,N_y,Mused);
Uttyy=zeros(N_x,N_y,Mused);
for k = 1:Mused
    for i=1:N_x
        Uty(i,:,k) = numder(Ut(i,:,k),dy,1,method);
        Uttyy(i,:,k) = numder(Utt(i,:,k),dy,2,method);
    end
end

SinhU = sinh(Uused);

Ix = 3:30;
Iy = 3:30;
It = 2:199;

U1 = ones(30,30,200);

M = length(It);
N = length(Ix)*length(Iy);
Phi_tensor = zeros(M,11,N);
for i=1:length(Ix)
    for j=1:length(Iy)
        Phi_tensor(:,1,length(Iy)*(i-1)+j) = squeeze(Ut(Ix(i),Iy(j),It));
        Phi_tensor(:,2,length(Iy)*(i-1)+j) = squeeze(Utt(Ix(i),Iy(j),It));
        Phi_tensor(:,3,length(Iy)*(i-1)+j) = squeeze(Uused(Ix(i),Iy(j),It).*Ux(Ix(i),Iy(j),It));
        Phi_tensor(:,4,length(Iy)*(i-1)+j) = squeeze(Uused(Ix(i),Iy(j),It).*Uy(Ix(i),Iy(j),It));
        Phi_tensor(:,5,length(Iy)*(i-1)+j) = squeeze(Uxx(Ix(i),Iy(j),It));
        Phi_tensor(:,6,length(Iy)*(i-1)+j) = squeeze(Uyy(Ix(i),Iy(j),It));
        Phi_tensor(:,7,length(Iy)*(i-1)+j) = squeeze(Utx(Ix(i),Iy(j),It));
        Phi_tensor(:,8,length(Iy)*(i-1)+j) = squeeze(Uttxx(Ix(i),Iy(j),It));
        Phi_tensor(:,9,length(Iy)*(i-1)+j) = squeeze(Uty(Ix(i),Iy(j),It));
        Phi_tensor(:,10,length(Iy)*(i-1)+j) = squeeze(Uttyy(Ix(i),Iy(j),It));
        Phi_tensor(:,11,length(Iy)*(i-1)+j) = squeeze(SinhU(Ix(i),Iy(j),It));
    end
end
 