clearvars
clearvars -GLOBAL
close all 


global C

C.q_0 = 1.60217653e-19;             % electron charge
    C.hb = 1.054571596e-34;             % Dirac constant
    C.h = C.hb * 2 * pi;                % Planck constant
    C.m_0 = 9.10938215e-31;             % electron mass
    C.kb = 1.3806504e-23;               % Boltzmann constant
    C.eps_0 = 8.854187817e-12;          % vacuum permittivity
    C.mu_0 = 1.2566370614e-6;           % vacuum permeability
    C.c = 299792458;                    % speed of light
    C.g = 9.80665;
    
    
nx = 50;
ny = 50;



G = zeros(nx*ny,nx*ny);

for i =1:1:nx
    for j =1:1:ny
        n = j+(i-1)*ny;
        
            nxm = j+(i-2)*ny;
            nxp = j+i*ny;
            nyp = j+1+ (i-1)*ny;
            nym = j-1+ (i-1)*ny;
        if(i==1)
            G(n,:) = 0;
            G(n,n) = 1;
        elseif(i==nx)
            G(n,:) = 0;
            G(n,n) = 1;
        elseif(j==1)
            G(n,:) = 0;
            G(n,n) = 1;
        elseif(j==ny)
            G(n,:) = 0;
            G(n,n) = 1;
        else          
            G(n,n) = -4;
            G(n,nxm) = 1; 
            G(n,nxp) = 1;
            G(n,nym) = 1;
            G(n,nyp) = 1;
        end
    end
end

spy(G)

[E,D] = eigs(G,9,'SM');

for i= 1:1:nx
    for j= 1:1:ny
        n = j+(i-1)*ny;
        Eplot1(i,j) = E(n,1);
        Eplot2(i,j) = E(n,2);
        Eplot3(i,j) = E(n,3);
        Eplot4(i,j) = E(n,4);
        Eplot5(i,j) = E(n,5);
        Eplot6(i,j) = E(n,6);
        
    end
end

figure(2)
surf(Eplot1)
figure(3)
surf(Eplot2)
figure(4)
surf(Eplot3)
figure(5)
surf(Eplot4)
figure(6)
surf(Eplot5)
figure(7)
surf(Eplot6)