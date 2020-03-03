NB. convert/misc/base64
NB. Convert to/from base64 representations
NB. version: 1.0.1

NB. main functions:
NB.   tobase64         to base64 representation
NB.   frombase64       from base64 representation

cocurrent 'z'

BASE64=: (a.{~ ,(a.i.'Aa') +/i.26),'0123456789+/'

NB. =========================================================
NB.*tobase64 v To base64 representation
tobase64=: 3 : 0
res=. BASE64 {~ #. _6 [\ , (8#2) #: a. i. y
res, (0 2 1 i. 3 | # y) # '='
)

NB. =========================================================
NB.*frombase64 v From base64 representation
frombase64=: 3 : 0
pad=. _2 >. (y i. '=') - #y
pad }. a. {~ #. _8 [\ , (6#2) #: BASE64 i. y
)

NB. =========================================================
Note 'Testing'
A=: '1';'12';'123';'1234';'12345';'123456';'hi there';'qwerty'
(-: frombase64@tobase64) &> ,each A
)
NB. general/misc/numeric.ijs
NB. Various numeric utilities
NB. version: 1.0.0
NB.
NB.  baserep        y in base x
NB.  clean          clean y to tolerance of x (default 1e_10)
NB.  colsum         sum data columns of matrix by key
NB.  groupndx       group indices of y in x
NB.  int01          interval in n steps from 0 to 1 (= steps 0 1,n)
NB.  linsert        linear insert x (default 2) steps into y
NB.  randomize      sets a random value into random link
NB.  range          range from a to b [in steps of c]
NB.  recur          solves recurrence r(i)=a(i)+r(i-1)*m(i-1)
NB.  round          round y to nearest x (e.g. 1000 round 12345)
NB.  roundbanker    round y to nearest x with bankers rounding
NB.  rounddist      round y to nearest x preserving total
NB.  rounddown      round y down to nearest x
NB.  roundint       round to nearest integer
NB.  roundup        round y up to nearest x
NB.  steps          steps from a to b in c steps

cocurrent 'z'

NB.*baserep v y in base x
baserep=: (&#.) (^:_1)

NB.*int01 v interval in n steps from 0 to 1 (= steps 0 1,n)
int01=: i.@(+ *) % |

NB.*linsert v linear insert x (default 2) steps into y
linsert=: 2&$: : ([: +/\ {.@] , [ # (}. - }:)@] % [)

NB.*round v round y to nearest x (e.g. 1000 round 12345)
round=: [ * [: <. 0.5 + %~

NB.*rounddown v round y down to nearest x (e.g. 1000 round 12345)
rounddown=: [ * [: <. %~

NB.*roundint v round to nearest integer
roundint=: <.@:+&0.5

NB.*roundup v round y up to nearest x (e.g. 1000 round 12345)
roundup=: [ * [: >. %~

NB. =========================================================
NB.*clean v clean y to tolerance of x (default 1e_10)
NB. form: tolerance (default 1e_10) clean numbers
NB. sets values less than tolerance to 0
clean=: 1e_10&$: : (4 : 0)
if. L. y do.
  x clean each y
else.
  if. (3!:0 y) e. 16 16384 do.
    j./"1 y * x <: | y=. +.y
  else.
    y * x <: |y
  end.
end.
)

NB. =========================================================
NB.*colsum v sum data columns of matrix by key
NB. form: key colsum mat
NB. sum data columns of matrix on key columns
NB. e.g. if column 2 of mat is age, then
NB.    2 colsum mat
NB. sums the remaining columns by age
colsum=: 4 : 0
nub=. ~. key=. x{"1 y
nub /:~ nub x}"_1 1 key +//. y
)

NB. =========================================================
NB.*groupndx v group indices of y in x
NB. Return group indices of elements of y
NB. x is an integer vector of the starting numbers of each group,
NB. assumed to be in ascending order.
NB. e.g.  0 0 0 1 1 1 2 2  =  0 3 6 groupndx i.8
NB. i.e.  <:@(+/@(<:/))
NB. groupndx=: 4 : '<: (#x) }. (+/\r<#x) /: r=. /: x,y'
groupndx=: [: <: I. + e.~

NB. =========================================================
NB.*randomize v sets a random value into random link
randomize=: 3 : 0
 try.
   require 'guid'
   tmp=. _2 (3!:4) , guids 1
 catch.             NB. general/misc/guid.ijs not available
   tmp=. >:<.0.8*0 60 60 24 31#.0 0 0 0 _1+|.<.}.6!:0 ''
 end.
 ([ 9!:1) {.^:(2~:9!:42'') tmp    NB. set random initial random seed
)

NB. =========================================================
NB.*range v range from a to b [in steps of c]
NB. range a,b[,c] = range from a to b [in steps of c]
range=: 3 : 0
'x y n'=. 3{.y,1
s=. _1^y<x
x+s*n*i.>:<.n%~|y-x
)

NB. =========================================================
NB.*recur v solves recurrence r(i)=a(i)+r(i-1)*m(i-1)
NB. form: r = m recur a
NB.   r(0) = a(0)
NB.   r(i) = a(i)+r(i-1)*m(i-1)
NB. e.g    1.05 1.10 recur 100 100 100
NB.     100 205 325.5
recur=: 4 : 'r*+/\y%r=.*/\1,x$~<:#y'

NB. =========================================================
NB.*roundbanker v round y to nearest x with bankers rounding
NB.
NB. round y to nearest x
NB.
NB. if y is a mid point, it is rounded up if even, down if odd
NB.
NB.    0.1 roundbanker 1.23 2.15 2.25 2.35 2.45
NB. 1.2 2.2 2.2 2.4 2.4
roundbanker=: 4 : 0
rd=. <. d=. 0.5 + y % x
x * rd - (rd = d) > 0 = 2 | d
)

NB. =========================================================
NB.*rounddist v round y to nearest x preserving total
NB. distributive rounding
NB.
NB. round y to nearest x preserving total to nearest x
NB.
NB. e.g.
NB.    0.1 rounddist 6$0.45
NB. 0.5 0.4 0.5 0.4 0.5 0.4
rounddist=: 4 : 0
($y) $ x * (- 0 , }:) <. 0.5 + +/\ y % x
)

NB. =========================================================
NB.*steps v steps from a to b in c steps
NB. form: steps a,b,c
steps=: {. + (1&{ - {.) * (i.@>: % ])@{:
NB. math/misc/trig
NB. Trigonometric functions
NB. version: 1.0.0

NB.*sin v sin
NB.*cos v cos
NB.*tan v tan
NB.*sinh v sinh
NB.*cosh v cosh
NB.*tanh v tanh
NB.*arcsin v arcsin
NB.*arccos v arccos
NB.*arctan v arctan
NB.*arcsinh v arcsinh
NB.*arccosh v arccosh
NB.*arctanh v arctanh

NB.*atan2 v atan2

NB.*pi n pi

NB.*dfr v degrees from radians
NB.*rfd v radians from degrees

NB.*indegrees a convert function to use degrees:
NB.*sind v sin in degrees
NB.*cosd v cos in degrees
NB.*tand v tan in degrees

cocurrent 'z'

NB. =========================================================
sin=: 1&o.
cos=: 2&o.
tan=: 3&o.

sinh=: 5&o.
cosh=: 6&o.
tanh=: 7&o.

arcsin=: _1&o.
arccos=: _2&o.
arctan=: _3&o.

arcsinh=: _5&o.
arccosh=: _6&o.
arctanh=: _7&o.

atan2=: 12&o.

pi=: 1p1

dfr=: *&(180%pi)
rfd=: *&(pi%180)

NB. corresponding basic functions
sind=: sin @ rfd
cosd=: cos @ rfd
tand=: tan @ rfd

load 'graphics/view'

cocurrent 'jzviewdemo'
Names=: cutopen 0 : 0
Line
Covarplot
Repeat
Facet
Cars
)
ViewDemo=: 0 : 0
pc viewdemo closeok escclose;pn "View Demos";
bin v;
cc static1 static;cn "static1";
bin h;
cc listbox listbox;
bin v;
cc run button;cn "Run";
cc cancel button;cn "Cancel";
bin p12;
cc svg button;cn "Save svg";
cc png button;cn "Save png";
bin szzz;
pmove -1 -1 250 250;
rem form end;
)
viewdemo_listbox_button=: 3 : 0
if. (<'view') e. {."1 wdforms'' do.
  wd 'psel view;pclose'
end.
id=. > {: (".listbox_select) { Names
0!:101 LF,('D',id)~
)
viewdemo_cancel_button=: 3 : 0
wd 'pclose'
)
viewdemo_png_button=: 3 : 0
wd 'psel view'
f=. jpath '~home/',(tolower listbox),'.png'
wd 'cmd w call exporter *',f
)
viewdemo_svg_button=: 3 : 0
wd 'psel view'
f=. jpath '~home/',(tolower listbox),'.svg'
wd 'cmd w call exporter *',f
)
viewdemo_enter=: viewdemo_run_button=: viewdemo_listbox_button
run_viewdemo=: 3 : 0
t=. 'Select a demo from the list below.',LF2
t=. t,'Press Run again for new random data.'
t=. 'Select a demo from the list below.'
wd 'reset'
wd ViewDemo
wd 'set static1 text *',t
wd 'set listbox items ',;DEL,each Names,each DEL
wd 'set listbox select 0'
wd 'setfocus listbox'
wd 'pshow'
)
DCars=: 0 : 0
dat=. dec_pjson_ freads '~addons/graphics/view/data/cars_dict.json'
vd 'reset'
vd 'type facet1'
vd 'facetname Origin'
vd 'mark bar'
vd 'xname Horsepower'
vd 'yname Cylinders'
vd 'facetcols 1'
vd 'data';<dat
vd 'show'
)
DCovarplot=: 0 : 0
dat=. covarplot''
nms=. {."1 dat
vd 'reset'
vd 'type repeat'
vd 'multiwh 130 130'
vd 'ynames';<nms
vd 'xnames';<|.nms
vd 'data';<dat
vd 'show'
)
DFacet=: 0 : 0
dat=. dec_pjson_ freads '~addons/graphics/view/data/movies_dict.json'
vd 'reset'
vd 'type facet'
vd 'mark bar'
vd 'facetname MPAA_Rating'
vd 'xname Worldwide_Gross'
vd 'yname US_DVD_Sales'
vd 'facetcols 2'
vd 'data';<dat
vd 'show'
)
DLine=: 0 : 0
vd 'reset'
vd 'data';p:i.2 5
vd 'show'
)
DRepeat=: 0 : 0
dat=. dec_pjson_ freads '~addons/graphics/view/data/iris_dict.json'
nms=. {."1 dat
vd 'reset'
vd 'type repeat'
vd 'key ',0 pick nms
vd 'ynames';<}.nms
vd 'xnames';<|.}.nms
vd 'data';<dat
vd 'show'
)
covarplot=: 3 : 0

D10tdat=. 'm' fread '~addons/graphics/view/data/fj7.txt'
D10t=. ". }. D10tdat
C=. (] % +/) "1
D10tc=. C D10t

h01=. 1 1 1 _1 _1 _1 2 _1 _1 2 _1 _1
h23=. 0 1 _1 0 1 _1 2 _1 _1 _2 1 1
h4=. 0 1 _1 0 _1 1
H=. 5 6 $ h01,h23,h4

leng=. ] % (%: @( [: +/ *:))
H1=. leng"1 H
mp=. +/ . *
D10tz=. (^. D10tc) mp |: H1

varnames=. ;: '"' -.~ ' "Gen" "Emp" "Jos" "EmpG" "JosG" '

varnames,.;/|:D10tz
)
run_viewdemo$0
