// utilx

var AA, BB;
const O = console.log;
const S = JSON.stringify;

// ---------------------------------------------------------------------
function exporter(arg) {
 let file = arg[0];
 let ndx = file.lastIndexOf(".");
 let ext = file.slice(ndx + 1);
 jpost("info", "export " + file + " " + ndx + " " + ext);
 if (ext === "svg") Vega.toSVG().then(e => exporter1(file, btoa(e)));
 else
  Vega.toImageURL("png").then(e =>
   exporter1(file, e.slice(1 + e.indexOf(",")))
  );
}

// ---------------------------------------------------------------------
function exporter1(file, image) {
 jpost("export", S([file, image]));
}

// ---------------------------------------------------------------------
function flatten(keys, vals) {
 let res = [];
 let cls = vals[0].length;
 let rws = keys.length;
 for (let i = 0; i < cls; i++) {
  let s = {};
  for (let j = 0; j < rws; j++) s[keys[j]] = vals[j][i];
  res.push(s);
 }
 return res;
}

// ---------------------------------------------------------------------
function getid(e) {
 return document.getElementById(e);
}

// ---------------------------------------------------------------------
function getrect(e) {
 if ("string" === typeof e) return getid(e).getBoundingClientRect();
 else return e.getBoundingClientRect();
}

// ---------------------------------------------------------------------
function getviewbox() {
 return getid("draw")
  .children[0].getAttribute("viewBox")
  .split(" ")
  .map(Number);
}

// ---------------------------------------------------------------------
function getwindow() {
 return [window.innerWidth, window.innerHeight];
}

// ---------------------------------------------------------------------
var same = e => e;
// defs

"use strict";

var basedefs, litedefs, vegadefs, plotdefs;

var autosize = null;
var data = null;
var defs = null;
var facetname = null;
var facetcols = 0;
var fold = null;
var height = null;
var key = null;
var labelangle = 0;
var legend = null;
var linewidth = 2;
var names = null;
var shapes = null;
var sizing = null;
var title = null;
var values = null;
var width = null;
var xcaption = null;
var xname = null;
var xnames = null;
var ycaption = null;
var yname = null;
var ynames = null;

// ---------------------------------------------------------------------
basedefs = {
 background: "#f8f8f8",
 padding: 15,
 config: {
  legend: {
   rowPadding: 0,
   symbolStrokeWidth: 12,
   title: ""
  },
  style: {
   "group-title": {
    fontSize: 14,
    fontWeight: "normal"
   },
   "guide-label": {
    fontSize: 12
   },
   "guide-title": {
    fontSize: 13,
    fontWeight: "normal"
   },
   // this not working...
   label: {
    dx: 10,
    dy: 15
   }
  }
 },
 view: {
  fill: "#ffe",
  opacity: 100
 }
};

// ---------------------------------------------------------------------
litedefs = {};
vegadefs = {};
// jfns - handle J communication

"use strict";

// ---------------------------------------------------------------------
function jcall(s) {
 jcall_do(s, false);
}

// ---------------------------------------------------------------------
function jcallr(s) {
 jcall_do(s, true);
}

// ---------------------------------------------------------------------
function jcall_do(s, ret) {
 var f = s.shift();
 if (window[f] === undefined) return jerror("function not found: " + f);
 var r;
 try {
  r = window[f](s);
  if (ret) jreturn(S(r));
 } catch (error) {
  jerror("call error: " + error);
 }
}

// ---------------------------------------------------------------------
function jerror(msg) {
 jpost("error", msg);
}

// ---------------------------------------------------------------------
function jeval(s) {
 var r;
 try {
  r = eval(s[0]);
  return jreturn(S(r));
 } catch (error) {
  return jerror("eval error: " + error);
 }
}

// ---------------------------------------------------------------------
function jget(s) {
 if (window[s] === undefined) return jerror("name not found: " + s);
 return jreturn(S(window[s]));
}

// ---------------------------------------------------------------------
function jgetrect() {
 return jreturn(S(getrect("draw")));
}

// ---------------------------------------------------------------------
function jgetviewbox() {
 return jreturn(S(getviewbox()));
}

// ---------------------------------------------------------------------
function jgetwindow() {
 return jreturn(S(getwindow()));
}

// ---------------------------------------------------------------------
function jnotify(s) {
 var f = "j" + s.shift();
 if (window[f] === undefined) return jerror("function not found: " + f);
 window[f](s);
}

// ---------------------------------------------------------------------
function jpost(name, val) {
 qcom.qPost(["post", name, val]);
}

// ---------------------------------------------------------------------
function jreturn(msg) {
 jpost("return", msg);
}

// ---------------------------------------------------------------------
function jset(name, val) {
 window[name] = JSON.parse(val);
}
// size

"use strict";

// ---------------------------------------------------------------------
function sizeinit() {
 let vbox = getviewbox().slice(2);
 jpost("size", S(vbox));
 Size.rat = shapes.width / shapes.height;
 Size.vw = vbox[0];
 Size.vh = vbox[1];
}

// ---------------------------------------------------------------------
function resizechart() {
 let [pw, ph] = getwindow();
 let { rws, cls, width, height } = shapes;
 let { vw, vh, rat } = Size;
 let nw = width + (pw - vw) / cls;
 let nh = height + (ph - vh) / rws;
 nw = Math.min(nw, nh * rat);
 nh = nw / rat;
 nw = Math.floor(Math.max(nw, 0));
 nh = Math.floor(Math.max(nh, 0));
 if (sizing === "facet") {
  cmp.signals[0].value = nw;
  cmp.signals[1].value = nh;
 } else {
  cmp.width = nw;
  cmp.height = nh;
 }
 //let def = [pw, ph, width, height, nw, nh];
 //O("def", S(def));
 //jpost("info size", S(Size));
 //jpost("info chartresize", S(Size));
 //jpost("info", S(def));
 drawchart1();
}
// start

"use strict";

var Init = false;
var Size = {};
var Vega;

var cmp, par, opt;
var qcom;
var resizeTimer;

// ---------------------------------------------------------------------
function drawchart() {
 if ("vega" === plotdefs.usermeta)
  cmp = Object.assign({}, basedefs, vegadefs, plotdefs);
 else {
  defs = Object.assign({}, basedefs, litedefs, plotdefs);
  cmp = vegaLite.compile(defs).spec;
 }
 drawchart1();
}

// ---------------------------------------------------------------------
function drawchart1() {
 par = vega.parse(cmp);
 opt = { renderer: "svg", container: "#draw", hover: true };
 Vega = new vega.View(par, opt);
 Vega.runAsync().then(chartdrawn);
}

// ---------------------------------------------------------------------
function chartdrawn() {
 if (!sizing) return postinit();
 if (!Size.vw) return sizeinit();
 //let wh = getwindow();
 //let vb = getviewbox().slice(2);
 //let cp = [cmp.width, cmp.height];
 //jpost("chartdraw", S(wh.concat(vb, cp)));
}

// ---------------------------------------------------------------------
function postinit() {
 if (Init) return;
 jpost("init", "");
 Init = true;
}

// ---------------------------------------------------------------------
function refresh() {
 window.dispatchEvent(new Event("resize"));
}

// ---------------------------------------------------------------------
function resize() {
 //jpost("info", "resize called");
 clearTimeout(resizeTimer);
 resizeTimer = setTimeout(resizechart, 100);
}

// ---------------------------------------------------------------------
function sizechart() {
 //jpost("info", "sizechart");
 window.onresize = sizing ? resize : null;
}

// ---------------------------------------------------------------------
window.onload = drawchart;
window.onresize = sizechart;
