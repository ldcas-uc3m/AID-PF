// two-tone table, takes same args as table
#let two-tone-table(..args) = {
  set table(
    fill: (_, y) => if calc.even(y) { rgb("f2f2f2") },
    stroke: (
      x: 0pt,
      y: rgb("dee2e6")
    )
  )

  show table.cell.where(x: 0): set text(weight: "bold")  // bold for first col

  table(..args)
}