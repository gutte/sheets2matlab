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

filename = "output_mpf.csv";

V = mpf;   %rms or mpf

N = size(V,1);

% permute rms of the format specified in import_csv

pV = permute (V,[1,7,2,3,4,5,6]);

s_time= cellstr(["pre"; "mid"; "post"] );
s_emg = cellstr(["VL"; "VM"]);
s_phase = cellstr(["con"; "ecc"]);
s_load = cellstr(["old"; "new"]);
s_set = cellstr(["set1"; "set2"]);

A = [];

for time = 1:3
    for emg = 1:2
        for phase = 1:2
            for load = 1:2
                for set = 1:2

                    new = cat(2,ones(N,1)*[time emg phase load set],(1:N)',pV(:,1:12,time,phase,emg,load,set));
                    A = cat(1,A,new);
                    
                end
            end
        end
    end
end


csvwrite(filename, A);
