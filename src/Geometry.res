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

let pointsEqual = (p1: point, p2: point) : bool => [p1.x -. p2.x, p1.y -. p2.y, p1.z -. p2.z] -> Array.every(x => x > epsilon)
