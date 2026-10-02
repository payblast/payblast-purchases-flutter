class Package {
  Package(this.lookupKey, this.products);
  final String lookupKey;
  final Map<String, String> products;
}

class PayblastHttp {
  const PayblastHttp({required this.getJson, required this.postJson});
  final Future<Map<String, dynamic>> Function(String path, String apiKey) getJson;
  final Future<Map<String, dynamic>> Function(String path, String apiKey, Map<String, dynamic> body) postJson;
}

class Purchases {
  Purchases(this.baseUrl, this.http);
  final String baseUrl;
  final PayblastHttp http;
  String _apiKey = '';
  String _appUserId = '';

  void configure(String apiKey, String appUserId) {
    _apiKey = apiKey;
    _appUserId = appUserId;
  }

  Future<Map<String, dynamic>> logIn(String appUserId) async {
    final info = await http.postJson('$baseUrl/v1/customers/$_appUserId/login', _apiKey, {
      'new_app_user_id': appUserId,
    });
    _appUserId = appUserId;
    return info;
  }

  void logOut() {
    _appUserId = r'$payblastAnon';
  }

  Future<Map<String, dynamic>> getOfferings() {
    return http.getJson('$baseUrl/v1/offerings', _apiKey);
  }

  Future<Map<String, dynamic>> purchase(Package package) {
    return getCustomerInfo();
  }

  Future<Map<String, dynamic>> restore() => getCustomerInfo();

  Future<Map<String, dynamic>> getCustomerInfo() {
    return http.getJson('$baseUrl/v1/customers/$_appUserId', _apiKey);
  }

  String presentPaywall(Map<String, dynamic> document, List<Package> packages) {
    return '${document['blocks']} ${packages.map((package) => package.lookupKey).join(' ')}';
  }
}
