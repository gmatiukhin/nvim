([
  (tex)
  (begin)
  (end)
  ] @injection.content
  (#set! injection.language "tex")
  (#set! injection.include-children)
  (#set! injection.combined))

((code) @injection.content
  (#set! injection.language "haskell")
  (#set! injection.include-children))
