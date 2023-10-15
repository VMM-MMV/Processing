PVector v = new PVector(1,5);

// Using static method for multiplication
PVector u = PVector.mult(v, 2);

// Using static method for subtraction
PVector w = PVector.sub(v, u);

// Using non-static method for division
w.div(3);