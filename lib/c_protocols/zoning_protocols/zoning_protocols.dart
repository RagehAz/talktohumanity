import 'dart:convert';
import 'package:filers/filers.dart';
import 'package:http/http.dart';
import 'package:rest/rest.dart';

class ZoningProtocols {
  // -----------------------------------------------------------------------------

  const ZoningProtocols();

  // -----------------------------------------------------------------------------
  ///
  static Future<String> getZoneByIPApi() async  {
    String _output;

    /// NOTE : this is limited and needs paid subscription

    const String _url = 'http://ip-api.com/json';

    await tryAndCatch(
        invoker: 'get Country by IP',
        functions: () async {

          final Response _response = await Rest.get(
            rawLink: _url,
            invoker: 'getZoneByIPApi',
          );

          /// RECEIVED DATA
          if (_response?.statusCode == 200) {

            final Map<String, dynamic> _countryData = json.decode(_response.body);

            if (_countryData != null) {
              final String _countryISO = _countryData['countryCode'];
              final String _cityName = _countryData['city'];

              _output = '$_countryISO+$_cityName';

            }

            blog('_getZoneByIP_ipApi : found data : response body is : ${_response?.body}');
          }

          /// NO DATA RECEIVED
          else {
            blog('_getZoneByIP_ipApi : no data : response is : $_response');
          }

        }
    );

    return _output;

  }
  // -----------------------------------------------------------------------------
}
