class ApiUrlService {
  String _apiUrl = '';
  static final ApiUrlService _singleton = ApiUrlService._internal();

  String getUrl() {
    return _apiUrl;
  }

  void setUrl(String url) {
    _apiUrl = url;
  }

  factory ApiUrlService() {
    return _singleton;
  }

  ApiUrlService._internal();
}
