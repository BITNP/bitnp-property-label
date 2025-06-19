#import "@preview/tiaoma:0.3.0"
#import "./label.typ": *

#let margin = 0.8cm
#set page(
  paper: "a4",
  flipped: true,
  margin: (
    top: margin,
    bottom: margin,
    left: margin,
    right: margin,
  )
)

#{
  let id_str = read(
    "./ids.txt",
    encoding: "utf8",
  )

  let ids = id_str.split("\n").filter(id => id.trim() != "")

  table(
    columns: 3,
    inset: 0cm,
    ..for id in ids {
      (double-side(id),)
    }
  )
}
  