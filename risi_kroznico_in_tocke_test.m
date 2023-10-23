function[] = glavna_funkcija_brez(r,stTock)
  
    % Kliči funkcijo za oceno π s trenutnim številom točk
    [ocenjenoPi, napaka] = area_pi(stTock, r);

    % Izpis rezultata
    disp(['Ocenjeno π: ', num2str(ocenjenoPi)]);
    disp(['Napaka: ', num2str(napaka)]);

    % Nariši točke in lok krožnice
    Vizualizacijska_funkcija(stTock, r);

    % Izris grafa
    mcc_pi(r,stTock)
end


function mcc_pi(r,stTock)
    % Naraščajoče število naključnih točk
    stTock2 = 100:20:10000;

    % Pravilna vrednost π iz vgrajene konstante
    pravilnoPi = pi;

    % Priprava matrike za shranjevanje rezultatov
    rezultati = zeros(length(stTock2), 3);
    rez = zeros(length(stTock2),20);
    devijacija=[];
    
    for j = 1:20
        for i = 1:length(stTock2)
            % Kliči funkcijo za oceno π s trenutnim številom točk
            [ocenjenoPi, napaka] = area_pi(stTock2(i),r);
    
            % Shrani rezultate v matriko
            rezultati(i, 1) = stTock2(i);
            rezultati(i, 2) = ocenjenoPi;
            rezultati(i, 3) = napaka;
            rez(i,j)= ocenjenoPi;
        end
        
    end
    %disp(rez)   
    for i = 1:length(stTock2)
        devijacija(end+1) =sqrt(sum((rez(i,:)-pi()).^2)/20) + pi();
        
    end
x = stTock2;
y = devijacija;
   
    % Definicija logaritemske funkcije
logarithmic_function = @(params, x) params(1) * log(x) + params(2);

% Začetne vrednosti parametrov
initial_guess = [1, 1];

% Izvedba aproksimacije
fit_params = lsqcurvefit(logarithmic_function, initial_guess, x, y);

% Pridobivanje parametrov aproksimirane logaritemske funkcije
a = fit_params(1);
b = fit_params(2);

% Generiranje aproksimirane krivulje
fitted_curve = a * log(x) + b;

    subplot(1, 2, 2)
    plot(stTock2,fitted_curve,"g-",'LineWidth', 1.5)
    hold on
    %plot(stTock2,aproks1(stTock2),"g-",'LineWidth', 1.5)
    hold on

    % Izpis rezultatov
    %disp('Št. točk   Ocenjeno π   Napaka');
    %disp(rezultati);

    % Graf
    subplot(1, 2, 2)
    plot(stTock2, rezultati(:, 2), 'b.');
    hold on;
    plot(stTock2, pravilnoPi * ones(size(stTock2)), 'r--');
    hold on 
end
function [ocenjenoPi, napaka] = area_pi(stTock, r)
    % Inicializacija števca za točke znotraj kroga
    znotrajKroga = 0;

    % Generiranje naključnih točk in preverjanje, ali so znotraj kroga
    for i = 1:stTock
        x = (2 * rand() - 1)*r;
        y = (2 * rand() - 1)*r;

        if x^2 + y^2 <= r^2
            znotrajKroga = znotrajKroga + 1;
        end
    end

    % Izračun ocenjenega π in napake
    ocenjenoPi = 4 * znotrajKroga / stTock;
    napaka = abs(ocenjenoPi - pi);

    %DEFINICIJA FUNKCIJE
    %area_pi funkcija, nam s pomočjo metode Monte Carlo izračuna približno
    %vrednost vrednosti pija.

end

function Vizualizacijska_funkcija(stTock, r)
    % Generiraj naključne točke
    x = (2 * rand(stTock, 1) - 1)*r;
    y = (2 * rand(stTock, 1) - 1)*r;

    % Loči točke znotraj in zunaj krožnice
    razdalja = sqrt(x.^2 + y.^2);
    tockeZnotraj = razdalja <= r;
    tockeZunaj = razdalja > r;

    % Nariši točke
    subplot(1, 2, 1)
    scatter(x(tockeZnotraj), y(tockeZnotraj), 20, 'b', '.'); % Notranje točke v modri barvi
    hold on;
    scatter(x(tockeZunaj), y(tockeZunaj),20, 'r', '.'); % Zunanje točke v rdeči barvi
    hold on

    % Nariši lok krožnice
    % Preveri, ali je podan polmer r
    if nargin < 1
        error('Manjka vhodni parameter: polmer krožnice.');
    end

    % Koti za izris krožnice
    theta = linspace(0, 2 * pi, 1000);

    % Koordinate točk na krožnici
    x = r * cos(theta);
    y = r * sin(theta);

    % Nariši krožnico, spremeni v anonimno 
    subplot(1, 2, 1)
    plot(x, y, 'g', 'LineWidth', 2);
    axis equal;
    
    hold on

    % Izris kvadrata
    y0=[r,r];
    y1=[r,-r];
    y2=[-r,-r];
    y3=[-r,r];
   
    plot(y1,y0,"k",'LineWidth', 2)
    hold on
    plot(y1,y2,"k",'LineWidth', 2)
    hold on
    plot(y0,y3,"k",'LineWidth', 2)
    hold on
    plot(y2,y3,"k",'LineWidth', 2)
    hold on

    % Nastavitve grafa
   axis equal;
   
end
