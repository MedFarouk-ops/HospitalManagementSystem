import 'dart:html';

class ApiMethods {

      static Future<HttpRequest> postFormData(String url, Map<String, String> data,
          {bool? withCredentials,
          String? responseType,
          Map<String, String>? requestHeaders,
          void onProgress(ProgressEvent e)?}) {
        var parts = [];
        data.forEach((key, value) {
          parts.add('${Uri.encodeQueryComponent(key)}='
              '${Uri.encodeQueryComponent(value)}');
        });
        var formData = parts.join('&');

        if (requestHeaders == null) {
          requestHeaders = <String, String>{};
        }
        requestHeaders.putIfAbsent('Content-Type',
            () => 'application/x-www-form-urlencoded; charset=UTF-8');

        return HttpRequest.request(url,
            method: 'POST',
            withCredentials: withCredentials,
            responseType: responseType,
            requestHeaders: requestHeaders,
            sendData: formData,
            onProgress: onProgress);
      }



}