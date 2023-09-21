import 'package:book_me/base/app_colors.dart';
import 'package:book_me/blocs/home_tab/hometab_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'МОЙ КАЛЕНДАРЬ',
          style: TextStyle(color: AppColors.baseFontColor, fontSize: 20),
        ),
        BlocBuilder<HometabBloc, HometabState>(
          buildWhen: (previous, current) {
            return current is NewMonthState || current is NewFootSelectorState
                ? true
                : false;
          },
          builder: (context, state) {
            var dt = BlocProvider.of<HometabBloc>(context).currentViewDay;
            final DateFormat formatter = DateFormat('MMMM', 'ru');
            final String month = formatter.format(dt);
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<HometabBloc>(context).add(OnTapBackMonth());
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.26,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.arrow_back,
                          color: AppColors.baseFontColor,
                        ),
                        Text(
                          BlocProvider.of<HometabBloc>(context).prevMonth ==
                                  null
                              ? ''
                              : formatter
                                  .format(BlocProvider.of<HometabBloc>(context)
                                      .prevMonth!)
                                  .toUpperCase(),
                     
                          style: TextStyle(color: AppColors.baseFontColor),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.48,
                  child: Center(
                    child: Text(
                      month.toUpperCase(),

                      style: TextStyle(
                          color: AppColors.baseFontColor, fontSize: 33),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    BlocProvider.of<HometabBloc>(context)
                        .add(OnTapForwardMonth());
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.26,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          BlocProvider.of<HometabBloc>(context).nextMonth ==
                                  null
                              ? ''
                              : formatter
                                  .format(BlocProvider.of<HometabBloc>(context)
                                      .nextMonth!)
                                  .toUpperCase(),
                          style: TextStyle(color: AppColors.baseFontColor),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: AppColors.baseFontColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        BlocBuilder<HometabBloc, HometabState>(
          buildWhen: (previous, current) {
            return current is NewSelectorState ? true : false;
          },
          builder: (context, state) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                    onTap: () {
                      BlocProvider.of<HometabBloc>(context)
                          .add(OnTapSelector(indexSelector: 0));
                    },
                    child: SelectorPeriod(
                      name: 'МЕСЯЦ',
                      isActiv: state.currentIndexSelector == 0 ? true : false,
                    )),
                GestureDetector(
                    onTap: () {
                      BlocProvider.of<HometabBloc>(context)
                          .add(OnTapSelector(indexSelector: 1));
                    },
                    child: SelectorPeriod(
                      name: 'НЕДЕЛЯ',
                      isActiv: state.currentIndexSelector == 1 ? true : false,
                    )),
                GestureDetector(
                    onTap: () {
                      BlocProvider.of<HometabBloc>(context)
                          .add(OnTapSelector(indexSelector: 2));
                    },
                    child: SelectorPeriod(
                      name: 'ДЕНЬ',
                      isActiv: state.currentIndexSelector == 2 ? true : false,
                    )),
              ],
            );
          },
        ),
        BlocBuilder<HometabBloc, HometabState>(
          builder: (context, state) {
            //String languageCode = Localizations.localeOf(context).languageCode;
            var dt = BlocProvider.of<HometabBloc>(context).currentViewDay;
            final DateFormat formatter = DateFormat('MMMM', 'ru');
            final String month = formatter.format(dt);

            return FootSelector(
              mainData:
                  '${BlocProvider.of<HometabBloc>(context).currentViewDay.day} $month',
            );
          },
        ),
        SizedBox(
            height: MediaQuery.of(context).size.height * 0.45,
            child: BodyDayWidget())
      ],
    );
  }
}

class SelectorPeriod extends StatelessWidget {
  String name;
  bool isActiv;
  SelectorPeriod({
    Key? key,
    required this.name,
    required this.isActiv,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isActiv
          ? MediaQuery.of(context).size.height * 0.1
          : MediaQuery.of(context).size.height * 0.09,
      width: MediaQuery.of(context).size.width * 0.312,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              //stops: [0.05, 0.5],
              colors: [
                Color.fromRGBO(67, 102, 122, 1),
                Color.fromRGBO(24, 172, 255, 0),
                Color.fromRGBO(46, 231, 153, 1)
              ]),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5), topRight: Radius.circular(5))),
      child: Padding(
        padding: const EdgeInsets.only(top: 0.7, left: 0.7, right: 0.7),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                color: isActiv
                    ? AppColors.activSelectorcolor
                    : AppColors.unActivSelectorcolor),
            child: Center(
              child: Text(
                name,
                style: TextStyle(color: AppColors.baseFontColor),
              ),
            )),
      ),
    );
  }
}

class FootSelector extends StatelessWidget {
  String mainData;
  FootSelector({
    Key? key,
    required this.mainData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.05,
      decoration: BoxDecoration(color: AppColors.activSelectorcolor),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              BlocProvider.of<HometabBloc>(context)
                  .add(onTapBackFootSelector());
            },
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.26,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.arrow_back,
                    color: AppColors.baseFontColor,
                  ),
                  Text(
                    'ПРЕД.',
            
                    style: TextStyle(color: AppColors.baseFontColor),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.48,
            child: Center(
              child: Text(
           
                mainData,
                style: TextStyle(color: AppColors.baseFontColor, fontSize: 20),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              BlocProvider.of<HometabBloc>(context)
                  .add(onTapForwardFootSelector());
            },
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.26,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'СЛЕД.',
                   
                    style: TextStyle(color: AppColors.baseFontColor),
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: AppColors.baseFontColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BodyDayWidget extends StatelessWidget {
  //Mokka
  List<Map<String, String>> meetingListDay = [
    {'10:00': 'Втреча с Андреем Михеевым'},
    {'11:00': ''},
    {'12:00': 'Втреча с Андреем Михеевым'},
    {'13:00': 'Втреча с Андреем Михеевым'},
    {'14:00': ''},
    {'16:00': 'Втреча с Андреем Михеевым'},
    {'17:00': 'Втреча с Андреем Михеевым'},
    {'18:00': 'Втреча с Андреем Михеевым'},
  ];
  //Mokka
  BodyDayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
            children: List.generate(meetingListDay.length, (index) {
          return Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.1,
              //color: Color.fromRGBO(179, 134, 134, 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(meetingListDay[index].keys.single,
                      style: TextStyle(
                        color: AppColors.baseFontColor,
                      )),
                  meetingListDay[index].values.single == ''
                      ? Row(
                          
                          children: [
                            Container(
                              height: 3,
                              width: MediaQuery.of(context).size.width * 0.3,
                              decoration: const BoxDecoration(
                                  color: Color.fromRGBO(63, 77, 94, 1)),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.03,
                              width: MediaQuery.of(context).size.width * 0.3,
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(21)),
                                color: Color.fromRGBO(68, 224, 150, 1),
                              ),
                              child: const Center(
                                  child: Text(
                                'ПРИГЛАСИТЬ',
                                style: TextStyle(fontSize: 10),
                              )),
                            )
                          ],
                        )
                      : Row(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.2,
                              width: 6,
                              color: const Color.fromRGBO(81, 116, 183, 1),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              meetingListDay[index].values.single,
                              style: TextStyle(color: AppColors.baseFontColor),
                            )
                          ],
                        )
                ],
              ),
            ),
          );
        }))
      ],
    );
  }
}
