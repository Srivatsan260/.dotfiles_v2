(annotation_statement "annotation" @keyword)
(ref_statement "ref" @keyword)

; Fallback: highlight declaration words even if a line parses differently
((word) @keyword.type
 (#any-of? @keyword.type
  "table"
  "column"
  "measure"
  "partition"
  "expression"
  "relationship"
  "hierarchy"
  "level"
  "role"
  "perspective"
  "culture"
  "model"
  "database"))

((flag_statement
  (name
    (word) @keyword.type
    (word)))
 (#eq? @keyword.type "table"))

((flag_statement
  (name
    (word) @keyword.type
    (word)))
 (#eq? @keyword.type "column"))

((flag_statement
  (name
    .
    (word) @keyword.type))
 (#any-of? @keyword.type
  "table"
  "column"
  "measure"
  "partition"
  "expression"
  "relationship"
  "hierarchy"
  "level"
  "role"
  "perspective"
  "culture"
  "model"
  "database"))

((flag_statement
  (name
    .
    (word) @keyword))
 (#any-of? @keyword
  "queryGroup"
  "variation"))

((assignment_statement
  key: (name
    .
    (word) @keyword.type
    (_)))
 (#any-of? @keyword.type "table" "column" "measure" "partition" "expression"))

((assignment_statement
  key: (name
    .
    (word) @keyword
    (_)))
 (#any-of? @keyword
  "model"
  "queryGroup"
  "variation"))

(property_statement key: (name) @property)
(assignment_statement key: (name) @property)
(annotation_statement name: (name) @attribute)

(quoted_name) @string
(double_quoted_name) @string
(hash_quoted_name) @string
(line_value) @string
(array) @string.special

(comment) @comment
