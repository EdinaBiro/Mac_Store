class User{
  final String id;
  final String fullName;
  final String email;
  final String state;
  final String city;
  final String locality;
  final String password;

  User({required this.id, required this.fullName, required this.email, required this.state, required this.city, required this.locality, required this.password});

  Map<String, dynamic> toMap(){
    return <String,dynamic>{
      "id": id,
      "fullName": fullName,
      "email": email, 
      "state": state,
      "city": city,
      "locality": locality,
      "password": password
    };
  }
}