
// a basic noise-based moving particle
class Particle {
  // unique id, (previous) position, speed
  float id, x, y, xp, yp, s, d;
  float midx, midy;
  color col; // color

  Particle(float id) {
    this.id = id;
    s = random(2, 6); // speed
  }

  public float getMidx() {
    return midx;
  }

  public float getMidy() {
    return midy;
  }

  void updateAndDisplay() {
    // let it flow, end with a new x and y position
    id += 0.01;
    //    d = (noise(id, x/globalY, y/globalY)-0.5)*globalX;
    x = random(x-80, x+80);
    y = random(y-80, y+80);
    //    x += cos(radians(d))*s;
    //    y += sin(radians(d))*s;

    // constrain to boundaries
    if (x<-10) x=xp=kinectWidth+10;
    if (x>kinectWidth+10) x=xp=-10;
    if (y<-10) y=yp=kinectHeight+10;
    if (y>kinectHeight+10) y=yp=-10;

    // if there is a polygon (more than 0 points)
    if (poly.npoints > 0) {
      // if this particle is outside the polygon
      if (!poly.contains(x, y)) {
        // while it is outside the polygon
        while (!poly.contains (x, y)) {
          // randomize x and y
          x = random(kinectWidth);
          y = random(kinectHeight);
        }
        // set previous x and y, to this x and y
        xp=x;
        yp=y;
      }
    }

    // individual particle color
    stroke(col);
    // line from previous to current position
    float cxp, cyp, dx, dy, con1, con2;
    con1 = 200;
    con2 = 200;
    cxp = random(xp-con1, xp+con1);
    cyp = random(yp-con2, yp+con2);
    dx = random(xp-con1, xp+con1);
    dy = random(yp-con2, yp+con2);
    //    line(xp, yp, x, y);

    if (dy < 0) dy = height;
    if (dy > height) dy = 0;
    if (dx < 0) dx = width;
    if (dx > width) dx = 0;
    curve(cxp, cyp, xp, yp, x, y, dx, dy);

    midx = (cxp+dx)/2;
    midy = (cyp+dy)/2;
    
    // set previous to current position
    xp=x;
    yp=y;
  }

  //  public void AdjustBound() {
  //    //error handling
  //    if (dy < 0) dy = height;
  //    if (dy > height) dy = 0;
  //    if (dx < 0) dx = width;
  //    if (dx > width) dx = 0;
  //  }
}

