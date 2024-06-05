%%%%%%%%%%%%%% USER-SPECIFIED area %%%%%%%%%%

datadir = [get_path('mcrlter'),'processing/unprocessed_data/ADCP/'];
outdir = datadir;
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
   % specify the raw files
   
   datalist = dir([datadir '*ADCP*.10.1.000']);   
   tempstruct = datalist(find([datalist(:).isdir]==0 & [datalist(:).bytes]>20000 ));  
                     % NOTE: within lter there were some valid 001.000 files.                       
                                             
                  if isempty(tempstruct)   
                     fprintf('\n--> No data files found in \n');
                     disp(datadir)
                     fprintf(' <--\n')
                     return
                  end
        % Now arrange it so that the file names are a vertical 
        % cell array of strings called filelist             
        tempfilelist = struct2cell(tempstruct);    
        list = char(tempfilelist(1,:));
        clear tempfilelist datalist tempstruct
        
        

for p = 1:size(list,1)
        
                    
        binary_out = [datadir,list(p,:)];
        disp('processing binary ADCP data....');
                          
                          
%     % defuse millenium bug here.  
%     % unfortunately our .000 files don't have the century info in them
%                           
%     if str2num(list(p,22)) == 2   % if first character in yyyy is 2 then...
%         mill_bug = 2000;
%     else
%         mill_bug = 1900;
%     end
                       
                           
%  convert RDI raw adcp data to .20.1.mat file
  [adcp,cfg,ens]=rdradcp(binary_out,1,-1);        
                           
  adcp.file_name_original = upper(list(p,1:29 ));  % 
%   
   fname = [upper([list(p,1:29),'.20.1']),'.mat'];  
   
    
  
   
     disp(['saving out ',fname]);  % unprocessed matlab structure
     save([outdir, fname],'adcp','ens');
     
    clear adcp cfg ens binary_out junk mill_bug
    
    
        
  % call this function to create two files .30.1.mat and .40.1.txt  
  
   ADCP_rdradcpOutput_2_DatabaseFormat(datadir, outdir, fname(1:29))

  
  
    
 end    % end for p loop
  clear p 
   
  return
