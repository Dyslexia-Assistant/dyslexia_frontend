class TextScreenUtil{
  static double convertPhysicalToLogicalPixel(double physicalPixel, double pixelRatio){
    return physicalPixel/pixelRatio;
  }
}