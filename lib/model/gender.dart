enum Gender{
  male, female, other, notSpecified;
  static setGenderByString(String gend){
    switch (gend){
      case "male":
        return male;
      case "female":
        return female;
      case "other":
        return other;
      default:
        return notSpecified;
    }
  }
}