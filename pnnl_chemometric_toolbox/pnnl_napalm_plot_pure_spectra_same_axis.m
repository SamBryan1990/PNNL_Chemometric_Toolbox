function pnnl_napalm_plot_pure_spectra_same_axis
    %pnnl_napalm_plot_pure_spectra_same_axis Plot pure spectra on same axis

    % Copyright 2022-2023 Battelle Memorial Institute
    data = load('pnnl_napalm_data');
    ConstituentNames = data.ConstituentNames;
    Wavenumbers = data.Wavenumbers;
    WavenumberLabel = data.WavenumberLabel;

    % Pure spectra
    pure_spectra = pnnl_napalm_pure_spectra;

    figure
    % Get first three default colors and clear the figure
    plot(1,1,2,2,3,3);
    colorOrder = get(gca,'ColorOrder');
    clf

    plot(Wavenumbers,pure_spectra(1,:),'LineWidth',2,'Color',colorOrder(1,:))
    hold on
    title('Absorbance Spectra of Pure Compounds')
 
    plot(Wavenumbers,pure_spectra(2,:),'LineWidth',2,'Color',colorOrder(2,:))

    plot(Wavenumbers,pure_spectra(3,:),'LineWidth',2,'Color',colorOrder(3,:))
    
    legend(ConstituentNames)
    xlabel(WavenumberLabel,'Interpreter','tex');
    ylabel('Absorbance')
    h = gca;
    set(h,'FontSize',14);
    set(h,'YLim',[-0.02 2.25]);
    set(h,'XLim',[700 4000]);
    hold off
end
% Disclaimer
%
% This material was prepared as an account of work sponsored by an agency
% of the United States Government.  Neither the United States Government
% nor the United States Department of Energy, nor Battelle, nor any of
% their employees, nor any jurisdiction or organization that has cooperated
% in the development of these materials, makes any warranty, express or
% implied, or assumes any legal liability or responsibility for the
% accuracy, completeness, or usefulness or any information, apparatus,
% product, software, or process disclosed, or represents that its use would
% not infringe privately owned rights.
% 
% Reference herein to any specific commercial product, process, or service
% by trade name, trademark, manufacturer, or otherwise does not necessarily
% constitute or imply its endorsement, recommendation, or favoring by the
% United States Government or any agency thereof, or Battelle Memorial
% Institute. The views and opinions of authors expressed herein do not
% necessarily state or reflect those of the United States Government or any
% agency thereof.
% 
%                  PACIFIC NORTHWEST NATIONAL LABORATORY
%                               operated by
%                                 BATTELLE
%                                 for the
%                    UNITED STATES DEPARTMENT OF ENERGY
%                     under Contract DE-AC05-76RL01830