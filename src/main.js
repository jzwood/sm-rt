import { renderScene, pixelToRay, windowToOrigin, windowTest } from "./Geometry.res.js";

function main() {
  console.log("hi mom");

  const eye = {x: 5, y: 5, z:0};
  const spheres = [
    { color: [100, 300, 0], center: { x: 5, y: 5, z: -20 }, radius: 5 },
    { color: [230, 0, 100], center: { x: 6, y: 5, z: -5 }, radius: 5 },
    { color: [0, 0, 200], center: { x: 13, y: 2, z: -19 }, radius: 2 },
  ];
  const planes = [{
    color: [10, 0, 100],
    center: { x: 0, y: 0, z: 0 },
    normal: { dx: 0, dy: 1, dz: 0 },
  }];

  const scene = { spheres, triangles: [], planes };

  const w = {
    normal: {
      origin: { x: 5.2, y: 4.5, z: -5 },
      vector: { dx: 0, dy: 0, dz: -1 },
    },
    up: { dx: 0, dy: 1, dz: 0 },
    width: 4,
    height: 2.5,
    pxWidth: 8,
    pxHeight: 5,
  };

  const width = w.pxWidth;
  const height = w.pxHeight;

  const res = renderScene(eye, scene, w, 100, 100);

  const canvas = document.getElementById("canvas");
  canvas.width = width;
  canvas.height = height;
  const scale = 40
  canvas.style.transformOrigin = 'top left'
  canvas.style.transform = `scale(${scale})`;

  const ctx = canvas.getContext("2d", { alpha: true });
  //const getRgb = renderScene(eye, scene)

  const imageData = ctx.createImageData(width, height);

  //console.log(w, windowTest)
  //console.log(windowToOrigin(w), windowToOrigin(windowTest))
  for (let i = 0; i < width; i++) {
    for (let j = 0; j < height; j++) {
      console.log(pixelToRay(i, j, eye, w))
      const [r, g, b] = renderScene(eye, scene, w, i, j);
      //console.log(r,g,b)
      const x = (i + j * width) * 4;
      imageData.data[x + 0] = r; // R value
      imageData.data[x + 1] = g; // G value
      imageData.data[x + 2] = b; // B value
      imageData.data[x + 3] = 255; // A value
    }
  }

  // Draw image data to the canvas
  ctx.putImageData(imageData, 0, 0);
}

document.addEventListener("DOMContentLoaded", main);
