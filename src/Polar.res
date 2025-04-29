type polar = {
  theta: float,
  phi: float,
  radius: float,
}

let toRad = (deg: float): float => deg *. Geometry.pi /. 180.0

let toCartesian = ({theta, phi, radius}: polar): Geometry.vector => {
  let t = toRad(theta)
  let p = toRad(phi)
  {
    dx: radius *. Math.sin(t) *. Math.cos(p),
    dy: radius *. Math.sin(t) *. Math.sin(p),
    dz: radius *. Math.cos(t),
  }
}

//let toSphere = (p: Geometry.point): Geometry.sphere => {center: p, radius: 10.0, color: (0, 0, 0)}

let neighbors = ({center, radius, color}: Geometry.sphere): array<Geometry.sphere> => {
  let diameter = 2.0 *. radius
  [
    {theta: 0.0, phi: 0.0, radius: diameter},
    {theta: 60.0, phi: 0.0, radius: diameter},
    {theta: 120.0, phi: 0.0, radius: diameter},
    {theta: 180.0, phi: 0.0, radius: diameter},
    {theta: 240.0, phi: 0.0, radius: diameter},
    {theta: 300.0, phi: 0.0, radius: diameter},
    {theta: 90.0 +. 0.0, phi: 60.0, radius: diameter},
    {theta: 90.0 +. 120.0, phi: 60.0, radius: diameter},
    {theta: 90.0 +. 240.0, phi: 60.0, radius: diameter},
    {theta: 90.0, phi: -60.0, radius: diameter},
    {theta: 90.0 +. 120.0, phi: -60.0, radius: diameter},
    {theta: 90.0 +. 240.0, phi: -60.0, radius: diameter},
  ]
  ->Array.map(toCartesian)
  ->Array.map(Geometry.plus(center, ...))
  ->Array.map((point: Geometry.point): Geometry.sphere => {center: point, radius, color})
}
