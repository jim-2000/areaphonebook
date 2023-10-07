// ignore_for_file: public_member_api_docs, sort_constructors_first

List<TrainTimeModle> dhakatoNarayangonj = [
  TrainTimeModle(id: "1", trainNumber: "D", locations: [
    Location(id: "1", name: "Dhaka", times: [
      Time(id: "1", trainId: "1", locationId: "1", time: "5.30"),
    ]),
    Location(id: "1", name: "Gandaria", times: [
      Time(id: "2", trainId: "1", locationId: "1", time: "5.40"),
    ])
  ])
];

List<TrainTimeModle> narayangonjtonDhaka = [];

class TrainTimeModle {
  String id; //1
  String trainNumber; //22
  List<Location> locations; // list of locations
  TrainTimeModle({
    required this.id,
    required this.trainNumber,
    required this.locations,
  });
}

class Location {
  String id; // 1
  String name; // dhaka
  List<Time> times;
  Location({
    required this.id,
    required this.name,
    required this.times,
  });
}

class Time {
  String id; //1
  String locationId; //1 == dhaka
  String trainId; // 22
  String time; // 5.30
  Time({
    required this.id,
    required this.trainId,
    required this.locationId,
    required this.time,
  });
}
