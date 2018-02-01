
clear all

nx=25;
ny=25;
iterate=1000;



V = zeros(nx,ny);
%boundary values
V(:,1) = 1;%left side
V(:,nx)= 1;%right side
V(1,:) = 0;%bottom
V(ny,:)= 0;%top

Vdt = zeros(nx,ny,iterate);



for dt = 1:1:iterate
    for x = 1:1:nx
        for y = 1:1:ny
            if(x==1 && y==1)%bottom left corner
                V(x,y)= (V(x+1,y)+V(x,y+1))/2;
                %Ex(x,y)=V(,y)-V()
            elseif(x==1 && y==ny)%top left corner
                V(x,y)= (V(x+1,y)+V(x,y-1))/2;
            elseif(x==nx && y==1)%bottom right boundary 
                V(x,y)= (V(x-1,y)+V(x,y+1))/2;
            elseif(x==nx && y==ny)%top right boundary
                V(x,y)= (V(x-1,y)+V(x,y-1))/2;
            elseif(x==1)%left boundary
                V(x,y)= (V(x+1,y)+V(x,y+1)+V(x,y-1))/3;
            elseif(y==1)%bottom boundary
                V(x,y)= (V(x+1,y)+V(x-1,y)+V(x,y+1))/3;
            elseif(x==nx)%right boundary
                V(x,y)= (V(x,y+1)+V(x-1,y)+V(x,y-1))/3;
            elseif(y==ny)%top boundary
                V(x,y)= (V(x+1,y)+V(x-1,y)+V(x,y-1))/3;
            else %anywhere in the middle
                V(x,y)= (V(x+1,y)+V(x-1,y)+V(x,y-1)+V(x,y+1))/4;
            end
            %boundary values
            V(:,1) = 1;%left side
            V(:,nx)= 1;%right side
            V(1,:) = 0;%bottom
            V(ny,:)= 0;%top
            
        end
    end
    
    %plot here
    surf(V)
    pause(0.1)
    
    
end