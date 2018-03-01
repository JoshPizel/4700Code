% This example shows how to calculate and plot both the
% fundamental TE and TM eigenmodes of an example 3-layer ridge
% waveguide using the full-vector eigenmode solver.  

% Refractive indices:
n1 = 3.34;          % Lower cladding
n2 = 3.44;          % Core
n3 = 1.00;          % Upper cladding (air)

% Layer heights:
h1 = 2.0;           % Lower cladding
h2 = 1.3;           % Core thickness
h3 = 0.5;           % Upper cladding

% Horizontal dimensions:
rh = 1.1;           % Ridge height
rw = 1;           % Ridge half-width
side = 1.5;         % Space on side

% Grid size:
dx = 0.0125*8;        % grid size (horizontal)
dy = 0.0125*8;        % grid size (vertical)

lambda = 1.55;      % vacuum wavelength
nmodes = 1;         % number of modes to compute
steps = 10;

stepsize = linspace(3.305,3.44,10);
for t = 1:1:steps
[x,y,xc,yc,nx,ny,eps,edges] = waveguidemesh([n1,stepsize(t),n3],[h1,h2,h3], ...
                                            rh,rw,side,dx,dy); 

% First consider the fundamental TE mode:

[Hx,Hy,neff] = wgmodes(lambda,n2,nmodes,dx,dy,eps,'000A');


    fprintf(1,'neff = %.6f\n',neff);
    
    figure(t)
    subplot(121);
    contourmode(x,y,real(Hx(:,:,1)));
    title('Hx (TE mode)'); xlabel('x'); ylabel('y'); 
    for v = edges, line(v{:}); end
    
    subplot(122);
    contourmode(x,y,real(Hy(:,:,1)));
    title('Hy (TE mode)'); xlabel('x'); ylabel('y'); 
    for v = edges, line(v{:}); end

    neffindex(t) = neff;
    
end

figure(11)
plot(stepsize,neffindex)