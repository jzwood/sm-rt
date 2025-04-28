//x = r * Math.sin(θ) * cos(φ)
//y = r * Math.sin(θ) * sin(φ)
//z = r*  Math.cos(θ)

//x = r * sin(polar) * cos(alpha)
//y = r * sin(polar) * sin(alpha)
//z = r * cos(polar)

type polar = {
  theta: float,
  phi: float,
  radius: float,
}

//let toPolar = ({x, y, z}: Geometry.point): bool => true

let toCartesian = ({theta, phi, radius}: polar): Geometry.vector => {
  dx: radius *. Math.sin(theta) *. Math.cos(phi),
  dy: radius *. Math.sin(theta) *. Math.sin(phi),
  dz: radius *. Math.cos(theta),
}

let neighbors = ({center, radius}: Geometry.sphere): array<Geometry.point> => {
  [
    {theta: 0.0, phi: 0.0, radius},
    {theta: 60.0, phi: 0.0, radius},
    {theta: 120.0, phi: 0.0, radius},
    {theta: 180.0, phi: 0.0, radius},
    {theta: 240.0, phi: 0.0, radius},
    {theta: 300.0, phi: 0.0, radius},
    {theta: 90.0 +. 0.0, phi: 60.0, radius},
    {theta: 90.0 +. 120.0, phi: 60.0, radius},
    {theta: 90.0 +. 240.0, phi: 60.0, radius},
    {theta: 90.0, phi: -60.0, radius},
    {theta: 90.0 +. 120.0, phi: -60.0, radius},
    {theta: 90.0 +. 240.0, phi: -60.0, radius},
  ]
  ->Array.map(toCartesian)
  ->Array.map(Geometry.plus(center, ...))
}
