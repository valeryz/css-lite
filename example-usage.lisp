(in-package css-lite)

;;simple usage
(css (("#foo") (:height "50px")))
"
#foo {
height:50px;
}
"

;; defining a css-variable manually

(setq my-css-var '(:margin "50px 30px"))
(setf (get 'my-css-var 'css-var) t)

;; using that css-variable
(css (("#foo") (:height "50px" my-css-var)))
"
#foo {
height:50px;
margin:50px 30px;
}
"

;; now defining a css-variable with the make-css-var macro

(make-css-var my-favorite-border-var '(:border "1px solid red"))

;;using that variable
(css (("#foo") (:height "50px" my-css-var my-favorite-border-var)))
"
#foo {
height:50px;
margin:50px 30px;
border:1px solid red;
}
"


;; now with cascading 
      ("#foo") (:length "50px" my-css-var my-macroed-css-var)  
      (("li") (:width "50px" :float "left"  my-css-var my-macroed-css-var))))

"
#foo {
length:50px;
margin:50px 30px;
border:1px solid red;
}

#foo li {
width:50px;
float:left;
margin:50px 30px;
border:1px solid red;
}
"

;;now with functions
(make-css-func foo-func2 (avar) (list avar avar))

(css (
      ("#foo") ((foo-func2 "should-be-repeated") :height "50px" my-css-var my-favorite-border-var)
      (("li") (:width "50px" :float "left"  my-css-var my-favorite-border-var))))

"
#foo {
should-be-repeated:should-be-repeated;
height:50px;
margin:50px 30px;
border:1px solid red;
}

#foo li {
width:50px;
float:left;
margin:50px 30px;
border:1px solid red;
}
"
;; now with comments
(make-css-func comment (comment-string) (list (concatenate 'string "/*" comment-string) "*/"))
(css (
      ("#foo") ((comment "a comment" ) (foo-func2 "should-be-repeated") :height "50px" my-css-var my-favorite-border-var)
      (("li") (:width "50px" my-css-var my-favorite-border-var))))

"
#foo {
/*a comment:*/;
should-be-repeated:should-be-repeated;
height:50px;
margin:50px 30px;
border:1px solid red;
}

#foo li {
width:50px;
margin:50px 30px;
border:1px solid red;
}
"

;; note this is a bit of a hack
;;
;; comments end up looking like this /* comment text :*/; notice the
;; colon before the closing */


