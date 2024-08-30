function filteredPaths = genpath_clean(FOLDERNAME)
%GENPATH_CLEAN Generate recursive toolbox path but cleaner.
%   P = genpath_clean(FOLDERNAME) returns a character vector containing a path 
%   name that includes FOLDERNAME and all subfolders of FOLDERNAME, 
%   including empty subfolders. But exclude all hidden dir starting with .
%   
%   E.g.    A
%           ├── .B
%           └── C
%   Then genpath_exclude(A) returns A and A/C as 'A:A/C' but no A/.B

allPaths = genpath(FOLDERNAME);

pathList = strsplit(allPaths, pathsep);

filteredPathList = pathList(~cellfun(@(x) any(contains(x, [filesep, '.'])), pathList));

filteredPaths = strjoin(filteredPathList, pathsep);
end