#import "barcode.typ": *

#let hi-vis-text(
  content
) = {
  set text()
  text(
    size: 7pt,
    font: "Jetbrains Mono",
    weight: 700,
  )[#content]
}

#let label(
  content,
) = {
  set text(
    font: ("IBM Plex Sans", "Noto Sans CJK SC"), 
    hyphenate: false, 
  )
  let content = upper(content)
  box(
    inset: 0.25cm,
    grid(
      columns: 2,
      gutter: 0.2cm,
      align: horizon,
      barcode(content),
      box(
        [
          #set text(size: 6pt, weight: 700)
          网络开拓者协会资产
          #linebreak()
          #set text(size: 6pt, weight: 500)
          BITNP Property
          #linebreak()
          #hi-vis-text(
            content,
          )
        ]
      ),
    )
  )
}

#let double-side(
  content,
) = {
  set text(
    font: ("IBM Plex Sans", "Noto Sans CJK SC"), 
    hyphenate: false, 
  )
  let content = upper(content)
  table(
    columns: 3,
    inset: 0cm,
    stroke: 0pt,
    label(content),
    box(
      inset: (
        left: 2.3cm,
      ),
    ),
    rotate(
      180deg,
    )[
      #label(content)
    ],
  )
}
