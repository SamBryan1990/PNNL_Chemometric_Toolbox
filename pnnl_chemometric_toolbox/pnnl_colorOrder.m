function colorOrder = pnnl_colorOrder(n)
    %pnnl_colorOrder Color order for plots
    %
    %   colorOrder = pnnl_colorOrder(n) returns the color order for n
    %   plotting elements.
    %
    %   Example
    % 
    %      % Compute Beer's law for each of the constituents in the napalm
    %      % data and plot with consistent color order for the constituent.
    %      load pnnl_napalm_data
    %      n = size(C_train,2);
    %      wavenumber_index = [175, 468, 1128];
    %      wavenumbers_of_inteterest = Wavenumbers(wavenumber_index);
    %      k_lambda = zeros(1,n);
    %          for i = 1:n
    %          k_lambda(i) = C_train(:,i) \ A_train(:,wavenumber_index(i));
    %      end
    %      figure;
    %      colorOrder = pnnl_colorOrder(n);
    %      legend_string = cell(1,2*n);
    %      legend_number = 0;
    %      for i = 1:n
    %          plot(C_train(:,i),A_train(:,wavenumber_index(i)),'o',...
    %              'MarkerEdgeColor',colorOrder(i,:),...
    %              'MarkerFaceColor',colorOrder(i,:),...
    %              'DisplayName',sprintf('%s, \\lambda = %d cm^{-1}',ConstituentNames{i},round(wavenumbers_of_inteterest(i))))
    %          hold on
    %          plot(C_train(:,i), C_train(:,i)*k_lambda(i),'Color',colorOrder(i,:),...
    %              'DisplayName',sprintf('%s fit',ConstituentNames{i}))
    %      end
    %      legend('Location','northwest')
    %      xlabel('Concentration (wt %)')
    %      ylabel('Absorbtion')
    %      set(gca,'FontSize',14)

    % Copyright 2022 Battelle Memorial Institute
    h = figure('visible','off');
    for k = 1:n
        plot(k,k);
        hold on;
    end
    colorOrder = h.Children.ColorOrder;
    close(h);
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