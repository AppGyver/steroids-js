# Modal description
class Modal extends NativeObject
  # ### Steroids.modal.show
  #
  # Shows a modal window using an animation.
  #
  # Modals are shown on top of the whole application.
  #
  # Only one modal can be shown at a time.
  #
  # #### Example:
  #
  # var layer = new Steroids.Layer({
  #   location: "http://google.com/"
  # });
  #
  # Steroids.modal.show({
  #   layer: layer
  # }, { onSuccess: function() {
  #   console.log("Layer is being shown modally");
  # }, onFailure: function(e) {
  #   console.log("Layer could not be shown modally: "+ e);
  # }});
  #
  show: (options={}, callbacks={})->
    @nativeCall
      method: "openModal"
      parameters:
        url: layer.location
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]

  # ### Steroids.modal.hide
  #
  # Removes any visible modal window using an animation and shows the application below.
  #
  # Only one modal can be shown at a time.
  #
  # #### Example:
  #
  # Steroids.modal.hide({}, { onSuccess: function() {
  #   console.log("Modal is being hidden");
  # }, onFailure: function(e) {
  #   console.log("Modal could not be hidden: "+ e);
  # }});
  #
  hide: (options={}, callbacks={})->
    @nativeCall
      method: "closeModal"
      parameters: options
      successCallbacks: [callbacks.onSuccess]
      failureCallbacks: [callbacks.onFailure]
