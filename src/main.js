import { renderScene } from "./Geometry.res.js";

console.log("hi mom");

const eye = [5, 5, 0];
const spheres = [
  { color: [100, 300, 0], center: { x: 5, y: 5, z: -20 }, radius: 5 },
  { color: [230, 0, 100], center: { x: 6, y: 5, z: -5 }, radius: 5 },
  { color: [0, 0, 200], center: { x: 13, y: 2, z: -19 }, radius: 2 },
];
const planes = [{
  color: [0, 255, 0],
  center: { x: 0, y: 0, z: 0 },
  point: { x: 1, y: 0, z: 0 },
  normal: { dx: 0, dy: 1, dz: 0 },
}];

const scene = { spheres, triangles: [], planes };

const w = {
  wNormal: { point: { x: 5.2, y: 4.5, z: -5 }, vector: { x: 0, y: 0, z: -1 } },
  up: { dx: 0, dy: 1, dz: 0 },
  width: 4,
  height: 2.5,
  pxWidth: 400,
  pxHeight: 250,
};

const res = renderScene(eye, scene, w, 100, 100);

console.log(res);
