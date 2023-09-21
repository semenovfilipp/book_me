// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'hometab_bloc.dart';

@immutable
sealed class HometabState {
  get currentIndex => 0;

  get currentIndexSelector => 0;
}

final class HometabInitial extends HometabState {
  
}

class NewMonthState extends HometabState {
  
  int currentIndex;
  NewMonthState({
    required this.currentIndex,
  });
}

class NewSelectorState extends HometabState {
  int currentIndexSelector;
  NewSelectorState({
    required this.currentIndexSelector,
  });
}

class NewFootSelectorState extends HometabState {
  DateTime currentDt;
  NewFootSelectorState({
    required this.currentDt,
  });
}
