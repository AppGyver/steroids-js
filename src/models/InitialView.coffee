class InitialView

	dismiss: (options={}, callbacks={})->
		console.log "InitialView.dismiss called"
		parameters = {}

		if options.animation?
			parameters.animation = options.animation;
		else
			parameters.animation = new steroids.Animation
				transition: "fade"


		steroids.nativeBridge.nativeCall
			method: "dismissInitialView"
			parameters: parameters
			successCallbacks: [callbacks.onSuccess]
			failureCallbacks: [callbacks.onFailure]


	show: (options={}, callbacks={})->
		console.log "InitialView.show called"
		parameters = {}

		if options.animation?
			parameters.animation = options.animation;
		else
			parameters.animation = new steroids.Animation
				transition: "fade"

		steroids.nativeBridge.nativeCall
			method: "showInitialView"
			parameters: parameters
			successCallbacks: [callbacks.onSuccess]
			failureCallbacks: [callbacks.onFailure]

