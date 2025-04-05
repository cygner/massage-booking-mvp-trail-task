import 'package:booking_app_mvp_test/core/dialogs/show.dart';
import 'package:booking_app_mvp_test/core/navigation/goto.dart';
import 'package:booking_app_mvp_test/core/navigation/routes.dart';
import 'package:booking_app_mvp_test/core/storage/session/sesssion.dart';
import 'package:booking_app_mvp_test/core/strings/strings.dart';
import 'package:booking_app_mvp_test/features/home/domain/entities/book.dart';
import 'package:booking_app_mvp_test/features/home/presentation/bloc/home_bloc.dart';
import 'package:booking_app_mvp_test/features/home/presentation/pages/dialogs/create_booking_dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Book> orders = [];

  String userId = "";

  @override
  void initState() {
    _getHistory();
    super.initState();
    FirebaseMessaging.instance.requestPermission().then((value) {
      if (value.authorizationStatus == AuthorizationStatus.authorized) {
        setupFlutterNotifications();
        FirebaseMessaging.onMessage.listen((m) {
          print(m);
          showFlutterNotification(m);
        });
      }
    });

    FirebaseMessaging.instance.getToken().then((t) {
      print(t);
    });
  }

  Future<void> _getHistory() async {
    var id = await SessionManager.getUserID();
    setState(() {
      userId = id;
    });
    if (context.mounted) {
      context.read<HomeBloc>().add(HomeGetHistoryEvent(id));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (BuildContext context, HomeState state) {
        if (state is HomeLoaded) {
          setState(() {
            orders.clear();
            orders.addAll(state.home.orders);
          });
        } else if (state is HomeBooked) {
          context.showErrorSnakeBar("Booked!");
          context.read<HomeBloc>().add(HomeGetHistoryEvent(userId));
        }else if(state is HomeError){
          context.showErrorSnakeBar(state.message);
        }
      },
      child: FutureBuilder<Map>(
        future: SessionManager.getUserData(),
        builder: (
          BuildContext context,
          AsyncSnapshot<Map<dynamic, dynamic>> snapshot,
        ) {
          if (snapshot.hasData && snapshot.data != null) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  context.strings.welcome_user(snapshot.data!['name']),
                ),
                actions: [
                  IconButton(
                    onPressed: () async {
                      await SessionManager.clear();
                      if(context.mounted){
                        context.pushAndRemoveUntil(Routes.login);

                      }
                    },
                    icon: Icon(Icons.logout_outlined),
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.strings.booking_history,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (BuildContext context, int index) {
                          var date = DateTime.parse(orders[index].booking_time);
                          return ListTile(
                            leading: CircleAvatar(
                              child: Text("#${orders[index].id}"),
                            ),
                            title: Text(
                              "${orders[index].massage_id.name} (₱${orders[index].massage_id.price})",
                            ),
                            subtitle: Text(
                              DateFormat("dd-MM-yyyy HH:mm").format(date),
                            ),
                          );
                        },
                        itemCount: orders.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () async {
                  var bookEvent = await context
                      .showBottomSheetDialog<HomeBookEvent>(
                        CreateBookingDialog(),
                      );
                  if (bookEvent != null && context.mounted) {
                    context.read<HomeBloc>().add(bookEvent);
                  }
                },
                label: Text(context.strings.book),
                icon: const Icon(Icons.add),
              ),
            );
          } else {
            return Scaffold();
          }
        },
      ),
    );
  }
}
