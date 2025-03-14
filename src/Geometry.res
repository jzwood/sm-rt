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
  point: point,
  vector: vector,
}

type sphere = {
  center: point,
  radius: float,
}

type plane = {
  center: point,
  point: point,
  normal: vector,
}

type triangle = {
  p1: point,
  p2: point,
  p3: point,
}

type lightSource = point
type eye = point

type window = {
  wNormal: ray,
  up: vector,
  width: float,
  height: float,
  pxWidth: float,
  pxHeight: float,
}

let e = 2.71828 // euler's number
let epsilon = 0.0001

let pointEq = (p1: point, p2: point): bool =>
  [p1.x -. p2.x, p1.y -. p2.y, p1.z -. p2.z]->Array.every(x => Math.abs(x) < epsilon)

let vectorEq = (v1: vector, v2: vector): bool =>
  [v1.dx -. v2.dx, v1.dy -. v2.dy, v1.dz -. v2.dz]->Array.every(x => Math.abs(x) < epsilon)

let sq = (x: float): float => x *. x

let magnitude = (v: vector): float => Math.sqrt(sq(v.dx) +. sq(v.dy) +. sq(v.dz))

let vectorGt = (v1: vector, v2: vector): bool => magnitude(v1) > magnitude(v2)

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

let normalize = (v: vector): vector => scale(1.0 /. magnitude(v), v)

let angle = (v1: vector, v2: vector): float =>
  Math.acos(dot(v1, v2) /. (magnitude(v1) *. magnitude(v2)))

let getNormalSphere = (p: point, {center}: sphere): vector => normalize(minus(p, center))

let getPlaneNormal = ({normal}: plane): vector => normal

let raySphereIntersection = (r: ray, s: sphere): option<(point, sphere)> => {
  let nd = normalize(r.vector)
  let l = minus(s.center, r.point)
  let ml = magnitude(l)
  let tb = dot(nd, l)
  let b = plus(r.point, scale(tb, nd))
  let deltaSq = sq(s.radius) -. sq(ml) +. sq(tb)
  let x = plus(r.point, scale(tb -. Math.sqrt(deltaSq), nd))

  if deltaSq < 0.0 {
    // no intersection
    None
  } else if deltaSq == 0.0 {
    // 1 intersection
    Some((b, s))
  } else if ml < s.radius {
    // ray is inside sphere
    None
  } else if normalize(minus(x, r.point)) != nd {
    // ray points in wrong direction
    None
  } else {
    Some(x, s)
  }
}

let rayPlaneIntersection = (r: ray, p: plane): option<point> => {
  let nn = normalize(p.normal)
  let nd = normalize(r.vector)
  let tnum = minus(p.center, r.point)->dot(nn)
  let tden = dot(nd, nn)
  let t = tnum /. tden
  let p = plus(r.point, scale(t, nd))
  if tnum == 0.0 || tden == 0.0 || t < 0.0 {
    None
  } else {
    Some(p)
  }
}

let pixelToOrigin = (
  {wNormal: {point: origin, vector: normal}, up, width, height}: window,
): point => {
  let left = cross(up, normal)->normalize
  let nUp = normalize(up)
  // top left
  plusAll(origin, [scale(0.5 *. width, left), scale(0.5 *. height, nUp)])
}

let pixelToRay = (x: float, y: float, eye: point, w: window): ray => {
  let topLeft = pixelToOrigin(w)
  let right = cross(w.up, w.wNormal.vector)->normalize->negate
  let down = w.up->negate->normalize
  let point = plusAll(
    topLeft,
    [
      scale(x /. (w.pxWidth -. 1.0) *. w.width, right),
      scale(y /. (w.pxHeight -. 1.0) *. w.height, down),
    ],
  )
  {
    point,
    vector: minus(point, eye)->normalize,
  }
}
