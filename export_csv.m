%
% loop through permuted rms array for
%    - columns: subjects
%    - rows: reps
%
%    loop for:
%    - time (pre, mid, post)
%    - emg (1: VL 2: VM)
%    - phase (C1-C2 and C3-C4)
%    - set (1,2)
%    - load (old,new)
%
% export to csv files
%

% set export directory




% permute rms of the format specified in import_csv

prms = permute (rms,[1,7,2,3,4,5,6]);

s_time= cellstr(["pre"; "mid"; "post"] );
s_emg = cellstr(["VL"; "VM"]);
s_phase = cellstr(["con"; "ecc"]);
s_set = cellstr(["set1"; "set2"]);
s_load = cellstr(["old"; "new"]);



for time = 1:3
    for emg = 1:2
        for phase = 1:2
            for load = 1:2
                for set = 1:2
                    filename = cstrcat(
                        exportdir,
                        "DD_men_",
                        char(s_time(time)),"_",
                        char(s_emg(emg)),"_",
                        char(s_phase(phase)),"_",
                        char(s_load(load)),"_",
                        char(s_set(set)),
                        ".csv");
                        
                    csvwrite(filename, prms(:,2:11,time,phase,emg,load,set));
                end
            end
        end
    end
end
