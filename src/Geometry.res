type point = {
  x: float,
  y: float,
  z: float
}

type vector = {
  dx: float,
  dy: float,
  dz: float
}

type ray = {
  point: point,
  vector: vector
}

type sphere = {
  center: point,
  radius: float
}

type plane = {
  center: point,
  point: point,
  normal: vector
}

type triangle = {
  p1: point,
  p2: point,
  p3: point
}

let e = 2.71828  // euler's number
let epsilon = 0.0001

let pointEq = (p1: point, p2: point) : bool
  => [ p1.x -. p2.x
     , p1.y -. p2.y
     , p1.z -. p2.z
     ] -> Array.every(x => Math.abs(x) < epsilon)

let vectorEq = (v1: vector, v2: vector) : bool
  => [ v1.dx -. v2.dx
     , v1.dy -. v2.dy
     , v1.dz -. v2.dz
     ] -> Array.every(x => Math.abs(x) < epsilon)

let sq = (x: float) : float => x *. x

let magnitude = (v: vector) : float
  => Math.sqrt (sq(v.dx) +. sq(v.dy) +. sq(v.dz))

let minus = (p1: point, p2: point) : vector
  => { dx: p1.x -. p2.x
     , dy: p1.y -. p2.y
     , dz: p1.z -. p2.z
     }
