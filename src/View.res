let eye: Geometry.point = {x: 5.0, y: 5.0, z: 0.0}
let spheres: array<Geometry.sphere> = [
  {color: (255, 0, 0), center: {x: 5.0, y: 5.0, z: -20.0}, radius: 5.0},
  {color: (0, 255, 0), center: {x: 13.0, y: 2.0, z: -19.0}, radius: 2.0},
]
let planes: array<Geometry.plane> = [
  {
    color: (0, 0, 255),
    center: {x: 0.0, y: 0.0, z: 0.0},
    normal: {dx: 0.0, dy: 1.0, dz: 0.0},
  },
]

let scene: Geometry.scene = {spheres, triangles: [], planes}

let win: Geometry.window = {
  normal: {
    origin: {x: 5.2, y: 4.5, z: -5.0},
    vector: {dx: 0.0, dy: 0.0, dz: -1.0},
  },
  up: {dx: 0.0, dy: 1.0, dz: 0.0},
  width: 4.0,
  height: 2.5,
  pxWidth: 400,
  pxHeight: 250,
}

let white: Geometry.rgb = (255, 255, 255)
let enamel: Geometry.rgb = (238, 238, 238)
let dark: Geometry.rgb = (68, 68, 68)
