import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:networking/networking.dart';

@immutable
class NetworkState {
  const NetworkState({
    this.isLoading = false,
    this.data,
    this.error,
  });

  final bool isLoading;
  final ExampleResponse? data;
  final String? error;
}

class NetworkCubit extends Cubit<NetworkState> {
  NetworkCubit(this._fetcher) : super(const NetworkState());

  final ExampleFetcher _fetcher;

  Future<void> loadExample() async {
    emit(const NetworkState(isLoading: true));
    try {
      final fetched = await _fetcher.fetchExample();
      emit(NetworkState(data: fetched));
    } catch (error, stackTrace) {
      emit(NetworkState(error: error.toString()));
      // ignore: avoid_print
      print('NetworkCubit.loadExample failed: $error\n$stackTrace');
    }
  }
}
