// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Core__Array from "@rescript/core/src/Core__Array.res.js";
import * as Core__Option from "@rescript/core/src/Core__Option.res.js";

function smallest(arr, size) {
  return Core__Option.map(arr[0], function (head) {
    return Core__Array.reduce(arr, head, function (small, value) {
      if (size(small) < size(value)) {
        return small;
      } else {
        return value;
      }
    });
  });
}

function inspect(x) {
  console.log(x);
  return x;
}

export { inspect, smallest };
/* No side effect */
