part of 'bag_page_cubit.dart';

abstract class BagPageState {
  const BagPageState();
}

class BagPageInitial extends BagPageState {}

class BagPageLoading extends BagPageState {}

class BagPageLoaded extends BagPageState {
  final BagModel model;

  BagPageLoaded({required this.model}) : assert(model != null);
}

class BagPageError extends BagPageState {}
