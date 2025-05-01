let smallest = (arr: array<'a>, size: 'a => float): option<'a> => {
  arr[0]->Option.map(head =>
    Array.reduce(arr, head, (small, value) => {
      if size(small) < size(value) {
        small
      } else {
        value
      }
    })
  )
}

let inspect = (x: 'a): 'a => {
  Console.log(x)
  x
}

let rec dedupe = (arr: array<'a>, eq: ('a, 'a) => bool) => {
  switch arr[0] {
  | None => []
  | Some(x) => [x, ...dedupe(Array.sliceToEnd(arr, ~start=1)->Array.filter(y => !eq(x, y)), eq)]
  }
}
