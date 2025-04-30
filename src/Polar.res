type polar = {
  theta: float,
  phi: float,
  rho: float,
}

let toRad = (deg: float): float => deg *. Math.Constants.pi /. 180.0
let toDeg = (rad: float): float => rad *. 180.0 /. Math.Constants.pi

/*
 *           Y
 *           |
 *           .—— X
 *          /
 *         X
 */

let toCartesian = ({theta: tdeg, phi: pdeg, rho}: polar): Geometry.vector => {
  let theta = toRad(tdeg)
  let phi = toRad(pdeg)
  let x = rho *. Math.cos(phi) *. Math.sin(theta)
  let y = rho *. Math.sin(phi)
  let z = rho *. Math.cos(phi) *. Math.cos(theta)
  {
    dx: x,
    dy: y,
    dz: z,
  }
}

//let toSphere = (p: Geometry.point): Geometry.sphere => {center: p, radius: 10.0, color: (0, 0, 0)}

let tetra = toDeg(Math.atan(Math.sqrt(2.0)))
let neighbors = ({center, radius, color}: Geometry.sphere): array<Geometry.sphere> => {
  let rho = 2.0 *. radius
  [
    {rho, theta: 0.0, phi: 0.0},
    {rho, theta: 60.0, phi: 0.0},
    {rho, theta: 120.0, phi: 0.0},
    {rho, theta: 180.0, phi: 0.0},
    {rho, theta: 240.0, phi: 0.0},
    {rho, theta: 300.0, phi: 0.0},
    {rho, theta: 90.0, phi: tetra},
    {rho, theta: 210.0, phi: tetra},
    {rho, theta: 330.0, phi: tetra},
    {rho, theta: 90.0, phi: -1.0 *. tetra},
    {rho, theta: 210.0, phi: -1.0 *. tetra},
    {rho, theta: 330.0, phi: -1.0 *. tetra},
  ]
  ->Array.map(toCartesian)
  ->Array.map(Geometry.plus(center, ...))
  ->Array.map((point: Geometry.point): Geometry.sphere => {center: point, radius, color})
}
