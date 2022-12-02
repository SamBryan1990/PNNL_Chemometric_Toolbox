function pnnl_plot_concentration(label,ConstituentNames,C_train,C_validation,C_predicted,C_predicted_train,C_predicted_cross_validation)

    % Copyright 2022 Battelle Memorial Institute

    % Concentrations
    data = load('pnnl_napalm_data','-mat','ConcentrationUnits');
    figure;
    font_size = 14;
    plot(C_validation,C_predicted,'.','MarkerSize',35);
    % Let the default parula color order be used, ...
    ax = gca;
    colorOrder = ax.ColorOrder;
    hold on
    plot(C_train,C_predicted_train,'o','MarkerSize',10,'LineWidth',1)
    plot(C_train,C_predicted_cross_validation,'+','MarkerSize',10,'LineWidth',1)
    % ... then reset the color order to recycle the first n colors so the
    % constituent are always the same color.
    n = size(C_validation,2);
    ax.ColorOrder = colorOrder(1:n,:);
    line(C_train,C_train,'Color','k')
    legend(ConstituentNames{:},...
        'Location','northwest',...
        'FontSize',font_size);
    axis square
    grid on
    title(['Concentrations (',label,')'])
    xlabel(['Known constituent (',data.ConcentrationUnits,')'])
    ylabel(['Measured constituent (',data.ConcentrationUnits,')'])
    ax.FontSize = font_size;
    box on
    hold off
    pnnl_addbars;
    disp('Legend: Dot is predicted. Circle is train. Cross is cross-validation.')
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