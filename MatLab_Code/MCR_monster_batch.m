% use this mfile to batch process monster files based on site/year/or
% modify to suit your needs.
% Works in conjunction (calls) MCR_monster_generator.m

clear variables
close all
fclose all;
clc

if ispc
    %for windows
    addpath('M:/internal/research/monitoring/physo/Matlab_R_code/a_mfile_library/');
else
    %for mac
    addpath('/Volumes/mcrlter/internal/research/monitoring/physo/Matlab_R_code/a_mfile_library/');
end

addpath([get_path('mcrlter'),'Matlab_R_code/MCR/MONSTER/bin_depths/']);
addpath([get_path('mcrlter'),'Matlab_R_code/MCR/MONSTER/tides/']);
addpath([get_path('mcrlter'),'Matlab_R_code/MCR/MONSTER/adcp_preprocessing/']);


adcp_data_indir = [get_path('mcrlter'),'processing/adcp/']; 
therm_data_indir = [get_path('mcrlter'),'processing/thermistor/']; 
  btm_data_indir = [get_path('mcrlter'),'processing/btm/'];
  ctd_data_indir   = [get_path('mcrlter'),'processing/ctd/']; 
  wvt_data_indir   = [get_path('mcrlter'),'processing/wvt/']; 
 
 finalfolder = [get_path('mcrlter'),'data/monster/'];
 outdir = [get_path('mcrlter'),'processing/unprocessed_data/monster/'];
         
 %dep_year = {'2005';'2006';'2007';'2008';'2009';'2010';'2011'};
 dep_year = {'2023' ; '2024'};
 
%stn     1       2       3       4
%     'CBYTS' 'FOR01' 'FOR04' 'FOR05'
         
%stn = [2 3 4];  % scalar [2] vector [2:4]ok here
stn = [2];

% when all the figures are checked, change text and concat to 1 and
% directly output into final folder.
text_switch = 0; % write out the txt file or not. 
concat_switch = 0;  % set to 1 if processing latest year
revision_string = '.05.001.026'; % 
%--------------------------------------------------------------------------
%   % uncomment this to batch process all monsters for site(s) 'stn'

if text_switch % if we need to concate files, switch to final folder
    
    outdir = finalfolder;
end

for jj = 1:length(dep_year)
for ii = 1:length(stn)
    
    % note: remember that the cbyts storage directory has .mat files in old format
    % and .txt and concatenated files in the new format.  Save new format .mat files
    % to scratch for figure generation (still have to get this sorted out)
    
    if stn==1 % CBYTS only
        
        keyboard % this mooring terminated
        
%          MCR_monster_generator_CBYTS(adcp_data_indir, ...
%                            therm_data_indir, ...
%                            btm_data_indir, ...
%                            ctd_data_indir, ...
%                            wvt_data_indir, ...
%                                outdir, ...
%                                dep_year{jj}, ...
%                                stn(ii), ...
%                                concat_switch, ...
%                                revision_string);
                                 
        
    else
                MCR_monster_generator(adcp_data_indir, ...
                           therm_data_indir, ...
                           btm_data_indir, ...
                           ctd_data_indir, ...
                           wvt_data_indir, ...
                               outdir, ...
                               dep_year{jj}, ...
                               stn(ii), ...
                               concat_switch, ...
                               text_switch,...
                               revision_string);
    end
end
end
%-------------------------------------------------------------------------


%-------------------------------------------------------------------------

return
