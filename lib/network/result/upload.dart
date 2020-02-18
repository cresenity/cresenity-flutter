/**
 * Created by ipul on 10/23/19.
 */

class Upload {
  String _filename;
  int _size;
  String _fileId;
  String _resourceId;
  bool _status;
  String _message;
  String _url;
  String _fullUrl;
  String _type;

  Upload();

  Upload.fromJson(Map<String, dynamic> json) {
    _filename = json['filename'];
    _size = json['size'];
    _fileId = json['fileId'];
    _resourceId = json['resourceId'];
    _status = json['status'];
    _message = json['message'];
    _url = json['url'];
    _fullUrl = json['fullUrl'];
    _type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['filename'] = this._filename;
    data['size'] = this._size;
    data['fileId'] = this._fileId;
    data['resourceId'] = this._resourceId;
    data['status'] = this._status;
    data['message'] = this._message;
    data['url'] = this._url;
    data['fullUrl'] = this._fullUrl;
    data['type'] = this._type;
    return data;
  }

  String get fileId => _fileId;

  String get resourceId => _resourceId;

  String get fullUrl => _fullUrl;

  static Upload dummy(){
    return Upload.fromJson({
      "filename":"-",
      "size":0,
      "fileId":"-",
      "resourceId":"-",
      "status":false,
      "message":"-",
      "url":"-",
      "fullUrl":"-",
      "type":"-"
    });
  }

}
