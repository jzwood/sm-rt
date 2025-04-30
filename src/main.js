import { getPixel, renderScene } from "./Geometry.res.js";
import { eye, scene, win } from './View.res.js'
import { toCartesian } from './Polar.res.js'

function main() {
  console.log("hi mom");

  //const eye = { x: 5, y: 4.5, z: -1.5 };
  //const spheres = [
    //{ color: [255, 0, 0], center: { x: 5, y: 5, z: -20 }, radius: 5 },
    //{ color: [0, 255, 0], center: { x: 5, y: 3, z: -17 }, radius: 2 },
  //];
  //const planes = [{
    //color: [0, 0, 255],
    //center: { x: 0, y: 0, z: 0 },
    //normal: { dx: 0, dy: 1, dz: 0 },
  //}];

  //const scene = { spheres, triangles: [], planes };

  const multiplier = 40;
  const scale = 3;

  const w = {
    ...win,
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

  const ctx = canvas.getContext("2d", { alpha: false });

  const imageData = ctx.createImageData(width, height);
  renderScene(imageData.data, scene, eye, w);
  ctx.putImageData(imageData, 0, 0);

  let theta = 0
  let phi = 0
  let rho = 4
  let pan = 10;
  let index = 1
  document.addEventListener("keydown", (e) => {
    e.preventDefault();
    console.log(e.key, typeof e.key)
    switch (e.key) {
      case "ArrowLeft": {
        theta += pan
        break;
      }
      case "ArrowRight": {
        theta -= pan
        break;
      }
      case "ArrowUp": {
        phi += pan
        break;
      }
      case "ArrowDown": {
        phi -= pan
        break;
      }
      default:
        let i = /^\d$/.test(e.key) && parseInt(e.key)
        if (i) {
          index = i
          theta = 0
          phi = 0
        }
        break;
    }

    let { dx, dy, dz} = toCartesian({theta, phi, rho})
    scene.spheres.at(index).center.x = dx
    scene.spheres.at(index).center.y = dy
    scene.spheres.at(index).center.z = dz

    renderScene(imageData.data, scene, eye, w);
    ctx.putImageData(imageData, 0, 0);
  });
}

document.addEventListener("DOMContentLoaded", main);
