enum Language{
  esES, enUS;

  static setLanguageByString(String lang){
    switch(lang){
      case "en_US":
        return enUS;
      case "es_ES":default:
        return esES;
    }
  }

  String get name{
    switch(this){
      case enUS:
        return "en_US";
      case esES:
        return "es_ES";
    }
  }

}