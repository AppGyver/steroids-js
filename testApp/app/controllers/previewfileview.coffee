class window.PreviewfileviewController

  # always put everything inside PhoneGap deviceready
  document.addEventListener "deviceready", ->

    # Make Navigation Bar to appear with a custom title text
    steroids.navigationBar.show { title: "previewfileview" }

  @testMediaGallery: () ->
    mediaGallery = new steroids.views.MediaGalleryView {
      files: [
        "images/pic01.jpg"
        "images/pic02.jpg"
        "images/pic03.jpg"
        "images/pic04.jpg"
        "images/video01.mp4"
      ]
    }

    steroids.modal.show {
      view: mediaGallery
    },
      onSuccess: -> steroids.logger.log "SUCCESS in showing the MediaGalleryView with the images and video"
      onFailure: -> navigator.notification.alert "FAILURE in testMediaGallery"

  @testPreviewPDF: () ->
    pdfView = new steroids.views.PreviewFileView {
      filePath: "pdfs/team.pdf"
    }

    steroids.modal.show {
      view: pdfView
    },
      onSuccess: -> steroids.logger.log "SUCCESS in showing the PreviewFileView with the PDF"
      onFailure: -> navigator.notification.alert "FAILURE in testPreviewPDF"
