function pnnl_plot_scores(A, C, first_pca, second_pca, ConstituentNames, displayConcentrations,label)

    % Copyright 2022 Battelle Memorial Institute
    if nargin < 6
        displayConcentrations = [];
    end
    if isempty(displayConcentrations)
        displayConcentrations = false;
    end
    if nargin < 7
        label = inputname(1);
    end
    [p,n] = size(C);

    [U,S,~] = pnnl_rectifiedSVD(A);
    Scores = U*S;

    nCombinations = 2^n - 1;
    combination = fliplr(dec2bin((1:nCombinations)')=='1');

    mixture = true(p,nCombinations);

    for combo = 1:nCombinations
        for j = 1:n
            mixture(:,combo) = mixture(:,combo) & (combination(combo,j) == (C(:,j)~=0));
        end
    end

    plot_mixtures = ~all(mixture==0);
    nplots = sum(plot_mixtures);
    figure
    markerSize = 35;
    fontSize = 14;
    legend_cell = cell(1,nplots);
    plot_number = 0;
    for combo = 1:nCombinations
        if plot_mixtures(combo)
            plot_number = plot_number + 1;
            plot(Scores(mixture(:,combo),first_pca),Scores(mixture(:,combo),second_pca),'.','MarkerSize',markerSize)
            hold on
            legend_cell{plot_number} = '';
            for j = 1:n
                if combination(combo,j)
                    legend_cell{plot_number} = [legend_cell{plot_number},' ',ConstituentNames{j}];
                end
            end
        end
    end
    if displayConcentrations
        text_label = string(round(C*10)/10);
        for i = 1:p
            text(Scores(i,first_pca),Scores(i,second_pca),['(',sprintf('%s ',text_label(i,:)),')'],...
                'VerticalAlignment','middle',...
                'HorizontalAlignment','left',...
                'FontSize',fontSize);
        end
    end

    grid on
    axis equal
    set(gca,'YDir','reverse')
    box on
    xlabel(sprintf('Scores on PC%d',first_pca))
    ylabel(sprintf('Scores on PC%d',second_pca))
    legend(legend_cell{:},'Location','best');
    title(label,'Interpreter','none')
    set(gca,'FontSize',fontSize)
    hold off
end
% Disclaimer
%
% This material was prepared as an account of work sponsored by an agency of the
% United States Government.  Neither the United States Government nor the United
% States Department of Energy, nor Battelle, nor any of their employees, nor any
% jurisdiction or organization that has cooperated in the development of these
% materials, makes any warranty, express or implied, or assumes any legal
% liability or responsibility for the accuracy, completeness, or usefulness or
% any information, apparatus, product, software, or process disclosed, or
% represents that its use would not infringe privately owned rights.
% 
% Reference herein to any specific commercial product, process, or service by
% trade name, trademark, manufacturer, or otherwise does not necessarily
% constitute or imply its endorsement, recommendation, or favoring by the United
% States Government or any agency thereof, or Battelle Memorial Institute. The
% views and opinions of authors expressed herein do not necessarily state or
% reflect those of the United States Government or any agency thereof.
% 
%                  PACIFIC NORTHWEST NATIONAL LABORATORY
%                               operated by
%                                 BATTELLE
%                                 for the
%                    UNITED STATES DEPARTMENT OF ENERGY
%                     under Contract DE-AC05-76RL01830