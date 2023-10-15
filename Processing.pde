void limit(float max) {
    if (mag() > max) {
      normalize();
      mult(max);
    }
  }