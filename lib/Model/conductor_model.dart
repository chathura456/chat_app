class ConductorModel {
  final String? busNo;
  final String? route;

  const ConductorModel({
    this.busNo,
    this.route,
  });

  Map<String, dynamic> toJason() =>
      {
        "BusNo": busNo,
        "Route": route,
      };
}