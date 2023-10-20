function[] = risi_kroznico_in_tocke_test(r,stTock)
    %stTock = 10000;

    % Polmer krožnice
    %r = 1;

    % Kliči funkcijo za oceno π s trenutnim številom točk
    [ocenjenoPi, napaka] = area_pi(stTock, r);

    % Izpis rezultata
    disp(['Ocenjeno π: ', num2str(ocenjenoPi)]);
    disp(['Napaka: ', num2str(napaka)]);

    % Nariši točke in lok krožnice
    risi_kroznico_in_tocke(stTock, r);

    % Izris grafa
    calc_pi(r,stTock)
end


function calc_pi(r,stTock)
    % Naraščajoče število naključnih točk
    stTock2 = 100:10:stTock;

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
        devijacija(end+1) =sqrt(sum((rez(i,:)-pi()).^2)/stTock) + pi();
        
    end
   
    aproks = polyfit(stTock2,devijacija,2);
    %aproks1 = polyval(aproks,stTock2);
    %disp(aproks);
   
    subplot(1, 2, 2)
    plot(stTock2, devijacija,"g-",'LineWidth', 1.5)
    hold on

    % Izpis rezultatov
    %disp('Št. točk   Ocenjeno π   Napaka');
    %disp(rezultati);

    % Graf
    subplot(1, 2, 2)
    plot(stTock2, rezultati(:, 2), 'b.');
    hold on;
    plot(stTock2, pravilnoPi * ones(size(stTock2)), 'r--');
    title('Ocena π z metodo Monte Carlo');
    xlabel('Število točk');
    ylabel('Ocenjena vrednost π');
    legend('Deviacija','Ocenjeno π', 'Pravilno π');
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
end

function risi_kroznico_in_tocke(stTock, r)
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

    % Nariši krožnico
    subplot(1, 2, 1)
    plot(x, y, 'g', 'LineWidth', 2);
    axis equal;
    title(['Krožnica s polmerom r = ', num2str(r)]);
    xlabel('X-os');
    ylabel('Y-os');
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
    title('Naključno generirane točke na krožnici z lokom');
    xlabel('X-os');
    ylabel('Y-os');
    legend('Znotraj krožnice', 'Zunaj krožnice', 'Lok krožnice');

   
end




