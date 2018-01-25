global C

C.q_0 = 1.60217653e-19;             % electron charge
C.hb = 1.054571596e-34;             % Dirac constant
C.h = C.hb * 2 * pi;                % Planck constant
C.m_0 = 9.10938215e-31;             % electron mass
C.kb = 1.3806504e-23;               % Boltzmann constant
C.eps_0 = 8.854187817e-12;          % vacuum permittivity
C.mu_0 = 1.2566370614e-6;           % vacuum permeability
C.c = 299792458;                    % speed of light
C.g = 9.80665; %metres (32.1740 ft) per s²



%initial values
force = 1;
mass =1;
Temp = 300;

time_step = 0.001;
run_time = 10;
max_time = run_time/time_step;

xPos=zeros(1,max_time);
Vel=zeros(1,max_time);
xPos(1,1) =0;
Vel(1,1) =0;

%velocity caused from force
forceVel = force/(mass*time_step);

%main loop
for dt=2:1:max_time
    
    if(rand<0.05)%update velocity and position
        Vel(1,dt) = 0;
        xPos(1,dt) = xPos(1,dt-1) + Vel(1,dt);
    else
        Vel(1,dt) = Vel(1,dt-1)+ forceVel;
        xPos(1,dt) = xPos(1,dt-1) + Vel(1,dt);
    end
    
    subplot(2,1,1);
    scatter(xPos(xPos~=0),zeros(1,dt-1),'filled');
    subplot(2,1,2);
    plot(linspace(1,time_step,max_time),Vel(1,:))
    drawnow
    hold on
end
hold off