import { getPixel, renderScene } from "./Geometry.res.js";

function main() {
  console.log("hi mom");

  const eye = {x: 5, y: 5, z:0};
  const spheres = [
    { color: [255, 0, 0], center: { x: 5, y: 5, z: -20 }, radius: 5 },
    { color: [0, 255, 0], center: { x: 13, y: 2, z: -19 }, radius: 2 },
  ];
  const planes = [{
    color: [0, 0, 255],
    center: { x: 0, y: 0, z: 0 },
    normal: { dx: 0, dy: 1, dz: 0 },
  }];

  const scene = { spheres, triangles: [], planes };

  const multiplier = 140
  const scale = 1

  const w = {
    normal: {
      origin: { x: 5.2, y: 4.5, z: -5 },
      vector: { dx: 0, dy: 0, dz: -1 },
    },
    up: { dx: 0, dy: 1, dz: 0 },
    width: 4,
    height: 2.5,
    pxWidth: 8 * multiplier,
    pxHeight: 5 * multiplier,
  };

  const width = w.pxWidth;
  const height = w.pxHeight;

  const res = getPixel(eye, scene, w, 100, 100);

  const canvas = document.getElementById("canvas");
  canvas.width = width;
  canvas.height = height;
  canvas.style.transform = `scale(${scale})`;

  const ctx = canvas.getContext("2d", { alpha: true });

  const imageData = ctx.createImageData(width, height);
  renderScene(imageData.data, scene, eye, w)
  ctx.putImageData(imageData, 0, 0);
}

document.addEventListener("DOMContentLoaded", main);
