import 'package:etkinlik_takip/data/models/base_models/base_pagination_response_model.dart';
import 'package:etkinlik_takip/data/models/base_models/error_model.dart';
import 'package:etkinlik_takip/data/models/event_models/event_model.dart';
import 'package:etkinlik_takip/data/services/base_services/IFirebaseBaseService.dart';
import 'package:etkinlik_takip/data/services/event_service/IEventService.dart';
import 'package:etkinlik_takip/product/functions/error_message_function.dart';
import 'package:etkinlik_takip/product/utility/firebase/firebase_collections.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EventFirebaseService extends IFirebaseBaseService implements IEventService {
  EventFirebaseService.init();

  @override
  Future<BasePaginationModel<EventModel>?> getEvents() async {
    try {
      final collections = FirebaseCollections.events;
      final newsCollectionReference = collections.reference;
      final response = await newsCollectionReference
          .withConverter(
            fromFirestore: (snapshot, options) {
              return EventModel.fromFirestore(snapshot);
            },
            toFirestore: (value, options) {
              return {};
            },
          )
          .get();

      if (response.docs.isNotEmpty) {
        final values = response.docs.map((e) => e.data()).toList();
        return BasePaginationModel(data: values, success: true);
      }
      return BasePaginationModel(data: [], success: true);
    } catch (e, stackTrace) {
      String? errorMessage;
      if (e is FirebaseAuthException) {
        errorMessage = ErrorMessageFunction().getFirebaseErrorMessage(e.code);
      }
      errorMessage ??= 'Etkinlikler gösterilemiyor';
      setError(exception: e, stackTrace: stackTrace);
      return BasePaginationModel(error: ErrorModel(errorMessage: errorMessage), success: true);
    }
  }
}
