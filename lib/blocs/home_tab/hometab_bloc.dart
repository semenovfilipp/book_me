import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'hometab_event.dart';
part 'hometab_state.dart';

typedef ReadData = ({int currentIndex, int currentIndexSelector});

class HometabBloc extends Bloc<HometabEvent, HometabState> {
  int currentIndexMonth = 0;
  late int currentIndexSelector;

  DateTime currentViewDay = DateTime.now();
  DateTime? prevMonth;
  DateTime? nextMonth;

  HometabBloc() : super(HometabInitial()) {
    readSelect().then((value) {
      currentIndexMonth = value.currentIndex;
      currentIndexSelector = value.currentIndexSelector;

      prevMonth = DateTime(
          currentViewDay.year, currentViewDay.month - 1, currentViewDay.day);
      nextMonth = DateTime(
          currentViewDay.year, currentViewDay.month + 1, currentViewDay.day);

      emit(NewMonthState(currentIndex: currentIndexMonth));
      emit(NewSelectorState(currentIndexSelector: currentIndexSelector));
    });
    on<HometabEvent>((event, emit) async {});
    on<OnTapForwardMonth>((event, emit) {
      currentViewDay = DateTime(
          currentViewDay.year, currentViewDay.month + 1, currentViewDay.day);
      nextMonth = DateTime(
          currentViewDay.year, currentViewDay.month + 1, currentViewDay.day);
      prevMonth = DateTime(
          currentViewDay.year, currentViewDay.month - 1, currentViewDay.day);
      emit(NewMonthState(currentIndex: currentIndexMonth));

      saveSelect(currentIndexMonth, currentIndexSelector);
    });
    on<OnTapBackMonth>((event, emit) {
      currentViewDay = DateTime(
          currentViewDay.year, currentViewDay.month - 1, currentViewDay.day);
      prevMonth = DateTime(
          currentViewDay.year, currentViewDay.month - 1, currentViewDay.day);
      nextMonth = DateTime(
          currentViewDay.year, currentViewDay.month + 1, currentViewDay.day);

      emit(NewMonthState(currentIndex: currentIndexMonth));
      saveSelect(currentIndexMonth, currentIndexSelector);
    });
    on<OnTapSelector>((event, emit) {
      currentIndexSelector = event.indexSelector;
      emit(NewSelectorState(currentIndexSelector: event.indexSelector));
      saveSelect(currentIndexMonth, currentIndexSelector);
    });
    on<onTapForwardFootSelector>((event, emit) {
      currentViewDay = currentViewDay.add(const Duration(days: 1));
      prevMonth = DateTime(
          currentViewDay.year, currentViewDay.month - 1, currentViewDay.day);
      nextMonth = DateTime(
          currentViewDay.year, currentViewDay.month + 1, currentViewDay.day);

      emit(NewFootSelectorState(currentDt: currentViewDay));
    });
    on<onTapBackFootSelector>((event, emit) {
      currentViewDay = currentViewDay.subtract(const Duration(days: 1));
      prevMonth = DateTime(
          currentViewDay.year, currentViewDay.month - 1, currentViewDay.day);
      nextMonth = DateTime(
          currentViewDay.year, currentViewDay.month + 1, currentViewDay.day);

      emit(NewFootSelectorState(currentDt: currentViewDay));
    });
  }

  saveSelect(int currentIndex, int currentIndexSelector) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('currentIndex', currentIndex);
    await prefs.setInt('currentIndexSelector', currentIndexSelector);
  }

  Future<ReadData> readSelect() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final int? currentIndex = prefs.getInt('currentIndex');
    final int? currentIndexSelector = prefs.getInt('currentIndexSelector');

    return (
      currentIndex: currentIndex ?? 0,
      currentIndexSelector: currentIndexSelector ?? 2
    );
  }
}
