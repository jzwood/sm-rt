import { getPixel, renderScene } from "./Geometry.res.js";
import { eye, spheres, planes, scene, win } from './View.res.js'

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
  const pan = 0.1;

  const ctx = canvas.getContext("2d", { alpha: false });

  const imageData = ctx.createImageData(width, height);
  renderScene(imageData.data, scene, eye, w);
  ctx.putImageData(imageData, 0, 0);

  document.addEventListener("keydown", (e) => {
    e.preventDefault();
    //console.log(e)
    switch (e.key) {
      case "8": {
        eye.x += pan
        Console.log(eye.x)
        //spheres[1].center.y += pan;
        break;
      }
      case "2": {
        eye.x -= pan
        //spheres[1].center.y -= pan;
        break;
      }
      case "4": {
        eye.y += pan
        //spheres[1].center.x -= pan;
        break;
      }
      case "6": {
        eye.y -= pan
        //spheres[1].center.x += pan;
        break;
      }
      case "9": {
        eye.z += pan
        //spheres[1].center.z -= pan;
        break;
      }
      case "1": {
        eye.z -= pan
        console.log(eye)
        //spheres[1].center.z += pan;
        break;
      }
      default:
        break;
    }

    renderScene(imageData.data, scene, eye, w);
    ctx.putImageData(imageData, 0, 0);
  });
}

document.addEventListener("DOMContentLoaded", main);
