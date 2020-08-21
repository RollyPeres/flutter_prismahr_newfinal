class EventFormValidationException {
  List name;
  List location;
  List details;

  EventFormValidationException({
    this.name,
    this.location,
    this.details,
  });

  factory EventFormValidationException.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return EventFormValidationException(
      name: json['name'],
      location: json['location'],
      details: json['details'],
    );
  }
}
