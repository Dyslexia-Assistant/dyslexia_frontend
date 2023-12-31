
/*
* track posisi overlay widget seperti pointer, bot button
* */
class OverlayStatus {
  double xPosition = 0;
  double yPosition = 0;
  bool isDragged = false;

  void setDragStatus(bool status) {
    isDragged = status;
  }
  void setPosition(double newX, double newY){
    xPosition = newX;
    yPosition = newY;
  }

  // Method to check the drag status
  bool checkDragStatus() {
    return isDragged;
  }
}

