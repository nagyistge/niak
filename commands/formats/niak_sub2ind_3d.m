function ind = niak_sub2ind_3d(siz,subx,suby,subz)
%
% _________________________________________________________________________
% SUMMARY NIAK_SUB2IND_3D
%
% Convert 3D coordinates into linear indices
%
% SYNTAX :
% IND = NIAK_SUB2IND_3D(SIZ,SUB)
%
% _________________________________________________________________________
% INPUTS :
%
% SIZ
%       (vector 1*3) the size of the 3D array
%
% SUB
%       (array N*3) SUB(M,:) are 3D coordinates of the Mth element
%
% _________________________________________________________________________
% OUTPUTS :
%
% IND
%       (vector N*1) IND(M) is the linear index corresponding to SUB(M,:).
%
% _________________________________________________________________________
% COMMENTS : 
%
% This implementation of the classic matlab SUB2IND is markedly faster
% because it notably avoids to check that the coordinates are valid (i.e. 
% within bounds).
%
% Copyright (c) Pierre Bellec, Montreal Neurological Institute, 2008.
% Maintainer : pbellec@bic.mni.mcgill.ca
% See licensing information in the code.
% Keywords : indices, matlab

% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, subxlicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subxject to the following conditions:
%
% The above copyright notice and this permission notice shall be included in
% all copies or subxstantial portions of the Software.
%
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
% THE SOFTWARE.
if nargin == 2
    ind = subx(:,1) + (subx(:,2)-1)*siz(1) + (subx(:,3)-1)*siz(1)*siz(2);
else
    ind = subx + (suby-1)*siz(1) + (subz-1)*siz(1)*siz(2);
end