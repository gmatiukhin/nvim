;; inherits: latex

((begin
    name: (curly_group_text
      text: (text
        word: (word) @env.name
        (#eq? @env.name "code")
        ))) 
  (text) @injection.content
  (#set! injection.language "haskell")
  (#set! injection.include-children)
  (#set! injection.combined)
 )
