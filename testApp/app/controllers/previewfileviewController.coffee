class window.PreviewfileviewController

  @testPreviewPDF: () ->
    pdfView = new steroids.views.PreviewFileView {
      file: "#{steroids.app.path}/pdfs/team.pdf"
    }

    steroids.modal.show {
      view: pdfView
    }