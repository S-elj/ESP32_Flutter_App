# esp32_api.api.MinuteurApi

## Load the API package
```dart
import 'package:esp32_api/api.dart';
```

All URIs are relative to *http://192.168.0.19*

Method | HTTP request | Description
------------- | ------------- | -------------
[**v1MinuteurActivatePost**](MinuteurApi.md#v1minuteuractivatepost) | **POST** /v1/minuteur/activate | Démare un minuteur
[**v1MinuteurStopPost**](MinuteurApi.md#v1minuteurstoppost) | **POST** /v1/minuteur/stop | Arrête le minuteur


# **v1MinuteurActivatePost**
> Success v1MinuteurActivatePost(delay, duration)

Démare un minuteur

Envoie une requête pour activer le minteur après un délai (`delay`) et pendant une durée spécifiée (`duration`).

### Example
```dart
import 'package:esp32_api/api.dart';

final api = Esp32Api().getMinuteurApi();
final int delay = 56; // int | Délai avant d'activer le buzzer (en millisecondes).
final int duration = 56; // int | Durée pendant laquelle le buzzer sonne (en millisecondes).

try {
    final response = api.v1MinuteurActivatePost(delay, duration);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MinuteurApi->v1MinuteurActivatePost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **delay** | **int**| Délai avant d'activer le buzzer (en millisecondes). | 
 **duration** | **int**| Durée pendant laquelle le buzzer sonne (en millisecondes). | 

### Return type

[**Success**](Success.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **v1MinuteurStopPost**
> Success v1MinuteurStopPost()

Arrête le minuteur

Cette requête arrête le minuteur immédiatement, cela inclut arrêter un buzzer planifier.

### Example
```dart
import 'package:esp32_api/api.dart';

final api = Esp32Api().getMinuteurApi();

try {
    final response = api.v1MinuteurStopPost();
    print(response);
} catch on DioException (e) {
    print('Exception when calling MinuteurApi->v1MinuteurStopPost: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**Success**](Success.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

