class window.PreviewfileviewController

  # always put everything inside PhoneGap deviceready
  document.addEventListener "deviceready", ->

    # Make Navigation Bar to appear with a custom title text
    steroids.navigationBar.show { title: "previewfileview" }

  @testMediaGallery: () ->
    mediaGallery = new steroids.views.MediaGalleryView {
      files: [
        "http://www.themoorings.co.nz/images/lake-wanaka-new-zealand.jpg"
        "http://kopparberg.co.uk/sites/default/files/imagecache/content_main_image/anything_logo.jpg"
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



  @testPreviewPDF2: () ->
    pdfView = new steroids.views.PreviewFileView {
      filePath: "pdfs/Commissions.pdf"
    }

    steroids.modal.show {
      view: pdfView
    },
      onSuccess: -> steroids.logger.log "SUCCESS in showing the PreviewFileView with the PDF"
      onFailure: -> navigator.notification.alert "FAILURE in testPreviewPDF"

  @testPreviewPDFRemote: () ->
    pdfView = new steroids.views.PreviewFileView {
      filePath: "http://www.sanface.com/pdf/test.pdf"
    }

    steroids.modal.show {
      view: pdfView
    },
      onSuccess: -> steroids.logger.log "SUCCESS in testPreviewPDFRemote"
      onFailure: -> navigator.notification.alert "FAILURE in testPreviewPDFRemote"

  @testPreviewPDFRemote_invalidURL: () ->
    pdfView = new steroids.views.PreviewFileView {
      filePath: "http://some.invalid.url/file.pdf"
    }

    steroids.modal.show {
      view: pdfView
    },
      onSuccess: -> navigator.notification.alert "API call should have failed -> testPreviewPDFRemote_invalidURL"
      onFailure: -> navigator.notification.alert "Api call failed as expected ;)"

  @testPreviewPDF: () ->
    pdfView = new steroids.views.PreviewFileView {
      filePath: "pdfs/team.pdf"
    }

    steroids.modal.show {
      view: pdfView
    },
      onSuccess: -> steroids.logger.log "SUCCESS in showing the PreviewFileView with the PDF"
      onFailure: -> navigator.notification.alert "FAILURE in testPreviewPDF"
