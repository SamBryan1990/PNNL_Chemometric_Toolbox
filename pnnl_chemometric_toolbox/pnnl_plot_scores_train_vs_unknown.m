function pnnl_plot_scores_train_vs_unknown(A_train, C_train, A_unknown, C_validation, first_pca, second_pca, ConstituentNames, displayConcentrations)
    % pnnl_plot_scores_train_vs_unknown Plot scores of train vs. unknown

    % Copyright 2022 Battelle Memorial Institute
    if nargin < 8
        displayConcentrations = [];
    end
    if isempty(displayConcentrations)
        displayConcentrations = false;
    end
    [p_train,n_train] = size(C_train);
    [p_validation,n_validation] = size(C_validation);

    [U,S,~] = pnnl_rectifiedSVD(A_train);
    Scores_train = U*S;
    [U,S,~] = pnnl_rectifiedSVD(A_unknown);
    Scores_unknown = U*S;

    nCombinations_train = 2^n_train - 1;
    combination_train = fliplr(dec2bin((1:nCombinations_train)')=='1');
    nCombinations_validation = 2^n_validation - 1;
    combination_validation = fliplr(dec2bin((1:nCombinations_validation)')=='1');

    mixture_train = true(p_train,nCombinations_train);
    for combo = 1:nCombinations_train
        for j = 1:n_train
            mixture_train(:,combo) = mixture_train(:,combo) & (combination_train(combo,j) == (C_train(:,j)~=0));
        end
    end
    plot_mixtures_train = ~all(mixture_train==0);

    mixture_validation = true(p_validation,nCombinations_validation);
    for combo = 1:nCombinations_validation
        for j = 1:n_validation
            mixture_validation(:,combo) = mixture_validation(:,combo) & (combination_validation(combo,j) == (C_validation(:,j)~=0));
        end
    end
    plot_mixtures_validation = ~all(mixture_validation==0);

    figure
    markerSize = 35;
    fontSize = 14;
    plot_number = 0;
    for combo = 1:nCombinations_train
        if plot_mixtures_train(combo)
            plot_number = plot_number + 1;
            plot(Scores_train(mixture_train(:,combo),first_pca),Scores_train(mixture_train(:,combo),second_pca),'+','MarkerSize',15,'LineWidth',4);
            hold on
            legend_cell{plot_number} = ''; %#ok<*AGROW> 
            for j = 1:n_train
                if combination_train(combo,j)
                    legend_cell{plot_number} = [legend_cell{plot_number},' ',ConstituentNames{j}];
                end
            end
            legend_cell{plot_number} = [legend_cell{plot_number},' (train)'];
        end
    end
    for combo = 1:nCombinations_validation
        if plot_mixtures_validation(combo)
            plot_number = plot_number + 1;
            plot(Scores_unknown(mixture_validation(:,combo),first_pca),Scores_unknown(mixture_validation(:,combo),second_pca),'.','MarkerSize',markerSize)
            hold on
            legend_cell{plot_number} = '';
            for j = 1:n_validation
                if combination_validation(combo,j)
                    legend_cell{plot_number} = [legend_cell{plot_number},' ',ConstituentNames{j}];
                end
            end
            legend_cell{plot_number} = [legend_cell{plot_number},' (validation)'];
        end
    end



    if displayConcentrations
        text_label = string(round(C_train*10)/10);
        for i = 1:p_train
            text(Scores_train(i,first_pca),Scores_train(i,second_pca),['(',sprintf('%s ',text_label(i,:)),')'],...
                'VerticalAlignment','middle',...
                'HorizontalAlignment','left',...
                'FontSize',fontSize);
        end
        text_label = string(round(C_validation*10)/10);
        for i = 1:p_validation
            text(Scores_unknown(i,first_pca),Scores_unknown(i,second_pca),['(',sprintf('%s ',text_label(i,:)),')'],...
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