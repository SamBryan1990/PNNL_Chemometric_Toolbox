function rmse = pnnl_rmse(C_computed,C_actual)
    %pnnl_rmse Root mean squared error (RMSE)
    %
    %   pnnl_rmse(C_computed,C_actual) returns the root mean squared error 
    %   between the computed and actual concentrations.
    %
    %   RMSE is theoretically equivalent to
    %      sqrt(mean((C_actual - C_computed).^2, 1 ))
    %   but is computed using VECTORM in a more robust manneer with respect
    %   to very large and very small numbers.

    % Copyright 2022-2023 Battelle Memorial Institute
    p = size(C_actual,1);
    rmse = vecnorm(C_computed - C_actual, 2, 1) / sqrt(p);

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