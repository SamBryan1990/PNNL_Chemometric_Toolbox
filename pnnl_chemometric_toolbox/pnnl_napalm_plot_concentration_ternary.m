function pnnl_napalm_plot_concentration_ternary

    % Copyright 2022 Battelle Memorial Institute
    if ~exist('ternplot','file') || ~exist('ternlabel','file')
        error(['To run this function, download Carl Sandrock (2021). ',...
            'alchemyst/ternplot (https://github.com/alchemyst/ternplot), GitHub.  ',...
            'https://www.mathworks.com/matlabcentral/fileexchange/2299-alchemyst-ternplot']);
    end

    data = load('pnnl_napalm_data');

    % https://www.mathworks.com/matlabcentral/fileexchange/2299-alchemyst-ternplot
    C = data.C_train/100;
    figure
    colorOrder = pnnl_colorOrder(7);
    ternplot(C(:,1),C(:,2),C(:,3),'+','Color',colorOrder(4,:),'MarkerSize',15,'LineWidth',4)
    %ternplot(C(:,1),C(:,2),C(:,3),'.','Color',colorOrder(1,:),'MarkerSize',30);
    hold on
    C = data.C_validation/100;
    ternplot(C(:,1),C(:,2),C(:,3),'.','Color',colorOrder(5,:),'MarkerSize',30);
    label1 = [data.ConstituentNames{1},' (%)'];
    label2 = [data.ConstituentNames{2},' (%)'];
    label3 = [data.ConstituentNames{3},' (%)'];
    h = ternlabel(label1,label2,label3);
    set(h,'FontSize',18)
    legend('Training','Validation','FontSize',14);
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