#import "@preview/pintorita:0.1.4"

#let accent-color = rgb("#4A9B9B")
#let bg-light = rgb("#F4F7F9")
#let border-color = rgb("#D0D7DE")

#let user-story(
  title: "",
  id: "",
  priority: "",
  description: "",
  additions: (),
  dependencies: (),
  dod: (),
  tasks: ()
) = {
  let prio-color = if priority == "Must-have" { rgb("#D9534F") }
                   else if priority == "Should-have" { rgb("#F0AD4E") }
                   else { rgb("#5BC0DE") }

  block(breakable: false, below: 1.2em)[
    #table(
      columns: (130pt, 1fr),
      inset: 7pt,
      stroke: 0.5pt + border-color,
      fill: (x, y) => if y == 0 { accent-color } else if x == 0 { bg-light } else { white },
      table.cell(colspan: 2)[
        #grid(
          columns: (1fr, auto),
          align: horizon,
          text(fill: white, weight: "bold", size: 11pt)[#title],
          box(fill: prio-color, inset: (x: 6pt, y: 2pt), radius: 3pt)[
            #text(fill: white, weight: "bold", size: 8pt)[#priority]
          ]
        )
      ],
      [*ID*], [#id],
      [*Description*], [#description],
      [*Additions*], [#for item in additions [- #item]],
      [*Dependencies*], [#for item in dependencies [- #item]],
      [*Definition of Done*], [#for item in dod [- #item]],
      [*Developer Tasks*], [#for item in tasks [- #item]]
    )
  ]
}

#let wireframe-box(img-path: none, title: "", body) = {
  grid(
    columns: (20%, 1fr),
    gutter: 1.5em,
    align: top,
    box(stroke: 0.5pt + border-color, radius: 6pt, clip: true)[
      #if img-path != none {
        image(img-path, width: 100%)
      } else {
        align(center + horizon, pad(2em)[_Wireframe Image Placeholder_])
      }
    ],
    [
      #heading(level: 3)[#title]
      #v(0.3em)
      #body
    ]
  )
  v(1em)
}

#let front-page() = {
  align(center)[
    #v(3cm)
    #align(center + horizon)[
      #image("images/logo_with_subtitle_transparent.svg", width: 75%)
    ]
    #text(size: 26pt, weight: "bold", fill: black)[Documentation]
    #v(3cm)
    #line(length: 40%, stroke: 1pt + border-color)
    #v(1em)
    #text(size: 11pt, fill: gray)[Idea, Development and Design by]
    #v(0.2em)
    #text(size: 14pt, weight: "bold", fill: black)[Toni Fey]
  ]
  pagebreak()
  outline(
  title: text(size: 18pt, weight: "bold", fill: accent-color)[Table of contents],
  indent: 1.5em,
  depth: 3
)
}

#let back-page() = {
  pagebreak()
  align(center)[
    #align(center + bottom)[
    #text(size: 18pt, weight: "bold", fill: accent-color)[Nursery Documentation]
    #line(length: 100%, stroke: 0.5pt + border-color)
    #v(0.8em)

    #text(size: 11pt, fill: gray)[Copyright © 2026 Toni Fey. All rights reserved. No part of this publication may be reproduced, distributed, or transmitted in any form without prior written permission.]
    ]
  ]
}

#let nursery-template(body) = {
  set document(title: "Nursery Documentation", author: "Toni Fey")
  set page(
    paper: "a4",
    margin: (top: 2.5cm, bottom: 2.5cm, left: 2.2cm, right: 2.2cm),
    header: context {
      if counter(page).get().first() > 1 and counter(page).get().first() < counter(page).final().first() [
        #set text(size: 8.5pt, fill: gray)
        #grid(
          columns: (1fr, 1fr),
          align(left)[Nursery - Project Documentation],
          align(right)[Toni Fey]
        )
        #v(-0.6em)
        #line(length: 100%, stroke: 0.5pt + border-color)
      ]
    },
    footer: context {
      if counter(page).get().first() > 1 and counter(page).get().first() <= counter(page).final().first() - 1 [
        #line(length: 100%, stroke: 0.5pt + border-color)
        #v(-0.4em)
        #set text(size: 8.5pt, fill: gray)
        #align(right)[Page #counter(page).display() of #counter(page).final().first()]
      ]
    }
  )

  set text(font: "Roboto", size: 10.5pt, fill: rgb("#1F2328"), lang: "en")
  set par(justify: true, leading: 0.65em)
  set heading(numbering: "1.1")

  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    v(0.5em)
    text(size: 18pt, weight: "bold", fill: accent-color, it)
    v(0.2em)
    line(length: 100%, stroke: 1.5pt + accent-color)
    v(0.6em)
  }

  show heading.where(level: 2): it => {
    v(0.8em)
    text(size: 13.5pt, weight: "bold", fill: accent-color, it)
    v(0.3em)
  }

  show heading.where(level: 3): it => {
    v(0.6em)
    text(size: 11.5pt, weight: "bold", fill: accent-color, it)
    v(0.2em)
  }

  show raw.where(block: true): block.with(
    fill: bg-light,
    inset: 10pt,
    radius: 4pt,
    width: 100%,
    stroke: 0.5pt + border-color
  )

  show raw.where(lang: "pintora"): it => pintorita.render(it.text)
  front-page()
  body
  back-page()
}
