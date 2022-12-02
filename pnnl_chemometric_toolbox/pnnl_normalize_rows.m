function Y = pnnl_normalize_rows(X)
    % pnnl_normalize_rows Normalize the rows of a matrix.
    %
    %   Y = pnnl_normalize_rows(X) normalizes each row of X by the 2-norm
    %   of that row, so that the norm of each row of Y is one.
    %
    %   Example:
    %
    %     X = [1, 2, -3;-6, 5, 4;7, -9, 8]
    %     Y = pnnl_normalize_rows(X)
    %     norm(Y(1,:))
    %     norm(Y(2,:))
    %     norm(Y(3,:))

    % Copyright 2022 Battelle Memorial Institute
    Y = zeros(size(X));
    for k = 1:size(X,1)
        Y(k,:) = X(k,:)/norm(X(k,:));
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