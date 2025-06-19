#import "@preview/tiaoma:0.3.0"

#let barcode(
  content,
) = {
  tiaoma.data-matrix(
    content,
    options: (
      option-2: tiaoma.dm-size(16, 16),
      option-3: "square",
    )
  )
}