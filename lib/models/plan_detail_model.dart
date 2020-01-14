class PlanDetailItem {
  String image;
  int bhk;
  String sqft;
  int storey;

  PlanDetailItem({
    this.image,
    this.bhk,
    this.storey,
    this.sqft,
  });
  factory PlanDetailItem.fromJson(Map<dynamic, dynamic> parsedJson) {
    return PlanDetailItem(
        image: parsedJson['image'],
        bhk: parsedJson['bhk'],
        storey: parsedJson['storey'],
        sqft: parsedJson['sqft']);
  }
}
