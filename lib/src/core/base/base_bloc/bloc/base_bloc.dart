import 'package:flutter_bloc/flutter_bloc.dart';

// a basic extension for bloc to separate the way we handle events with adn without transform
abstract class BaseBloc<E, S> extends Bloc<E, S> {
  BaseBloc(super.initialState) {
    on<E>(onEventHandler);
  }
  // Must be overriden, we handle the events as state.map, state.mapOrNull or switch case If sealed class used
  // If you want to transform stream of events you can process states in constructor separately
  // If transform is not required the events handled inside onEventHandler will be called from bloc's on handler automatically
  void onEventHandler(E event, Emitter emit);
}
