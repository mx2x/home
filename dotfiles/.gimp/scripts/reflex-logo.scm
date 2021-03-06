;; Script-Fu Reflex

(define (apply-reflex-logo image drawable gradient displace merge)
 
	(let* (
		(old-bg (car (gimp-context-get-background)))
		(old-fg (car (gimp-context-get-foreground)))
		(old-gradient (car (gimp-context-get-gradient)))

		(image-width (car (gimp-drawable-width drawable)))
		(image-height (car (gimp-drawable-height drawable)))
		(area (+ image-width image-height))

		(c-x (car (gimp-drawable-offsets drawable)))
		(c-y (cadr (gimp-drawable-offsets drawable)))

		(white-layer (car (gimp-layer-new image image-width image-height RGBA-IMAGE "Blur" 100 NORMAL-MODE)))
		(text-layer (car (gimp-layer-new-from-drawable drawable image)))
		(fond-layer (car (gimp-layer-new image image-width image-height RGBA-IMAGE (string-append gradient) 100 NORMAL-MODE)))
		(horizon-layer (car (gimp-layer-new-from-drawable fond-layer image)))
		(bump-layer (car (gimp-layer-new image image-width image-height RGBA-IMAGE "Edge" 100 OVERLAY-MODE)))
		(blur-layer)
		(adjust)
		(layer)
		)

	(gimp-image-add-layer image white-layer -1)
	(gimp-image-add-layer image text-layer -1)
	(gimp-image-add-layer image fond-layer -1)
	(gimp-image-add-layer image horizon-layer -1)
	(gimp-image-add-layer image bump-layer -1)

	(gimp-edit-clear fond-layer) 
	(gimp-edit-clear horizon-layer)

	(gimp-layer-set-offsets white-layer c-x c-y)
	(gimp-layer-set-offsets text-layer c-x c-y)
	(gimp-layer-set-offsets fond-layer c-x c-y)
	(gimp-layer-set-offsets horizon-layer c-x c-y)
	(gimp-layer-set-offsets bump-layer c-x c-y)

(gimp-context-set-background '(255 255 255))
(gimp-edit-fill white-layer 1)
(set! blur-layer (car (gimp-image-merge-down image text-layer 0)))
(plug-in-gauss-rle2 1 image blur-layer (/ area 70) (/ area 70))

(gimp-context-set-gradient gradient)
(gimp-edit-blend fond-layer 3 0 0 100 0 0 FALSE FALSE 0 0 FALSE 0 0 0 (+ image-height displace))
(gimp-drawable-set-visible fond-layer FALSE)
(gimp-edit-blend horizon-layer 3 0 0 100 0 0 FALSE FALSE 0 0 FALSE 0 0 0 image-height)
(gimp-drawable-set-name horizon-layer "Reflex")
(set! adjust (* displace 2))
(plug-in-displace 1 image horizon-layer (/ area (- 70 adjust)) (/ area (- 70 adjust)) TRUE TRUE blur-layer blur-layer 1)

(gimp-context-set-foreground '(152 152 152))
(gimp-edit-fill bump-layer 0)
(plug-in-bump-map 1 image bump-layer blur-layer 135 27 7 0 0 0 0 TRUE TRUE 2)
(plug-in-gauss-rle2 1 image bump-layer 1 1)
(gimp-image-remove-layer image blur-layer)
(gimp-context-set-gradient "Three bars sin")
(plug-in-gradmap 1 image bump-layer)

(gimp-selection-layer-alpha drawable)
(if (> area 200)
    (gimp-selection-grow image (/ area 160))
    (gimp-selection-grow image 1))
(gimp-selection-invert image)
(gimp-edit-clear horizon-layer)
(gimp-edit-clear bump-layer)
(gimp-selection-none image)

(if (= merge TRUE)
	(begin
		(gimp-image-remove-layer image fond-layer)
		(gimp-image-merge-down image horizon-layer 0)
		(set! layer (car (gimp-image-merge-down image bump-layer 0)))
		(gimp-drawable-set-name layer "Script-fu reflex")
	)
)

(gimp-context-set-background old-bg)
(gimp-context-set-foreground old-fg)
(gimp-context-set-gradient old-gradient)

	)
)



;; ------------------------
;; script pour <image> 
;; ------------------------

(define (script-fu-reflex-logo-alpha image drawable gradient displace merge)
  		(gimp-image-undo-group-start image)
    		
	(let* (
		(var-select (car (gimp-selection-is-empty image)))
		(canal)
		(old-fg)
		)
		(if (= var-select TRUE) 
			(begin 
			)
			(begin 
				(set! canal (car (gimp-selection-save image)))
			)
		)
		(gimp-selection-none image)

		(set! old-fg (car (gimp-context-get-foreground)))
		(gimp-context-set-foreground '(0 0 0))

		(set! drawable (car (gimp-layer-copy drawable TRUE)))
		(gimp-layer-set-mode drawable NORMAL-MODE)
		(gimp-image-add-layer image drawable -1)
		(gimp-layer-set-preserve-trans drawable TRUE)
		(gimp-edit-fill drawable FOREGROUND-FILL)
		(gimp-layer-set-preserve-trans drawable FALSE)

		(apply-reflex-logo image drawable gradient displace merge)
    		
		(if (= var-select TRUE) 
			(begin 
			)
			(begin 
				(gimp-selection-load canal)
				(gimp-image-remove-channel image canal)
			)
		)

		(if (= merge TRUE)
			(gimp-image-merge-down image layer 0)
			(gimp-image-remove-layer image drawable))

        (gimp-context-set-foreground old-fg)
		(gimp-image-undo-group-end image)
		(gimp-displays-flush)
	)
)

(script-fu-register "script-fu-reflex-logo-alpha"
       _"Reflex..."
        "Reflex"
        "Expression"
        "Free"
        "2006"
        "RGBA"
        SF-IMAGE      "Image"        0
        SF-DRAWABLE   "Drawable"     0
        SF-GRADIENT   "Gradient"     "Horizon 2"
        SF-ADJUSTMENT "            "     '(10 1 20 1 10 0 0)
        SF-TOGGLE     "                  " TRUE
)

(script-fu-menu-register "script-fu-reflex-logo-alpha"
		_"<Image>/Script-Fu/Alpha to Logo"
)



;; ------------------------
;; script pour <toolbox> 
;; ------------------------

(define (script-fu-reflex-logo text size font gradient displace merge)

  (let* (

	(image (car (gimp-image-new 256 256 RGB)))
	(bg-layer (car (gimp-layer-new image 256 256 RGBA-IMAGE "Background" 100 NORMAL-MODE)))
	(text-layer (car (gimp-text-fontname image -1 0 0 text 10 TRUE size PIXELS font))))

	(gimp-image-undo-disable image)

    (gimp-drawable-set-name text-layer "Text")
	(gimp-image-resize image (car (gimp-drawable-width text-layer)) (car (gimp-drawable-height text-layer)) 0 0)    	
	(apply-reflex-logo image text-layer gradient displace merge)

	(if (= merge FALSE)
		(begin 
	      (gimp-edit-fill text-layer WHITE-FILL)
	      (gimp-drawable-set-name text-layer "Background")
		)
	)

	(gimp-image-undo-enable image)
	(gimp-display-new image)
  )
)

(script-fu-register "script-fu-reflex-logo"
       _"Reflex..."
        "Reflex"
        "Expression"
        "Free"
        "2006"
        ""
        SF-STRING     _"Text"               "Reflex"
        SF-ADJUSTMENT _"Font size (pixels)" '(200 2 1000 1 10 0 1)
        SF-FONT       _"Font"               "Cooper Heavy"
        SF-GRADIENT    "Gradient"           "Horizon 2"
        SF-ADJUSTMENT  "            "           '(10 1 20 1 10 0 0)
        SF-TOGGLE      "                  "        FALSE
)

(script-fu-menu-register "script-fu-reflex-logo"
		_"<Toolbox>/Xtns/Script-Fu/Extra Logos"
)