%
%
% read in a "multidimensional" csv file to matlab
% various position parameters (dimensions) are specified manually
%
%
% ts (                          timestamps for phase markers
%
%       [subject index],        "row" number (indexed in subjectIDs)
%       [time],                 1: pre, 2: mid, 3: post
%       [position],             1: C1, 2: C2, 3: C3, 4: C4
%       [load],                 1: old, 2: new
%       [set],                  1-2
%       [rep])                  1-12
%
% rms (                         EMG rms values  
%
%       [subject index],        "row" number (indexed in subjectIDs)
%       [time],                 1: pre, 2: mid, 3: post
%       [phase],                1: C1-C2, 2: C3-C4, 3: C1-C4
%       [emg],                  1-3
%       [load],                 1: old, 2: new
%       [set],                  1-2
%       [rep] )                 1-12
%
% mpf (                         EMG mpf values  
%
%       [subject index],        "row" number (indexed in subjectIDs)
%       [time],                 1: pre, 2: mid, 3: post
%       [phase],                1: C1-C2, 2: C3-C4
%       [emg],                  1-3
%       [load],                 1: old, 2: new
%       [set],                  1-2
%       [rep] )                 1-12
%

% ---------- edit parameters manually here

N = 20;          % number of subjects

csvdir = 'csv/';  % directory of csv files
    
reps = 12;       % number of reps (sheets)



% ---------- column and row offsets in data file

% determine column offsets

% timestamp (cursor points: C1,C2,C3,C4)
ts_offset(1) = 1;
ts_offset(2) = 6;
ts_offset(3) = 13;
ts_offset(4) = 19;

% rms: phases 1:C1-C2, 2: C3-C4, 3: C1-C4
% rms_offset(phase, emg)
rms_offset(1,1) = 25;
rms_offset(1,2) = 31;
rms_offset(1,3) = 37;
rms_offset(2,1) = 43;
rms_offset(2,2) = 49;
rms_offset(2,3) = 55;
rms_offset(3,1) = 61;
rms_offset(3,2) = 67;
rms_offset(3,3) = 73;

% mpf: phases 1:C1-C2, 2: C3-C4
% mpf_offset(phase, emg)
mpf_offset(1,1) = 79;
mpf_offset(1,2) = 85;
mpf_offset(1,3) = 91;
mpf_offset(2,1) = 97;
mpf_offset(2,2) = 103;
mpf_offset(2,3) = 109;


% determine set and load starting points (-1 row)
% (dimensions are offset by rows in csv file)
% this assumes:
% 2 rows before first data matrix
% 5 rows between data matrices

% row_offset(load, set)   (load 1:old 2: new)
row_offset(1,1) = 1;
row_offset(1,2) = 6+N;
row_offset(2,1) = 11+2*N;
row_offset(2,2) = 16+3*N;


% ---------- empty old variables

clear ts;
clear rms;
clear mpf;

% ---------- Start reading csv


% read data

for rep = 1:reps
    sheet = cstrcat(csvdir, "Rep ",int2str(rep),".csv");
    for load = 1:2
        for set = 1:2
            for cursor = 1:4
                ts(:,:,cursor,load,set,rep) = dlmread (sheet,",",[row_offset(load,set)+1, ts_offset(cursor), row_offset(load,set)+N, ts_offset(cursor)+2 ]);
            end
            for emg = 1:3
                for phase = 1:3
                    rms(:,:,phase,emg,load,set,rep) = dlmread (sheet,",",[row_offset(load,set)+1, rms_offset(phase,emg), row_offset(load,set)+N, rms_offset(phase,emg)+2 ]);
                end
                for phase = 1:2
                    mpf(:,:,phase,emg,load,set,rep) = dlmread (sheet,",",[row_offset(load,set)+1, mpf_offset(phase,emg), row_offset(load,set)+N, mpf_offset(phase,emg)+2 ]);
                end
            end
        end
    end
end

% replace all zeros with NaN
% (should fix "emptyvalue" parameter in dlmread)

ts(ts == 0) = NaN;
rms(rms == 0) = NaN;
mpf(mpf == 0) = NaN;


