class window.PreviewfileviewController

  # always put everything inside PhoneGap deviceready
  document.addEventListener "deviceready", ->

    # Make Navigation Bar to appear with a custom title text
    steroids.navigationBar.show { title: "previewfileview" }

  @testPreviewPDF: () ->
    pdfView = new steroids.views.PreviewFileView {
      filePath: "pdfs/team.pdf"
    }

    steroids.modal.show {
      view: pdfView
    }
