let eye: Geometry.point = {x: 0.0, y: 25.0, z: 0.0}
let centerSphere: Geometry.sphere = {
  color: (255, 0, 0),
  center: {x: 0.0, y: 0.0, z: 0.0},
  radius: 2.0,
}
let red: Geometry.rgb = (255, 0, 0)
let green: Geometry.rgb = (0, 255, 0)
let blue: Geometry.rgb = (0, 0, 255)
let yellow: Geometry.rgb = (255, 255, 0)
let cyan: Geometry.rgb = (0, 255, 255)
let fuchsia: Geometry.rgb = (255, 0, 255)
let colors: array<Geometry.rgb> = [
    (255, 0, 0),
    (0, 255, 0),
    (0, 0, 255),
    (255, 255, 0),
    (0, 255, 255),
    (255, 0, 255),
    (100, 0, 0),
    (0, 100, 0),
    (0, 0, 100),
    (100, 100, 0),
    (0, 100, 100),
    (100, 0, 100),
  ]->Array.toShuffled
let spheres: array<Geometry.sphere> =
  Belt.Array.zip(colors, Polar.neighbors(centerSphere))
  ->Array.map(((color, {center, radius})) => {
    let sphere: Geometry.sphere = {center, radius, color}
    sphere
  })
  ->(spheres => [centerSphere, ...spheres])

let planes: array<Geometry.plane> = [
  //{
  //color: (0, 0, 255),
  //center: {x: 0.0, y: -5.0, z: 0.0},
  //normal: {dx: 0.0, dy: 1.0, dz: 0.0},
  //},
]

let scene: Geometry.scene = {spheres, triangles: [], planes}

let win: Geometry.window = {
  normal: {
    origin: {x: 0.0, y: 15.0, z: 0.0},
    vector: {dx: 0.0, dy: -1.0, dz: 0.0},
  },
  up: {dx: 1.0, dy: 0.0, dz: 0.0},
  width: 8.0,
  height: 5.0,
  pxWidth: 400,
  pxHeight: 250,
}

let white: Geometry.rgb = (255, 255, 255)
let enamel: Geometry.rgb = (238, 238, 238)
let dark: Geometry.rgb = (68, 68, 68)
