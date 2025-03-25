/*
 * MATH FROM:
 * https://slides.com/sergejkosov/ray-geometry-intersection-algorithms/fullscreen
 */

type point = {
  x: float,
  y: float,
  z: float,
}

type vector = {
  dx: float,
  dy: float,
  dz: float,
}

type ray = {
  origin: point,
  vector: vector,
}

type rgb = (int, int, int)
let black: rgb = (0, 0, 0)
let white: rgb = (255, 255, 255)

type sphere = {
  color: rgb,
  center: point,
  radius: float,
}

type plane = {
  color: rgb,
  center: point,
  normal: vector,
}

type triangle = {
  color: rgb,
  p1: point,
  p2: point,
  p3: point,
}

type scene = {
  spheres: array<sphere>,
  triangles: array<triangle>,
  planes: array<plane>,
}

type window = {
  normal: ray,
  up: vector,
  width: float,
  height: float,
  pxWidth: float,
  pxHeight: float,
}

let windowTest: window = {
  normal: {
    origin: {x: 5.2, y: 4.5, z: -5.0},
    vector: {dx: 0.0, dy: 0.0, dz: -1.0},
  },
  up: {dx: 0.0, dy: 1.0, dz: 0.0},
  width: 4.0,
  height: 2.5,
  pxWidth: 8.0,
  pxHeight: 5.0,
}

let e = 2.71828 // euler's number
let epsilon = 0.0001

//let pointEq = (p1: point, p2: point): bool =>
//[p1.x -. p2.x, p1.y -. p2.y, p1.z -. p2.z]->Array.every(x => Math.abs(x) < epsilon)

let vectorEq = (v1: vector, v2: vector): bool =>
  [v1.dx -. v2.dx, v1.dy -. v2.dy, v1.dz -. v2.dz]->Array.every(x => Math.abs(x) < epsilon)

//let vectorNeq = (v1: vector, v2: vector) : bool => !vectorEq(v1, v2)

let sq = (x: float): float => x *. x

let minus = (p1: point, p2: point): vector => {
  dx: p1.x -. p2.x,
  dy: p1.y -. p2.y,
  dz: p1.z -. p2.z,
}

let add = (v1: vector, v2: vector): vector => {
  dx: v1.dx +. v2.dx,
  dy: v1.dy +. v2.dy,
  dz: v1.dz +. v2.dz,
}

let dot = (v1: vector, v2: vector): float => v1.dx *. v2.dx +. v1.dy *. v2.dy +. v1.dz *. v2.dz

let cross = (v1: vector, v2: vector): vector => {
  dx: v1.dy *. v2.dz -. v1.dz *. v2.dy,
  dy: v1.dz *. v2.dx -. v1.dx *. v2.dz,
  dz: v1.dx *. v2.dy -. v1.dy *. v2.dx,
}

let scale = (f: float, v: vector): vector => {
  dx: f *. v.dx,
  dy: f *. v.dy,
  dz: f *. v.dz,
}

let plus = (p: point, v: vector): point => {
  x: p.x +. v.dx,
  y: p.y +. v.dy,
  z: p.z +. v.dz,
}

let plusAll = (point: point, vectors: array<vector>): point => Array.reduce(vectors, point, plus)

let negate = ({dx, dy, dz}: vector): vector => {
  dx: -1.0 *. dx,
  dy: -1.0 *. dy,
  dz: -1.0 *. dz,
}

let magnitude = (v: vector): float => Math.sqrt(dot(v, v))
let ord = (v: vector): float => dot(v, v)
let vectorGt = (v1: vector, v2: vector): bool => ord(v1) > ord(v2)

let normalize = (v: vector): vector => scale(1.0 /. magnitude(v), v)

let angle = (v1: vector, v2: vector): float =>
  Math.acos(dot(v1, v2) /. (magnitude(v1) *. magnitude(v2)))

let getNormalSphere = (p: point, {center}: sphere): vector => normalize(minus(p, center))

let getPlaneNormal = ({normal}: plane): vector => normal

let raySphereIntersection = (r: ray, s: sphere): option<(float, rgb)> => {
  let nd: vector = normalize(r.vector)
  let l: vector = minus(s.center, r.origin)
  let ml: float = magnitude(l)
  let tb: float = dot(nd, l)
  let b: point = plus(r.origin, scale(tb, nd))
  let deltaSq: float = sq(s.radius) -. sq(ml) +. sq(tb)
  let x: point = plus(r.origin, scale(tb -. Math.sqrt(deltaSq), nd))

  if deltaSq < 0.0 {
    // no intersection
    None
  } else if deltaSq == 0.0 {
    // 1 intersection
    let d = minus(r.origin, b)->ord
    Some(d, s.color)
  } else if ml < s.radius {
    // ray is inside sphere
    None
  } else if !vectorEq(normalize(minus(x, r.origin)), nd) {
    // ray points in wrong direction
    None
  } else {
    let d = minus(r.origin, x)->ord
    Some(d, s.color)
  }
}

let rayPlaneIntersection = (r: ray, p: plane): option<(float, rgb)> => {
  let nn: vector = normalize(p.normal)
  let nd: vector = normalize(r.vector)
  let tnum: float = minus(p.center, r.origin)->dot(nn)
  let tden: float = dot(nd, nn)
  let t: float = tnum /. tden
  if tnum == 0.0 || tden == 0.0 || t < 0.0 {
    None
  } else {
    let i: point = plus(r.origin, scale(t, nd))
    let d: float = minus(r.origin, i)->ord
    Some(d, p.color)
  }
}

let rayTriangleIntersection = (r: ray, {p1, p2, p3, color}: triangle): option<(float, rgb)> => {
  let e1 = minus(p2, p1)
  let e2 = minus(p3, p1)
  let d = r.vector
  let pv = cross(d, e2)
  let tv = minus(r.origin, p1)
  let qv = cross(tv, e1)
  let det = dot(pv, e1)
  let inv_det = 1.0 /. det
  let u = inv_det *. dot(pv, tv)
  let v = inv_det *. dot(qv, d)
  let t = inv_det *. dot(qv, e2)
  if Math.abs(det) < epsilon {
    None
  } else if u < 0.0 || u > 1.0 {
    None
  } else if v < 0.0 || u > 1.0 {
    None
  } else {
    Some(t, color)
  }
}

let windowToOrigin = ({normal: {origin, vector: normal}, up, width, height}: window): point => {
  let left = cross(up, normal)->normalize
  let up = normalize(up)
  // top left
  plusAll(origin, [scale(0.5 *. width, left), scale(0.5 *. height, up)])
}

let pixelToRay = (x: float, y: float, eye: point, w: window): ray => {
  let topLeft = windowToOrigin(w)
  let right = cross(w.up, w.normal.vector)->normalize->negate
  let down = w.up->normalize->negate
  let point = plusAll(
    topLeft,
    [
      scale(x /. (w.pxWidth -. 1.0) *. w.width, right),
      scale(y /. (w.pxHeight -. 1.0) *. w.height, down),
    ],
  )

  {
    origin: point,
    vector: minus(point, eye)->normalize,
  }
}

let scaleRGB = (percent: float, (r, g, b)): rgb => {
  let f = (color: int): int =>
    (percent *. Float.fromInt(color))
    ->Math.round
    ->Int.fromFloat
  (f(r), f(g), f(b))
}

let snap = (digits: float, {x, y, z}: point): point => {
  let t = Math.pow(10.0, ~exp=digits)
  let prec = (n: float) => Math.round(n *. t) /. t
  {x: prec(x), y: prec(y), z: prec(z)}
}

let rayToColor = (sight: ray, {spheres, planes}: scene): rgb => {
  [
    ...Array.map(spheres, raySphereIntersection(sight, ...)),
    ...Array.map(planes, rayPlaneIntersection(sight, ...)),
  ]
  ->Array.keepSome
  ->Utils.smallest(((dist, _)) => dist)
  ->Option.map(((_, color)) => color)
  ->Option.getOr(black)
}

// rename to getPixel
let renderScene = (eye: point, scene: scene, window: window, x: float, y: float): rgb => {
  pixelToRay(x, y, eye, window)->rayToColor(scene)
}
