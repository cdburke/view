coclass 'jzview'

Debug=: 0
destroy=: codestroy
CLF=: ',',LF

enc=: enc_pjson_
matchhead=: [ -: #@[ {. ]
sep=: }.@;@:(','&,each)
splits=: {. ; }.@}.
tomatrix=: (_2 {. 1 1 , $) $ ,
encshapes=: 3 : 0
LF -.~ 'shapes=',enc (;:'rws cls width height'),.;/y
)
pos_center=: 3 : 0
'vw vh'=. y
'sw sh'=. 2 3 { 0 ". wd 'qscreen'
y ,~ 0 >. <. -: (sw-vw),sh-vh+50
)
pos_fit=: 3 : 0
'vw vh'=. y
'px py'=. 2 {. 0 ". wd'qform'
'sw sh'=. 2 3 { 0 ". wd 'qscreen'
px=. 0 >. px + 0 <. sw - px + vw
py=. 0 >. py + 0 <. sh - py + vh
px,py,y
)
pos_topleft=: 3 : 0
10 10,y
)
remline=: 4 : 0
t=. <;.2 x,LF
t=. t #~ -. (1 e. y E. ]) &> t
}: ; t
)
Hwndp=: ''
Size=: 600 450
j=. <;._2 (0 : 0)
autosize S
data D
defpos V
defs S
facetcols B
facetname S
fold S
height N
key S
labelangle N
legend S
linewidth N
mark S
multiwh V
names B
shapes V
sizing S
title S
type S
values D
viewsize V
width N
xcaption S
xname S
xnames B
ycaption S
yname S
ynames B
)

DefNames=: (j i.&> ' ') {.each j
DefTypes=: ({:&> j),'X'
plotdefs=: 3 : 0
autosize=: ''
data=: ''
defpos=: pos_topleft Size
defs=: ''
facetcols=: 0
facetname=: ''
fold=: ''
height=: 0
key=: ''
labelangle=: 0
legend=: ''
linewidth
multiwh=: 150 150
names=: ''
shapes=: $0
sizing=: ''
title=: ''
type=: 'line'
values=: 0
viewsize=: $0
width=: 0
xcaption=: ''
xname=: ''
xnames=: ''
ycaption=: ''
yname=: ''
ynames=: ''
)
plot_bar=: 3 : 0
'nms val ind txt cls'=. makedata y
rws=. (#nms)-ind
len=. rws * cls
wid=. 2.5 2 1.5 1 {~ +/len > 50 150 300
def=. 'fold=',enc ind}.nms
def=. def,LF,'barwidth=',":wid
def=. def,LF,'title=''just testing'''
def=. def,LF,'xcaption=''x caption'''
def=. def,LF,'ycaption=''y caption'''
txt,def,LF,Bar
)
makedata=: 3 : 0
'nms val ind'=. makedata1 y
txt=. ('names=',enc nms),LF,('values=',enc val),LF
cls=. #0 pick val
nms;val;ind;txt;cls
)
makedata1=: 3 : 0
if. L. y do.
  r=. #$y
  if. 2=r do. (<"1 |:y),<0 return. end.
  if. 2<r do. throw 'rank not supported: ',":r end.
  'dx dy'=. tomatrix each y
else.
  dy=. tomatrix y
  dx=. ,:i.{:$dy
end.
val=. <"1 dx,dy
nms=. ('f',":) each i. #val
nms;val;#dx
)
plot_facet=: 3 : 0
'nms val ind txt cls'=. makedata data

len=. # ~.(nms i. <facetname) pick val
cls=. 0 ". facetcols
rws=. >. len % cls

def=. encshapes rws,cls,multiwh
def=. def,LF,'facetname="',facetname,'"'
def=. def,LF,'mark="',mark,'"'
def=. def,LF,'xname="',xname,'"'
def=. def,LF,'yname="',yname,'"'
def=. def,LF,'sizing="facet"'

txt,def,LF,Facet
)
plot_facet1=: 3 : 0
'nms val ind txt cls'=. makedata data

def=. encshapes 3 1,multiwh
def=. def,LF,'facetname="',facetname,'"'
def=. def,LF,'mark="',mark,'"'
def=. def,LF,'xname="',xname,'"'
def=. def,LF,'yname="',yname,'"'
def=. def,LF,'sizing="facet"'

txt,def,LF,Facet1
)
ViewHdr=: 0 : 0
<!DOCTYPE html>
<html><head>
<meta charset="utf-8"/>
<meta http-equiv="expires" content="0"/>
<title>View</title>
<link rel="stylesheet" href="view.css"/>
<script src="qrc:///qtwebchannel/qwebchannel.js"></script>
<script src="js/d3/d3.min.js"></script>
<script src="js/vega/vega-core.min.js"></script>
<script src="js/vega/vega-lite.min.js"></script>
<script src="view.js"></script><script>
)
ViewFini=: 0 : 0
</script></head><body>
<div id="draw"></div>
<canvas id="qextcan"></canvas>
</body></html>
)
ScriptFini=: 0 : 0
window.onload = function() {
new QWebChannel(qt.webChannelTransport, function(channel) {
qcom = channel.objects.qcom;
qcom.qNotify.connect(jnotify);
drawchart();
});
}
)
plot_line=: 3 : 0
'nms val ind txt cls'=. makedata data
rws=. (#nms)-ind
len=. rws * cls
wid=. 2.5 2 1.5 1 {~ +/len > 50 150 300
def=. 'fold=',enc ind}.nms
def=. def,LF,'linewidth=',":wid
def=. def,LF,'legend={}'
def=. def,LF,'title="',title,'"'
def=. def,LF,'xcaption="',xcaption,'"'
def=. def,LF,'ycaption="',ycaption,'"'
txt,def,LF,Line
)
plot_repeat=: 3 : 0
'nms val ind txt cls'=. makedata data

def=. encshapes (#ynames),(#xnames),multiwh
def=. def,LF,'key=',enc key
def=. def,LF,'ynames=',enc ynames
def=. def,LF,'xnames=',enc xnames
def=. def,LF,'sizing="repeat"'

txt,def,LF,Repeat
)
T=: jpath '~/temp/data.js'
U=: jpath '~/temp/view.js'
V=: jpath '~/temp/test.html'
vd=: 3 : 0
if. L. y do. setoption y return. end.
'id val'=. (y i. ' ') splits y
if. id -: 'reset' do. vd_reset val return. end.
if. id -: 'show' do. vd_show val return. end.
setoption id;<val
EMPTY
)
setoption=: 3 : 0
'id val'=. y
select. (DefNames i. <id) { DefTypes
case. 'N' do. val=. {. 0 ". val
case. 'V' do. val=. , 0 ". val
case. 'X' do. sminfo 'name not found: ',id return.
end.
(id)=: val
EMPTY
)
vd_reset=: 3 : 0
plotdefs''
EMPTY
)
vd_show=: 3 : 0
txt=. ('plot_',type)~''

if. Debug do.
  ndx=. 1 + 1 { I. txt = LF
  (ndx {. txt) fwrites T
  (ndx }. txt) fwrites U
  def=. ViewHdr remline 'qwebchannel'
  (def,txt,'jpost=same',LF,ViewFini) fwrites V
  hostcmd jpath '~Vega/base/copyshow.sh'
end.

def=. ViewHdr,txt,ScriptFini,ViewFini
view def
)
sizechart=: ''
view=: 3 : 0
dat=. y
p=. jpath '~addons/graphics/view/'
dat fwrites p,'view.html'

Hwndp=: $0

if. 0=#Hwndp do.
  wd 'pc view escclose'
  wd 'pn View'
  if. #defpos do. wd 'pmove ',":defpos end.
  wd 'cc w webview flush'
  wd 'set w baseurl *',p
  wd 'pshow hide'
  Hwndp=: wd 'qhwndp'
else.
  if. #viewsize do.
    wd 'pmove ',":fitpos viewsize
  end.
  wd 'psel ',Hwndp
end.
wd 'set w html *',dat
)
view_debug=: 3 : 0

dat=. y
mkdir_j_ p=. '/tmp/view'
D=: }: hostcmd 'mktemp -d -p ',p
P=: jpath '~addons/graphics/view'
hostcmd 'cp -R ',P,'/* ',D
dat fwrites D,'/view.html'
(freads '~temp/test.html') fwrites D,'/test.html'

Hwndp=: $0
wd 'pc view escclose'
wd 'pn View'
if. #defpos do. wd 'pmove ',":defpos end.
wd 'cc w webview flush'
wd 'set w baseurl "',D,'/"'
wd 'pshow hide'
Hwndp=: wd 'qhwndp'
wd 'set w html *',dat
)
view_w_char=: 3 : 0
echo 'char: ' , sysdata
if. 16b00f800 = 3 u: ucp sysdata do.
  view_close''
end.
EMPTY
)
view_close=: 3 : 0
wd 'pclose'
if. (coname'') e. conl 1 do. destroy'' end.
)
view_w_post=: 3 : 0
select. w_name
case. 'init' do.
  wd 'pshow'
case. 'size' do.
  wd 'pmove ',":pos_topleft dec_pjson_ w_value
  wd 'pshow'
case. 'export' do.
  'f v'=. dec_pjson_ w_value
  (frombase64 v) fwritenew f
  sminfo 'View written to file: ',f
case. do.
  echo 'post ', w_name,' ',w_value
end.
)

Bar=: 0 : 0
plotdefs={
 "height": "container",
 "width": "container",
 "autosize": { "type": "fit", "contains": "padding" },
 "data": { "values": flatten(names, values) },
 "transform": [
  {
   "fold": fold
  }
 ],
 "title": title,
 "mark": { "type": "bar", "strokeWidth": linewidth },
 "encoding": {
  "x": {
   "field": names[0],
   "title": xcaption,
   "type": "ordinal",
   "axis": { "labelAngle": labelangle }
  },
  "y": {
   "field": "value",
   "title": ycaption,
   "type": "quantitative",
   "axis": { "tickCount": 7, "tickMinStep": 1 }
  },
  "color": { "field": "key", "type": "nominal", "legend": {} }
 }
}
)
Facet=: 0 : 0
plotdefs={
 "data": { "values": flatten(names, values) },
 "mark": mark,
 "width": shapes.width,
 "height": shapes.height,
 "encoding": {
  "facet": { "field": facetname, "type": "ordinal", "columns": shapes.cls },
  "x": { "field": xname, "type": "quantitative" },
  "y": { "field": yname, "type": "quantitative" }
 }
}
)
Facet1=: 0 : 0
plotdefs={
 "data": { "values": flatten(names, values) },
 "facet": {
  "row": { "field": facetname, "type": "nominal" }
 },
 "spec": {
  "mark": mark,
  "width": shapes.width,
  "height": shapes.height,
  "encoding": {
   "x": {
    "bin": { "maxbins": 15 },
    "field": xname,
    "type": "quantitative"
   },
   "y": { "aggregate": "count", "type": "quantitative" }
  }
 }
}
)
Line=: 0 : 0
plotdefs={
 "height": "container",
 "width": "container",
 "autosize": { "type": "fit", "contains": "padding" },
 "data": { "values": flatten(names, values) },
 "transform": [
  {
   "fold": fold
  }
 ],
 "title": title,
 "mark": { "type": "line", "strokeWidth": linewidth },
 "encoding": {
  "x": {
   "field": names[0],
   "title": xcaption,
   "type": "quantitative",
   "axis": { "tickCount": 8, "tickMinStep": 1 }
  },
  "y": {
   "field": "value",
   "title": ycaption,
   "type": "quantitative",
   "axis": { "tickCount": 7, "tickMinStep": 1 }
  },
  "color": { "field": "key", "type": "nominal", "legend": legend }
 }
}
)
Repeat=: 0 : 0
plotdefs={
 "data": { "values": flatten(names, values) },
 "repeat": {
  "row": ynames,
  "column": xnames
 },
 "spec": {
  "width": shapes.width,
  "height": shapes.height,
  "mark": "point",
  "encoding": {
   "x": {
    "field": { "repeat": "column" },
    "type": "quantitative",
    "scale": { "zero": false }
   },
   "y": {
    "field": { "repeat": "row" },
    "type": "quantitative",
    "scale": { "zero": false }
   },
   "color": { "field": key, "type": "nominal" }
  }
 }
}
)
cocurrent 'pjson'
fmtnum=: ,@('d<null>'&(8!:2))
fmtnums=: ' ' -.~ }.@,@(',' ,. >@{.@('d<null>'&(8!:1))@,.)
fmtint=: ,@('d<null>0'&(8!:2))
fmtints=: ' ' -.~ }.@,@(',' ,. >@{.@('d<null>0'&(8!:1))@,.)

sep=: }.@;@:(','&,each)
bc=: '{' , '}' ,~ ]
bk=: '[' , ']' ,~ ]

fixchar=: ]

ESC=: _2[\('\';'\\';CR;'\r';LF;'\n';TAB;'\t';(8{a.);'\b';FF;'\f';'"';'\"';'/';'\/')
decesc=: rplc&(1|."1 ESC)
encesc=: rplc&ESC
remq=: ]`(}.@}:)@.('"' = {.)
isboxed=: 0 < L.
ischar=: 2=3!:0
isfloat=: 8=3!:0
isscalar=: 0 = #@$
quotes=: '"'&,@(,&'"')

false=: 0
true=: 1
NULL=: 0
cutcommas=: 3 : 0
y=. ',',y
m=. ~:/\y='"'
m=. *./ (m < y=','), 0 = _2 +/\ @ (-/)\ m <"1 '{}[]'=/y
m <@dltb;._1 y
)
dec=: 3 : 0
dec1 dltb ' ' (y I.@:e. TAB,CRLF)} y
)
dec1=: 3 : 0
if. 0=#y do. '' return. end.
if. y-:'null' do. NULL return. end.
select. {. y
case. '{' do. dec_object y
case. '[' do. dec_array y
case. '"' do. decesc }.}:y
case. do. dec_num y
end.
)
dec_array=: 3 : 0
y=. dltb }.}:y
if. 0=#y do. $0 return. end.
if. -. y +./@:e. '"{[' do. ,dec_num y return. end.
dec1 each cutcommas y
)
dec_num=: 3 : 0
nms=. ;: 'false true null'
res=. 0 ". ' ' (I.y=',')} y
if. -. 1 e. ,nms E.&> <y do. return. end.
nos=. <;._1 ',',y -. ' '
'f t n'=. nos&(I.@:= <) each nms
res=. true t} false f} res
if. #n do. ({.NULL) n} res end.
)
dec_object=: 3 : 0
y=. }.}:y
if. 0=#y do. '' return. end.
dec_object1 &> a: -.~ cutcommas y
)
dec_object1=: 3 : 0
n=. 1 i.~ (y=':') > ~:/\y='"'
k=. remq dltb n {. y
v=. dec1 dltb (n+1) }. y
k;<v
)
enc=: 3 : 0
if. 1<#$y do.
  if. isboxed y do.
    enc_dict y
  else.
    bk sep <@enc"_1 y
  end.
elseif. isboxed y do.
  bk sep enc each y
elseif. ischar y do.
  enc_char y
elseif. isfloat y do.
  enc_num y
elseif. do.
  enc_int y
end.
)
enc_char=: quotes @ encesc @ fixchar
enc_num=: bk @ fmtnums`fmtnum @. isscalar
enc_int=: bk @ fmtints`fmtint @. isscalar
enc_dict=: 3 : 0
'rank>2 argument not supported' assert 2 = #$y
'rank 2 argument must be a dictionary' assert (2 = {:$y) > 0 e. ischar &> {."1 y
key=. '"' ,each ({."1 y) ,each <'":'
val=. enc each {:"1 y
rep=. ;key,.val ,each <',',LF
bc LF,(_2}.rep),LF
)
finalize_pjson_^:(3=(4!:0)@<) 'finalize_pjson_'
cocurrent 'base'
