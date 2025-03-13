let maybeHead = (xs: list<'x>) : option<'x> =>
  switch xs {
    | list{} => None
    | list{x, ..._} => Some(x)
  }
