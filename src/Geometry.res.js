// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Utils from "./Utils.res.js";
import * as Caml_obj from "rescript/lib/es6/caml_obj.js";
import * as Belt_Array from "rescript/lib/es6/belt_Array.js";
import * as Core__Array from "@rescript/core/src/Core__Array.res.js";
import * as Core__Option from "@rescript/core/src/Core__Option.res.js";

var black = [
  0,
  0,
  0
];

function sq(x) {
  return x * x;
}

function minus(p1, p2) {
  return {
          dx: p1.x - p2.x,
          dy: p1.y - p2.y,
          dz: p1.z - p2.z
        };
}

function add(v1, v2) {
  return {
          dx: v1.dx + v2.dx,
          dy: v1.dy + v2.dy,
          dz: v1.dz + v2.dz
        };
}

function dot(v1, v2) {
  return v1.dx * v2.dx + v1.dy * v2.dy + v1.dz * v2.dz;
}

function cross(v1, v2) {
  return {
          dx: v1.dy * v2.dz - v1.dz * v2.dy,
          dy: v1.dz * v2.dx - v1.dx * v2.dz,
          dz: v1.dx * v2.dy - v1.dy * v2.dx
        };
}

function scale(f, v) {
  return {
          dx: f * v.dx,
          dy: f * v.dy,
          dz: f * v.dz
        };
}

function plus(p, v) {
  return {
          x: p.x + v.dx,
          y: p.y + v.dy,
          z: p.z + v.dz
        };
}

function plusAll(point, vectors) {
  return Core__Array.reduce(vectors, point, plus);
}

function negate(param) {
  return {
          dx: -1.0 * param.dx,
          dy: -1.0 * param.dy,
          dz: -1.0 * param.dz
        };
}

function magnitude(v) {
  return Math.sqrt(dot(v, v));
}

function ord(v) {
  return dot(v, v);
}

function vectorGt(v1, v2) {
  return dot(v1, v1) > dot(v2, v2);
}

function normalize(v) {
  return scale(1.0 / magnitude(v), v);
}

function angle(v1, v2) {
  return Math.acos(dot(v1, v2) / (magnitude(v1) * magnitude(v2)));
}

function getNormalSphere(p, param) {
  return normalize(minus(p, param.center));
}

function getPlaneNormal(param) {
  return param.normal;
}

function raySphereIntersection(r, s) {
  var nd = normalize(r.vector);
  var l = minus(s.center, r.origin);
  var ml = magnitude(l);
  var tb = dot(nd, l);
  var b = plus(r.origin, scale(tb, nd));
  var x = s.radius;
  var deltaSq = x * x - ml * ml + tb * tb;
  var x$1 = plus(r.origin, scale(tb - Math.sqrt(deltaSq), nd));
  if (deltaSq < 0.0) {
    return ;
  }
  if (deltaSq === 0.0) {
    var v = minus(r.origin, b);
    var d = dot(v, v);
    return [
            d,
            s.color
          ];
  }
  if (ml < s.radius) {
    return ;
  }
  if (Caml_obj.notequal(normalize(minus(x$1, r.origin)), nd)) {
    return ;
  }
  var v$1 = minus(r.origin, x$1);
  var d$1 = dot(v$1, v$1);
  return [
          d$1,
          s.color
        ];
}

function rayPlaneIntersection(r, p) {
  var nn = normalize(p.normal);
  var nd = normalize(r.vector);
  var tnum = dot(minus(p.center, r.origin), nn);
  var tden = dot(nd, nn);
  var t = tnum / tden;
  if (tnum === 0.0 || tden === 0.0 || t < 0.0) {
    return ;
  }
  var i = plus(r.origin, scale(t, nd));
  var v = minus(r.origin, i);
  var d = dot(v, v);
  return [
          d,
          p.color
        ];
}

function rayTriangleIntersection(r, param) {
  var p1 = param.p1;
  var e1 = minus(param.p2, p1);
  var e2 = minus(param.p3, p1);
  var d = r.vector;
  var pv = cross(d, e2);
  var tv = minus(r.origin, p1);
  var qv = cross(tv, e1);
  var det = dot(pv, e1);
  var inv_det = 1.0 / det;
  var u = inv_det * dot(pv, tv);
  var v = inv_det * dot(qv, d);
  var t = inv_det * dot(qv, e2);
  if (Math.abs(det) < 0.0001 || u < 0.0 || u > 1.0 || v < 0.0 || u > 1.0) {
    return ;
  } else {
    return [
            t,
            param.color
          ];
  }
}

function windowToOrigin(param) {
  var up = param.up;
  var match = param.normal;
  var left = normalize(cross(up, match.vector));
  var up$1 = normalize(up);
  return plusAll(match.origin, [
              scale(0.5 * param.width, left),
              scale(0.5 * param.height, up$1)
            ]);
}

function pixelToRay(x, y, eye, w) {
  var topLeft = windowToOrigin(w);
  var right = negate(normalize(cross(w.up, w.normal.vector)));
  var down = negate(normalize(w.up));
  var point = plusAll(topLeft, [
        scale(x / (w.pxWidth - 1.0) * w.width, right),
        scale(y / (w.pxHeight - 1.0) * w.height, down)
      ]);
  console.log(point);
  console.log(eye);
  console.log(minus(point, eye));
  return {
          origin: point,
          vector: normalize(minus(point, eye))
        };
}

function scaleRGB(percent, param) {
  var f = function (color) {
    return Math.round(percent * color) | 0;
  };
  return [
          f(param[0]),
          f(param[1]),
          f(param[2])
        ];
}

function snap(digits, param) {
  var t = Math.pow(10.0, digits);
  var prec = function (n) {
    return Math.round(n * t) / t;
  };
  return {
          x: prec(param.x),
          y: prec(param.y),
          z: prec(param.z)
        };
}

function rayToColor(sight, param) {
  return Core__Option.getOr(Core__Option.map(Utils.smallest(Core__Array.keepSome(Belt_Array.concatMany([
                              param.spheres.map(function (extra) {
                                    return raySphereIntersection(sight, extra);
                                  }),
                              param.planes.map(function (extra) {
                                    return rayPlaneIntersection(sight, extra);
                                  })
                            ])), (function (param) {
                        return param[0];
                      })), (function (param) {
                    return param[1];
                  })), black);
}

function renderScene(eye, scene, $$window, x, y) {
  return rayToColor(pixelToRay(x, y, eye, $$window), scene);
}

var white = [
  255,
  255,
  255
];

var windowTest = {
  normal: {
    origin: {
      x: 5.2,
      y: 4.5,
      z: -5.0
    },
    vector: {
      dx: 0.0,
      dy: 0.0,
      dz: -1.0
    }
  },
  up: {
    dx: 0.0,
    dy: 1.0,
    dz: 0.0
  },
  width: 4.0,
  height: 2.5,
  pxWidth: 8.0,
  pxHeight: 5.0
};

var e = 2.71828;

var epsilon = 0.0001;

export {
  black ,
  white ,
  windowTest ,
  e ,
  epsilon ,
  sq ,
  minus ,
  add ,
  dot ,
  cross ,
  scale ,
  plus ,
  plusAll ,
  negate ,
  magnitude ,
  ord ,
  vectorGt ,
  normalize ,
  angle ,
  getNormalSphere ,
  getPlaneNormal ,
  raySphereIntersection ,
  rayPlaneIntersection ,
  rayTriangleIntersection ,
  windowToOrigin ,
  pixelToRay ,
  scaleRGB ,
  snap ,
  rayToColor ,
  renderScene ,
}
/* No side effect */
