class DocumentTypeModel {
  String documentTitle;
  String documentType;
  int fileCount;

  DocumentTypeModel({this.documentTitle, this.documentType, this.fileCount});

  DocumentTypeModel.fromJson(Map<String, dynamic> json) {
    documentTitle = json['document_title'];
    documentType = json['document_type'];
    fileCount = int.parse(json['file_count'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['document_title'] = this.documentTitle;
    data['document_type'] = this.documentType;
    data['file_count'] = this.fileCount;
    return data;
  }
}
