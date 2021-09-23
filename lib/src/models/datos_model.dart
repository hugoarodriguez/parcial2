// ignore_for_file: non_constant_identifier_names, prefer_initializing_formals

class DatosModel{
  String id = '';
  String title = '';
  String status = '';
  String content = '';
  String user_id = '';

  DatosModel(String id, String title, String status, String content, String user_id){
    this.id = id;
    this.title = title;
    this.status = status;
    this.content = content;
    this.user_id = user_id;
  }
}