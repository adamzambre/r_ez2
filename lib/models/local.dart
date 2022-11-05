class Local {

  final String Name;
  final String City;
  final String Country;
  final String State;
  final String age;
  final String PPUrl;

  Local({required this.Name,required this.City,required this.Country,required this.State,required this.age,required this.PPUrl});

  String getName(){
    return Name;
  }

  String getCty(){
    return City;
  }

  String getCountry(){
    return Country;
  }

  String getState(){
    return State;
  }

  String getage(){
    return age;
  }

  String getPPUrl(){
    return PPUrl;
  }
}