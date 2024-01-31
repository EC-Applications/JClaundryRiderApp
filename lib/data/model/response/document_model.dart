import 'package:efood_multivendor_driver/data/model/response/document_type_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DocumentModel {
  TextEditingController controller;
  List<XFile> files;
  List<String> stringFiles;
  DocumentTypeModel documentType;

  DocumentModel(this.controller, this.files, this.stringFiles, this.documentType);
}