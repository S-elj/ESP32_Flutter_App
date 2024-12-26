# esp32_api.api.MetadataApi

## Load the API package
```dart
import 'package:esp32_api/api.dart';
```

All URIs are relative to *http://192.168.0.19*

Method | HTTP request | Description
------------- | ------------- | -------------
[**v1MetadataGet**](MetadataApi.md#v1metadataget) | **GET** /v1/metadata | Récupère les métadonnées de l&#39;ESP32.


# **v1MetadataGet**
> ESP32Metadata v1MetadataGet()

Récupère les métadonnées de l'ESP32.

Récupère des métadonnées (notamment uptime) de l'ESP32.

### Example
```dart
import 'package:esp32_api/api.dart';

final api = Esp32Api().getMetadataApi();

try {
    final response = api.v1MetadataGet();
    print(response);
} catch on DioException (e) {
    print('Exception when calling MetadataApi->v1MetadataGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**ESP32Metadata**](ESP32Metadata.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

