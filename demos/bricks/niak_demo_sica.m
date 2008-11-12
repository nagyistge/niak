
%
% _________________________________________________________________________
% SUMMARY NIAK_DEMO_SICA
%
% This is a script to demonstrate the usage of :
% NIAK_BRICK_SICA
%
% SYNTAX:
% Just type in NIAK_DEMO_SICA
%
% _________________________________________________________________________
% OUTPUT
% This script will run a spatial independent component analysis on the
% functional data of subject 1 (motor condition), and use the default names
% of the outputs.
%
% It will also select the independent components using a spatial prior map.
% and suppress the selected component (the spatial map is actually not in
% the same space as the functional data, so the selection is pretty random,
% but this is to demonstrate how to use the scripts).
%
% _________________________________________________________________________
% COMMENTS
%
% NOTE 1
% This script will clear the workspace !!
%
% NOTE 2
% Note that the path to access the demo data is stored in a variable
% called GB_NIAK_PATH_DEMO defined in the script NIAK_GB_VARS.
% 
% NOTE 3
% The demo database exists in multiple file formats.NIAK looks into the demo 
% path and is supposed to figure out which format you are intending to use 
% by himself.You can the format by changing the variable GB_NIAK_FORMAT_DEMO 
% in the script NIAK_GB_VARS.
% _________________________________________________________________________
% Copyright (c) Pierre Bellec, Montreal Neurological Institute, 2008.
% Maintainer : pbellec@bic.mni.mcgill.ca
% See licensing information in the code.
% Keywords : medical imaging, slice timing, fMRI

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

clear
niak_gb_vars

%%%%%%%%%%%
%% SICA %%%
%%%%%%%%%%%

%% Setting input/output files
switch gb_niak_format_demo
    
    case 'minc2' % If data are in minc2 format
        
        files_in = cat(2,gb_niak_path_demo,filesep,'func_motor_subject1.mnc');
        
    case 'minc1' % If data are in minc1 format

        files_in = cat(2,gb_niak_path_demo,filesep,'func_motor_subject1.mnc.gz');

    otherwise 
        
        error('niak:demo','%s is an unsupported file format for this demo. See help to change that.',gb_niak_format_demo)
        
end

files_out.space = ''; % The default output name will be used
files_out.time = ''; % The default output name will be used
files_out.figure = ''; % The default output name will be used

%% Options
opt.nb_comp = 10;
opt.flag_test = 0; % This is not a test, the slice timing is actually performed

%% Job
[files_in,files_out,opt] = niak_brick_sica(files_in,files_out,opt);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Component selection : ventricle %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Setting input/output files
files_in_comp_sel.fmri = files_in;
files_in_comp_sel.component = files_out.time;
files_in_comp_sel.mask = cat(2,gb_niak_path_niak,filesep,'template',filesep,'roi_ventricle.mnc');
files_in_comp_sel.component_to_keep = cat(2,gb_niak_path_demo,filesep,'motor_design.dat');
files_out_comp_sel = '';

%% Options
opt_comp_sel.flag_test = 0;

%% job
[files_in_comp_sel,files_out_comp_sel,opt_comp_sel] = niak_brick_component_sel(files_in_comp_sel,files_out_comp_sel,opt_comp_sel);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Suppression of physiological noise %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Setting input/output files
files_in_supp.fmri = files_in;
files_in_supp.space = files_out.space;
files_in_supp.time = files_out.time;
files_in_supp.compsel{1} = files_out_comp_sel;
files_out_supp = '';

%% Options
opt_supp.flag_test = 0;
opt_supp.threshold = 0.05;

%% job
[files_in_supp,files_out_supp,opt_supp] = niak_brick_component_supp(files_in_supp,files_out_supp,opt_supp);
