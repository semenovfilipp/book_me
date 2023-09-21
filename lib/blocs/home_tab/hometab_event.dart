// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'hometab_bloc.dart';

@immutable
sealed class HometabEvent {}

class OnTapForwardMonth extends HometabEvent{}
class OnTapBackMonth extends HometabEvent{}

class OnTapSelector extends HometabEvent {
  int indexSelector;
  OnTapSelector({
    required this.indexSelector,
  });
}

class onTapForwardFootSelector extends HometabEvent{}

class onTapBackFootSelector extends HometabEvent{}