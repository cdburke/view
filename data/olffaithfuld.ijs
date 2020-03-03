NB.  old faithful data 

require 'stats/base'
require 'plot'


a =: 'm' fread 'c:\users\frasert\j901-user\projects\data\oldfaithful.ijs'
b =: 26 drop a
c =: ". b

'id eruptions waiting' =: |: c
erase 'a b'


10 take "1 (21 var\eruptions),: 21 mean \ eruptions   
plot  dev "1 (21 var\eruptions),: 21 mean \ eruptions


NB.  Some tests of univariate density functions
NB.  quantiles and histogram graphics

