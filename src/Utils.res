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

let dedupe = (arr: array<'a>, eq: ('a, 'a) => bool) => {
  Array.reduce(arr, [], (acc, s1) => {
    switch acc[0] {
    | None => [s1, ...acc]
    | Some(s2) => if eq(s2, s1) {
        acc
      } else {
        [s1, ...acc]
      }
    }
  })
}
