class PassengerModel {
  final String? package;
  final String? points;

  const PassengerModel({
    this.package,
    this.points,
  });

  Map<String, dynamic> toJason() =>
      {
        "Package": package,
        "Points": points,
      };

  factory PassengerModel.fromMap(json){
    return PassengerModel(
      package: json['Package'],
      points: json['Points'],
    );
  }
}