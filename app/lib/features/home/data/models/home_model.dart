import 'package:booking_app_mvp_test/features/home/domain/entities/book.dart';
import 'package:booking_app_mvp_test/features/home/domain/entities/massage.dart';

import '../../domain/entities/home.dart';

class HomeModel extends Home {
  const HomeModel(super.orders);


  factory HomeModel.fromJson(Map<String, dynamic> json) {
    var list = <BookModel>[];
    for(var book in json['bookings']){
      list.add(BookModel.fromJson(book));
    }
    return HomeModel(list);
  }

  Map<String, dynamic> toJson() {
    return {};
  }
}

class BookModel extends Book{
  const BookModel({required super.id, required super.booking_time, required super.massage_id});
  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'],
      booking_time: json['booking_time'],
      massage_id: MassageModel.fromJson(json['massage_id'])
    );
  }
}
class MassageModel extends Massage {
  const MassageModel({
    required super.id,
    required super.name,
    required super.price,
  });

  factory MassageModel.fromJson(Map<String, dynamic> json) {
    return MassageModel(
      id: json['id'],
      name: json['name'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "name": name, "price": price};
  }
}
