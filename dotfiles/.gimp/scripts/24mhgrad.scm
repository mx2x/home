;;mhgradient
;Kiki

(define (script-fu-mhgradient text size font text-gradient opa md ns bg-color white? fr?)
  (let* ((img (car (gimp-image-new 256 256 RGB)))
;;    
	 (text-layer (car (gimp-text-fontname img -1 0 0 text 10 TRUE size PIXELS font)))
;;        
	 (width (car (gimp-drawable-width text-layer)))
	 (height (car (gimp-drawable-height text-layer)))

         (old-fg (car (gimp-palette-get-foreground)))
         (old-grad (car (gimp-gradients-get-gradient)))
)
    (gimp-image-undo-disable img)

;; T C Y    
    (gimp-image-resize img (+ width 10) (+ height 10) 10 10)

    (script-fu-mhgradientimg img text-layer text-gradient opa md ns bg-color white? fr?)

    (gimp-palette-set-foreground old-fg)
    (gimp-gradients-set-gradient old-grad)

    (gimp-image-undo-enable img)
    (gimp-display-new img)
))

(script-fu-register "script-fu-mhgradient"
		    "<Toolbox>/Xtns/Script-Fu/MH/gradient"
		    "mhgradient"
		    "Kiki"
		    "Giants"
		    "2005/1"
		    ""
		    SF-STRING     "Text String"        "Gradient"
		    SF-ADJUSTMENT "Font Size (pixels)" '(100 2 1000 1 10 0 1)
		    SF-FONT       "Font"               "SneakOut"
                    SF-GRADIENT   "Gradient"           "Shadows 1"
		    SF-ADJUSTMENT "Opacity"            '(5 1 100 1 2 0 0)
                    SF-OPTION     "mode"               '(_"normal" _"noise" _"tile" _"fractal")
		    SF-ADJUSTMENT "noise"              '(0.2 0.01 1 0.01 0.02 2 0)
		    SF-COLOR      "Background Color"   '(243 255 222)
                    SF-TOGGLE     "white?"              FALSE
                    SF-TOGGLE     "Flatten Image"       TRUE
)


;   K p           O     \                
(define (script-fu-mhgradientimg img drawable text-gradient opa md ns bg-color white? fr?)
  (let* (

;;        
	 (width (car (gimp-drawable-width drawable)))
	 (height (car (gimp-drawable-height drawable)))
;; w i
	 (bg-layer (car (gimp-layer-new img (+ width 10) (+ height 10) RGB-IMAGE "Background" 100 NORMAL-MODE)))

         (old-fg (car (gimp-palette-get-foreground)))
         (old-grad (car (gimp-gradients-get-gradient)))

;;2.4    
	 (l1) (l2) (l3) (l4) (l5)
	 (l6) (l7) (l8) (l9) (l10)
	 (l11) (l12) (l13) (l14) (l15)
	 (l16) (l17) (l18) (l19) (l20)
	 (l21)
	 (k1)
)
    (gimp-image-undo-group-start img)

;; O i F      
    (gimp-palette-set-foreground '(0 0 0))
    (gimp-layer-set-preserve-trans drawable TRUE)
    (gimp-edit-fill drawable FOREGROUND-FILL)
    (gimp-layer-set-opacity drawable opa)            ;     x      
    (set! l1 (car (gimp-layer-copy drawable 0)))     ;   C   [   R s [    
    (gimp-image-add-layer img l1 0)                  ;   C   [    
    (gimp-layer-translate l1 -1 0)                   ;      
    (set! l2 (car (gimp-layer-copy l1 0)))
    (gimp-image-add-layer img l2 0)
    (gimp-layer-translate l2 0 -1)
    (set! l3 (car (gimp-layer-copy l2 0)))
    (gimp-image-add-layer img l3 0)
    (gimp-layer-translate l3 -1 0)
    (set! l4 (car (gimp-layer-copy l3 0)))
    (gimp-image-add-layer img l4 0)
    (gimp-layer-translate l4 0 -1)
    (set! l5 (car (gimp-layer-copy l4 0)))
    (gimp-image-add-layer img l5 0)
    (gimp-layer-translate l5 -1 0)
    (set! l6 (car (gimp-layer-copy l5 0)))
    (gimp-image-add-layer img l6 0)
    (gimp-layer-translate l6 0 -1)
    (set! l7 (car (gimp-layer-copy l6 0)))
    (gimp-image-add-layer img l7 0)
    (gimp-layer-translate l7 -1 0)
    (set! l8 (car (gimp-layer-copy l7 0)))
    (gimp-image-add-layer img l8 0)
    (gimp-layer-translate l8 0 -1)
    (set! l9 (car (gimp-layer-copy l8 0)))
    (gimp-image-add-layer img l9 0)
    (gimp-layer-translate l9 -1 0)
    (set! l10 (car (gimp-layer-copy l9 0)))
    (gimp-image-add-layer img l10 0)
    (gimp-layer-translate l10 0 -1)
    (set! l11 (car (gimp-layer-copy l10 0)))
    (gimp-image-add-layer img l11 0)
    (gimp-layer-translate l11 -1 0)
    (set! l12 (car (gimp-layer-copy l11 0)))
    (gimp-image-add-layer img l12 0)
    (gimp-layer-translate l12 0 -1)
    (set! l13 (car (gimp-layer-copy l12 0)))
    (gimp-image-add-layer img l13 0)
    (gimp-layer-translate l13 -1 0)
    (set! l14 (car (gimp-layer-copy l13 0)))
    (gimp-image-add-layer img l14 0)
    (gimp-layer-translate l14 0 -1)
    (set! l15 (car (gimp-layer-copy l14 0)))
    (gimp-image-add-layer img l15 0)
    (gimp-layer-translate l15 -1 0)
    (set! l16 (car (gimp-layer-copy l15 0)))
    (gimp-image-add-layer img l16 0)
    (gimp-layer-translate l16 0 -1)
    (set! l17 (car (gimp-layer-copy l16 0)))
    (gimp-image-add-layer img l17 0)
    (gimp-layer-translate l17 -1 0)
    (set! l18 (car (gimp-layer-copy l17 0)))
    (gimp-image-add-layer img l18 0)
    (gimp-layer-translate l18 0 -1)
    (set! l19 (car (gimp-layer-copy l18 0)))
    (gimp-image-add-layer img l19 0)
    (gimp-layer-translate l19 -1 0)
    (set! l20 (car (gimp-layer-copy l19 0)))
    (set! k1 (car (gimp-image-merge-visible-layers img 0))) ;          (                    )

    (gimp-gradients-set-gradient text-gradient)        ; O   f [ V          
    (gimp-layer-set-preserve-trans k1 TRUE)          ;              
    (gimp-edit-blend k1 CUSTOM-MODE NORMAL-MODE GRADIENT-LINEAR 100 20 REPEAT-NONE FALSE FALSE 0 0 FALSE 0 0 width 0)

    (if (= md 1) (plug-in-noisify 1 img k1 0 ns ns ns 0))
    (if (= md 2) (plug-in-mosaic 1 img k1 15 4 1 0.65 1 135 0.2 1 1 1 0 0))
    (if (= md 3) (plug-in-fractalexplorer 1 img k1 6 -0.07837 0.15820 -0.48578 -0.19739 134.96899 0.11 0.037 1 1 1 1 1 2 0 0 0 0 256))

    (gimp-image-add-layer img l20 0)
    (gimp-layer-translate l20 0 -1)
    (gimp-layer-set-opacity l20 100)                 ;     x      
    (gimp-edit-blend l20 CUSTOM-MODE NORMAL-MODE GRADIENT-LINEAR 100 20 REPEAT-NONE FALSE FALSE 0 0 FALSE 0 0 width 0)
    (set! l21 (car (gimp-layer-copy l20 0)))         ;   C   [         A O   f [ V       t           
    (gimp-image-add-layer img l21 0)
    (gimp-layer-translate l21 -1 -1)
    (gimp-edit-blend l21 CUSTOM-MODE NORMAL-MODE GRADIENT-LINEAR 100 20 REPEAT-NONE FALSE FALSE 0 0 FALSE width 0 0 0)
    (if (= TRUE white?)
    (begin
      (gimp-palette-set-foreground '(255 255 255))
      (gimp-edit-fill l21 FOREGROUND-FILL)
      (gimp-layer-set-opacity l21 50)
    ))
    (gimp-image-merge-visible-layers img 0)          ;          

;; w i F      (bg-layer                 C   [          )
    (gimp-palette-set-foreground bg-color)
    (gimp-image-add-layer img bg-layer 1)
    (gimp-drawable-fill bg-layer FOREGROUND-FILL)

    (if (= TRUE fr?) (gimp-image-flatten img))

    (gimp-palette-set-foreground old-fg)
    (gimp-gradients-set-gradient old-grad)

    (gimp-image-undo-group-end img)
    (gimp-displays-flush)
))

(script-fu-register "script-fu-mhgradientimg"
		    "<Image>/Script-Fu/MH/gradient"
		    "mhgradientimg"
		    "Kiki"
		    "Giants"
		    "2005/1"
		    "RGBA"
		    SF-IMAGE      "Image"     0
		    SF-DRAWABLE   "Drawable"  0
                    SF-GRADIENT   "Gradient"           "Shadows 1"
		    SF-ADJUSTMENT "Opacity"            '(5 1 100 1 2 0 0)
                    SF-OPTION     "mode"               '(_"normal" _"noise" _"tile" _"fractal")
		    SF-ADJUSTMENT "noise"              '(0.2 0.01 1 0.01 0.02 2 0)
		    SF-COLOR      "Background Color"   '(243 255 222)
                    SF-TOGGLE     "white?"              FALSE
                    SF-TOGGLE     "Flatten Image"       TRUE
)

