function risi_kroznico_in_tocke_test()
    stTock = 10000;

    % Polmer krožnice
    r = 1;

    % Kliči funkcijo za oceno π s trenutnim številom točk
    [ocenjenoPi, napaka] = area_pi(stTock, r);

    % Izpis rezultata
    disp(['Ocenjeno π: ', num2str(ocenjenoPi)]);
    disp(['Napaka: ', num2str(napaka)]);

    % Nariši točke in lok krožnice
    risi_kroznico_in_tocke(stTock, r);
end

function [ocenjenoPi, napaka] = area_pi(stTock, r)
    % Inicializacija števca za točke znotraj kroga
    znotrajKroga = 0;

    % Generiranje naključnih točk in preverjanje, ali so znotraj kroga
    for i = 1:stTock
        x = 2 * rand() - 1;
        y = 2 * rand() - 1;

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
    x = 2 * rand(stTock, 1) - 1;
    y = 2 * rand(stTock, 1) - 1;

    % Loči točke znotraj in zunaj krožnice
    razdalja = sqrt(x.^2 + y.^2);
    tockeZnotraj = razdalja <= r;
    tockeZunaj = razdalja > r;

    % Nariši točke
    scatter(x(tockeZnotraj), y(tockeZnotraj), 50, 'b', 'filled'); % Notranje točke v modri barvi
    hold on;
    scatter(x(tockeZunaj), y(tockeZunaj), 50, 'r', 'x'); % Zunanje točke v rdeči barvi

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
    plot(x, y, 'g', 'LineWidth', 2);
    axis equal;
    title(['Krožnica s polmerom r = ', num2str(r)]);
    xlabel('X-os');
    ylabel('Y-os');

    % Nastavitve grafa
    axis equal;
    title('Naključno generirane točke na krožnici z lokom');
    xlabel('X-os');
    ylabel('Y-os');
    legend('Znotraj krožnice', 'Zunaj krožnice', 'Lok krožnice');
end
