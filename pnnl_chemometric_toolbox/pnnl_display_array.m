function pnnl_display_array(label,row_labels,column_labels,array)

    % Copyright 2022 Battelle Memorial Institute
    column1_width = max(length(label),max(cellfun(@length,row_labels))) + 2;
    field_width = max([12,cellfun(@length,column_labels)]) + 2;

    dash = repmat('-',1,column1_width+field_width*length(column_labels));
    fprintf(dash);
    fprintf('\n');
    column1_format = ['%',int2str(column1_width),'s'];
    string_format = ['%',int2str(field_width),'s'];
    number_format = ['%',int2str(field_width),'.5g'];

    fprintf(column1_format,label)
    fprintf(string_format,column_labels{:})
    fprintf('\n');
    
    for i = 1:length(row_labels)
        fprintf(column1_format,row_labels{i});
        fprintf(number_format,array(i,:));
        fprintf('\n');
    end
    fprintf(dash);
    fprintf('\n');
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