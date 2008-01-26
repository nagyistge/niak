function cell_words = niak_string2words(vec_string)

% Converts a strings into a cell of strings with individual words
%
% SYNTAX
% cell_words = niak_string2words(vec_string)
% 
% INPUT
% vec_string    (vector of strings) containing words separated by blanks
%
% OUTPUT
% cell_words    (cell of string) cell_words{n} is the nth word in
%                   vec_string
%
% COMMENTS
% 
% Copyright (c) Pierre Bellec 01/2008
%
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

vec_string = niak_rm_blank(vec_string);

ind = findstr([' ' vec_string ' '],' ');

for num_i = 1:length(ind)-1
    cell_words{num_i} = vec_string(ind(num_i):ind(num_i+1)-2);
end

