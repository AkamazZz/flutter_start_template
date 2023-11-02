import 'package:app_template/src/core/base/base_bloc/bloc/base_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef BaseBlocWidgetBuilder<B, S> = Widget Function(
  BuildContext context,
  S state,
  B bloc,
);
typedef BaseBlocWidgetListener<S> = void Function(
  BuildContext context,
  S state,
);
typedef BlocBuilderCondition<S> = bool Function(S previous, S current);
typedef BlocListenerCondition<S> = bool Function(S previous, S current);

// Base bloc widget to reduce boilerplate 
class BaseBlocWidget<B extends BaseBloc<E, S>, E, S> extends StatelessWidget {
  const BaseBlocWidget(
      {super.key,
      required this.bloc,
      required this.startEvent,
      required this.builder,
      this.listener,
      this.buildWhen,
      this.listenWhen});

  final B bloc;
  final E startEvent;
  final BaseBlocWidgetBuilder<B, S> builder;
  final BaseBlocWidgetListener<S>? listener;
  final BlocBuilderCondition<S>? buildWhen;
  final BlocListenerCondition<S>? listenWhen;

  @override
  Widget build(BuildContext context) {
    // We provide the bloc itself into widget tree where the startEvent is produced after provided into widget tree
    return BlocProvider(
      create: (_) => bloc..add(startEvent),
      child: BlocConsumer<B, S>(
              // Instead of calling the bloc from context, we can use it directly from builder
          builder: (context, state) =>
              builder(context, state, context.read<B>()),
          listener: listener ?? (_, __) {},
          buildWhen: buildWhen,
          listenWhen: (previous, current) =>
              listenWhen?.call(previous, current) ?? true),
    );
  }
}
