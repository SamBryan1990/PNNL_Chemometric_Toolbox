function pnnl_napalm_plot_scores(displayConcentrations)

    % Copyright 2022 Battelle Memorial Institute
    if nargin < 1
        displayConcentrations = [];
    end
    if isempty(displayConcentrations)
        displayConcentrations = false;
    end

    data = load('pnnl_napalm_data');
    A_train = data.A_train;
    A_unknown = data.A_unknown;
    C_train = data.C_train;
    C_validation = data.C_validation;
    ConstituentNames = data.ConstituentNames;
    n = size(C_train,2);
    combos = nchoosek(1:n,2);
    % Training set
    for i = 1:size(combos,1)
        pnnl_plot_scores(A_train,C_train,combos(i,1),combos(i,2),ConstituentNames,displayConcentrations)
    end
    % Validation set
    for i = 1:size(combos,1)
        pnnl_plot_scores(A_unknown,C_validation,combos(i,1),combos(i,2),ConstituentNames,displayConcentrations)
    end

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