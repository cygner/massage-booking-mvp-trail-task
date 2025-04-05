import 'package:booking_app_mvp_test/core/navigation/goto.dart';
import 'package:booking_app_mvp_test/core/storage/session/sesssion.dart';
import 'package:booking_app_mvp_test/core/strings/strings.dart';
import 'package:booking_app_mvp_test/core/validators/validators.dart';
import 'package:booking_app_mvp_test/features/home/domain/entities/massage.dart';
import 'package:booking_app_mvp_test/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'date_time_picker.dart';

class CreateBookingDialog extends StatefulWidget {
  const CreateBookingDialog({super.key});

  @override
  State<CreateBookingDialog> createState() => _CreateBookingDialogState();
}

class _CreateBookingDialogState extends State<CreateBookingDialog> {
  var formKey = GlobalKey<FormState>();

  var autoValidateMode = AutovalidateMode.disabled;

  var dateTimeController = TextEditingController();

  DateTime selectedDateTime = DateTime.now();

  var massages = <Massage>[];

  Massage? selectedMassage;


  @override
  void initState() {
    context.read<HomeBloc>().add(HomeGetAllMassageTypeEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc,HomeState>(listener: (BuildContext context, HomeState state) {
      if(state is HomeAllMassageTypeLoaded){
        setState(() {
          massages.clear();
          massages.addAll(state.massages);
        });
      }
    },child: Container(
      width: double.infinity,
      padding: EdgeInsets.all(15),
      child: Form(
        key: formKey,
        autovalidateMode: autoValidateMode,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    context.strings.create_booking,
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.close, color: Colors.red),
                ),
              ],
            ),
            SizedBox(height: 30),
            DropdownButtonFormField<Massage>(
              decoration: InputDecoration(
                labelText: context.strings.massage_type,
                border: OutlineInputBorder(),
              ),
              value: null,
              validator: (s) {
                return Validators.isSelect(
                  s?.name,
                  context.strings.massage_type.toLowerCase(),
                );
              },
              items:
              massages.map((massage) {
                return DropdownMenuItem<Massage>(
                  value: massage,
                  child: Text(massage.name),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedMassage = value;
                });
              },
            ),
            SizedBox(height: 15),
            DateTimePicker(
              initialDate: DateTime.now(),
              onDateTimeSelected: (DateTime dateTime) {
                setState(() {
                  selectedDateTime = dateTime;
                });
              },
            ),
            SizedBox(height: 15),

            ElevatedButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  var email = await SessionManager.getUserEmail();
                  if (context.mounted) {
                    context.pop(
                      arguments: HomeBookEvent(
                        massage_id: selectedMassage?.id??0,
                        email: email,
                        booking_time:
                        selectedDateTime.toUtc().toIso8601String(),
                      ),
                    );
                  }
                } else {
                  setState(() {
                    autoValidateMode = AutovalidateMode.always;
                  });
                }
              },
              child: Text("Book"),
            ),
          ],
        ),
      ),
    ),);
  }
}
