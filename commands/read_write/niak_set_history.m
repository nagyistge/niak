function hdr2 = niak_set_history(hdr,opt)

% Write a new line of history in a header
%
% SYNTAX
% HDR2 = NIAK_SET_HISTORY(HDR,OPT)
% 
% INPUTS
% HDR           (structure) header of a 3D or 3D+t data file (see NIAK_READ_VOL).
% OPT           (struture) with the following fields :
%               COMMAND (string, default '') the name of the command applied.
%               FILES_IN   (structure, cell of strings or strings, default
%                      struct()) List of input files.
%               FILES_OUT  (structure, cell of strings or strings, default
%                      struct() ) List of output files.
%               COMMENT (string, default struct()) user specified comment.
% 
% OUTPUTS
% HDR2          (structure) same as HDR, yet the HDR.INFO.HISTORY has a new line.
% 
% COMMENTS
% Copyright (c) Pierre Bellec 01/2008

% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:
%
% The above copyright notice and this permission notice shall be included in
% all copies or substantial portions of the Software.
%
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
% THE SOFTWARE.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Setting up default values for the header %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
gb_name_structure = 'opt';
gb_list_fields = {'command','files_in','files_out','comment'};
gb_list_defaults = {'',struct(),struct(),''};
niak_set_defaults

niak_gb_vars

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Building one line of history %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Generic info (date, username, version of the NIAK, etc...)
str_hist = datestr(now);
str_hist = [str_hist ' ' gb_niak_user ' on a ' gb_niak_OS ' system used NIAK v' gb_niak_version '>>>> '];

%% Name of the command
if ~isempty(opt.command)
    str_hist = [str_hist opt.command ' : '];
end

%% List of inputs
if isstruct(opt.files_in)
    list_field = fieldnames(opt.files_in);

    if ~isempty(list_field);
        str_hist = [str_hist 'INPUTS: '];
        for num_f = 1:length(list_field)
            list_files_in = getfield(opt.files_in,list_field{num_f});
            str_hist = [str_hist list_field{num_f} '('];

            if iscell(list_files_in)
                for num_i = 1:length(list_files_in)
                    if num_i == 1
                        str_hist = [str_hist list_files_in{num_i}];
                    else
                        str_hist = [str_hist ',' list_files_in{num_i}];
                    end
                end
            else
                str_hist = [str_hist ',' list_files_in];
            end

            str_hist = [str_hist ') ,'];
        end
    end
elseif iscellstr(opt.files_in)
    if ~isempty(opt.files_in);
        str_hist = [str_hist 'INPUTS: '];
        for num_f = 1:length(list_field)
            if num_f == 1
                str_hist = [str_hist opt.files_in{num_i}];
            else
                str_hist = [str_hist ',' opt.files_in{num_i}];
            end
        end


        str_hist = [str_hist ') ,'];
    end
elseif ischar(opt.files_in)
    str_hist = [str_hist 'INPUTS: ' opt.files_in '; '];
end

%% List of outputs
if isstruct(opt.files_out)
    list_field = fieldnames(opt.files_out);

    if ~isempty(list_field);
        str_hist = [str_hist 'OUTPUTS: '];
        for num_f = 1:length(list_field)
            list_files_out = getfield(opt.files_out,list_field{num_f});
            str_hist = [str_hist list_field{num_f} '('];

            if iscell(list_files_out)
                for num_i = 1:length(list_files_out)
                    if num_i == 1
                        str_hist = [str_hist list_files_out{num_i}];
                    else
                        str_hist = [str_hist ',' list_files_out{num_i}];
                    end
                end
            else
                str_hist = [str_hist ',' list_files_out];
            end

            str_hist = [str_hist ') ,'];
        end
    end
elseif iscellstr(opt.files_out)
    if ~isempty(opt.files_out);
        str_hist = [str_hist 'OUTPUTS: '];
        for num_f = 1:length(list_field)
            if num_f == 1
                str_hist = [str_hist opt.files_out{num_i}];
            else
                str_hist = [str_hist ',' opt.files_out{num_i}];
            end
        end


        str_hist = [str_hist ') ,'];
    end
elseif ischar(opt.files_out)
    str_hist = [str_hist 'OUTPUTS: ' opt.files_out '; '];
end

%% Comment
if ~isempty(opt.comment)
    str_hist = [str_hist ' ,COMMENT: ' opt.comment];
end   

%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Updating the header  %%
%%%%%%%%%%%%%%%%%%%%%%%%%%
hdr2 = hdr;
flag_done = 0;
while (length(hdr2.info.history)>1)&(flag_done == 0)
    if (double(hdr2.info.history(end))==10)
        hdr2.info.history = hdr2.info.history(1:end-1);
    else
        flag_done = 1;
    end
end

if ~isempty(hdr2.info.history)
    hdr2.info.history = [hdr2.info.history char(10) str_hist char(10)];
else
    hdr2.info.history = [str_hist char(10)];
end
