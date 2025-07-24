import 'package:bloc_test/bloc_test.dart';
import 'package:etkinlik_takip/data/cache/cache_services/event_cache_service.dart';
import 'package:etkinlik_takip/features/home/viewmodel/home_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

import '../data/cache/events_cache_mock.dart';
import '../data/services/connectivity_mock_service.dart';
import '../data/services/event_service_mock.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late HomeCubit homeViewCubit;
  setUp(() {
    homeViewCubit = HomeCubit(
      eventCacheFunc: EventCacheService(eventListCacheOperation: EventsCacheMock()),
      eventService: EventServiceMock(),
      connectivityService: ConnectivityMockService(),
    );
  });

  group('Home Cubit Test', () {
    test('inital state is loading', () {
      expect(homeViewCubit.state.isLoading, true);
    });
  });
  blocTest<HomeCubit, HomeState>(
    'init state is loading',
    build: () => homeViewCubit,
    act: (bloc) async => bloc.refreshPage(),
    expect: () => [
      isA<HomeState>().having((state) => state.isLoading, 'Is Loading True', true),
      isA<HomeState>().having((state) => state.isLoading, 'Is Loading False', false),
    ],
  );

  blocTest<HomeCubit, HomeState>(
    'refresh page is loading',
    build: () => homeViewCubit,
    act: (bloc) async => await bloc.refreshPage(),
    expect: () => [
      isA<HomeState>().having((state) => state.isLoading, 'Is Loading True', true),
      isA<HomeState>().having((state) => state.isLoading, 'Is Loading False', false),
    ],
  );
}
