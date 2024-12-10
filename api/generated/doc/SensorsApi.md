# esp32_api.api.SensorsApi

## Load the API package
```dart
import 'package:esp32_api/api.dart';
```

All URIs are relative to *http://192.168.0.19*

Method | HTTP request | Description
------------- | ------------- | -------------
[**v1SensorsPhotocellGet**](SensorsApi.md#v1sensorsphotocellget) | **GET** /v1/sensors/photocell | Récupère la valeur actuelle pour le sensor photocell


# **v1SensorsPhotocellGet**
> ESP32Sensor v1SensorsPhotocellGet()

Récupère la valeur actuelle pour le sensor photocell

### Example
```dart
import 'package:esp32_api/api.dart';

final api = Esp32Api().getSensorsApi();

try {
    final response = api.v1SensorsPhotocellGet();
    print(response);
} catch on DioException (e) {
    print('Exception when calling SensorsApi->v1SensorsPhotocellGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**ESP32Sensor**](ESP32Sensor.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

