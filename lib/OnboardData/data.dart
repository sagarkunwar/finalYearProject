

class SliderModel{
  String imagePath;
  String title;
  String decs;

  SliderModel({this.imagePath, this.title, this.decs});

  void setImageAssetPath(String getImagepath){
    imagePath = getImagepath;
  }

  void setTitle(String getTitle){
    title=getTitle;
  }

  void setDecs(String getDesc){
    decs= getDesc;
  }

  String getImageAssetPath(){
    return imagePath;
  }
  String getTitle(){
    return title;
  }

  String getDesc(){
    return decs;
  }
}

List<SliderModel> getSlides(){
  List<SliderModel> slides = new List<SliderModel>();
  SliderModel sliderModel= new SliderModel();
  
  //1
  sliderModel.setImageAssetPath("assets/images/Onboard1.png",);
  sliderModel.setTitle("Search");
  sliderModel.setDecs("Hello YOU in Tokari");
  slides.add(sliderModel);

  sliderModel= new SliderModel();
  //2
  sliderModel.setImageAssetPath("assets/images/Onboard2.png");
  sliderModel.setTitle("Derictly from Fram");
  sliderModel.setDecs("Hello YOU in Tokari");
  slides.add(sliderModel);

  sliderModel= new SliderModel();
  //3
  sliderModel.setImageAssetPath("assets/images/Onboard3.png");
  sliderModel.setTitle("Search");
  sliderModel.setDecs("Hello YOU in Tokari");
  slides.add(sliderModel);

  sliderModel= new SliderModel();

  return slides;
}