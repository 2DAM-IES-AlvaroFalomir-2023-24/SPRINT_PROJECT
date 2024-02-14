enum MaritalStatus{
  single, married, legalCohabitant, widower, divorced;

  static setMaritalByString(String gend){
    switch (gend){
      case "married":
        return married;
      case "legalCohabitant":
        return legalCohabitant;
      case "widower":
        return widower;
      case "divorced":
        return divorced;
      case "single": default:
        return single;
    }
  }
}