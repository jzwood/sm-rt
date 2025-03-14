type ray = Geometry.ray
type lightSource = Geometry.point
type eye = Geometry.point

type window = {
  wNormal: Geometry.ray,
  up: Geometry.vector,
  width: float,
  height: float,
  pxWidth: int,
  pxHeigh: int,
}

let pixelToOrigin = (
  {wNormal: {point: origin, vector: normal}, up, width, height, pxWidth, pxHeigh}: window,
): Geometry.point => {
  let left = Geometry.cross(up, normal)->Geometry.normalize
  //let right = Geometry.negate(left)
  let nUp = Geometry.normalize(up)
  //let down = Geometry.negate(nUp)
  let topLeft =
    Geometry.plus(origin, Geometry.scale(0.5 *. width, left))->Geometry.plus(
      Geometry.scale(0.5 *. height, nUp),
    )
  topLeft
}
