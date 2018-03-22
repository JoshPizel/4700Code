%parameter setup;
Is = 0.01e-12;
Ib = 0.1e-12;
Vb = 1.3;
Gp = 0.1;

V = linspace(-1.95,0.7,200);

Id = Is*(exp((1.2/0.025)*V)-1);

Ipr = Gp*V;

Ibreak = -Ib*exp((-1.2/0.025)*(V+Vb));

I = Id + Ipr + Ibreak;

IwNoise = I + 0.2*rand(1,length(I)).*I;

figure(1)
plot(V,I)
title('I without noise')

figure(2)
plot(V,IwNoise)
title('I with noise')

figure(3)
semilogy(V,IwNoise)
title('I with noise semilogy')

figure(4)
semilogy(V,I)
title('I without noise semilogy')

%using polyfit
Ipoly4coef = polyfit(V,I,4);
Ipoly8coef = polyfit(V,I,8);

IpolyNoise4coef = polyfit(V,IwNoise,4);
IpolyNoise8coef = polyfit(V,IwNoise,8);

Ipoly4 = polyval(Ipoly4coef,V);
Ipoly8 = polyval(Ipoly8coef,V);

IpolyNoise4 = polyval(IpolyNoise4coef,V);
IpolyNoise8 = polyval(IpolyNoise8coef,V);

figure(1)
hold on
plot(V,Ipoly4)
plot(V,Ipoly8)
hold off

figure(2)
hold on
plot(V,IpolyNoise4)
plot(V,IpolyNoise8)
hold off

figure(3)
hold on
semilogy(V,IpolyNoise4)
semilogy(V,IpolyNoise8)
hold off

figure(4)
hold on
semilogy(V,Ipoly4)
semilogy(V,Ipoly8)
hold off

%non linear fitting (’A.*(exp(1.2*x/25e-3)-1) + B.*x - C*(exp(1.2*(-(x+D))/25e-3)-1)’)
% fo = fittype('A.*(exp(1.2*x/0.025)-1) + B.*x - C*(exp(1.2*(-(x+D))/0.25)-1)',...
%              'independent','x',...
%              'coefficients', {'A','B','C','D'});
%all 4 parameters
fo = fittype('A.*(exp(1.2*x/0.025)-1) + B.*x - C*(exp(1.2*(-(x+D))/0.025)-1)');         
ff1 = fit(V.',I.',fo);

If1 = ff1(x);

figure(5)
hold on
plot(V,If1,'Color',[0 0.5 0])

%D is set
fo2 = fittype('A.*(exp(1.2*x/0.025)-1) + B.*x - C*(exp(1.2*(-(x+1.3))/0.025)-1)');
ff2 = fit(V.',I.',fo2);

If2 = ff2(x);

plot(V,If2,'Color',[0.6 0 0])

%B and D is set
fo3 = fittype('A.*(exp(1.2*x/0.025)-1) + 0.1.*x - C*(exp(1.2*(-(x+1.3))/0.025)-1)');
ff3 = fit(V.',I.',fo3);

If3 = ff3(x);

plot(V,If3,'Color',[0 0 0.5])

plot(V,IwNoise)

legend
hold off
% neual net model
inputs = V;
targets = I;
hiddenLayerSize = 10;
net = fitnet(hiddenLayerSize);
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;
[net,tr] = train(net,inputs,targets);
outputs = net(inputs);
errors = gsubtract(outputs,targets);
performance = perform(net,targets,outputs);
view(net)
Inn = outputs;





