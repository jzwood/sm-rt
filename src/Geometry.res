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

let minus = (p1: point, p2: point) : vector
  => { dx: p1.x -. p2.x
     , dy: p1.y -. p2.y
     , dz: p1.z -. p2.z
     }

let add = (v1: vector, v2: vector) : vector
  => { dx: v1.dx +. v2.dx
     , dy: v1.dy +. v2.dy
     , dz: v1.dz +. v2.dz
     }

let dot = (v1: vector, v2: vector) : float
  => (v1.dx *. v2.dx) +. (v1.dy *. v2.dy) +. (v1.dz *. v2.dz)

let cross = (v1: vector, v2: vector) : vector
  => { dx: (v1.dy *. v2.dz) -. (v1.dz *. v2.dy)
     , dy: (v1.dz *. v2.dx) -. (v1.dx *. v2.dz)
     , dz: (v1.dx *. v2.dy) -. (v1.dy *. v2.dx)
     }

let scale = (f: float, v: vector) : vector
  => { dx: f *. v.dx
     , dy: f *. v.dy
     , dz: f *. v.dz
     }

let plus = (p: point, v: vector) : point
  => { x: p.x +. v.dx
     , y: p.y +. v.dy
     , z: p.z +. v.dz
     }

let magnitude = (v: vector) : float
  => Math.sqrt (sq(v.dx) +. sq(v.dy) +. sq(v.dz))


let negate = ({dx, dy, dz}: vector) : vector
  => { dx: -1.0 *. dx
     , dy: -1.0 *. dy
     , dz: -1.0 *. dz
     }

let normalize = (v: vector) : vector
  => scale(1.0 /. magnitude(v), v)

let angle = (v1: vector, v2: vector) : float
  => Math.acos(dot(v1, v2) /. (magnitude(v1) *. magnitude(v2)))
