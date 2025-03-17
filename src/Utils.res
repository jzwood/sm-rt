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
