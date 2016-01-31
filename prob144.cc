#include <vector>
#include <math.h>
#include <cmath>
#include <iostream>
#include <assert.h>

typedef double coord_t; 

struct Point {
  coord_t x, y; 
};

coord_t Distance2(const Point& p1, const Point& p2) {
  auto dx = p1.x - p2.x;
  auto dy = p1.y - p2.y;
  return dx*dx+dy*dy;
}

struct Ellipse {
  coord_t X, Y, C;
};


std::ostream &operator<<(std::ostream &out, const Ellipse &l) {
  out << "{" << l.X << "x^2 + " << l.Y << "y^2 = " << l.C << "}";
  return out;
}

struct Line {
  coord_t A, B, C;
};

Line LineFromPoints(const Point& a, const Point& b) {
  if(b.y == a.y) {
    return { 0, 1, a.y };
  }
  auto A = 1.0; 
  auto B = (a.x - b.x) / (b.y - a.y);
  auto C = A*a.x + B*a.y;
  
  if(b.x < a.x) { // Keeps direction clear
    return {-A, -B, -C}; 
  }
  return {A, B, C}; 
}
std::ostream &operator<<(std::ostream &out, const Line &l) {
  out << "{" << l.A << "x + " << l.B << "y = " << l.C << "} ";
  if(l.B)
    out << "(" << "y = " << (-l.A/l.B) << "x + " << (l.C/l.B) << ")"; 
  return out;
}

std::ostream &operator<<(std::ostream &out, const Point &l) {
  out << "{" << l.x << ", " << l.y << "}";
  return out;
}

coord_t Slope(const Point& p) {
  return -4*p.x / p.y;
}

std::vector<coord_t> QuadFormula(const coord_t& a, const coord_t& b, const coord_t& c) {
  if(a == 0)
    return {};
  
  auto sr = b*b - 4*a*c;
  if(sr < 0)
    return {};

  sr = sqrt(sr);
  return {
    (-b + sr) / a / 2,
    (-b - sr) / a / 2}; 
}

Point Intersection(const Line& l, const Ellipse& e) {
  bool movingRight = l.A > 0; 
  // D = A*x + B*y
  //By = A*x - D
  // y = A*x/B - D/B
  // y = x*m - b
  // C = s*x*x + t*y*y
  // C = sx*x + t*(mx + b)^2
  // C = sx^2 + t*m^2x^2 + t*2mx * b + t*b^2
  // C = (s+tmm)x^2 + 2mxt * b + tb^2
  // 0 = (s+tmm)x^2 + 2mxt * b + tb^2 - C
  coord_t x = 0;
  
  if(l.B == 0) {
    x = l.C / l.A;    
  } else {  
    auto s = e.X;
    auto t = e.Y;
    auto m = -l.A / l.B; 
    auto b = l.C / l.B; 

    auto a  = s+t*m*m;
    auto bp = 2*m*t*b;
    auto c  = t*b*b - e.C;

    auto answers = QuadFormula(a, bp, c);
    bool pickFirst =
      (answers[0] < answers[1]) ^ movingRight;
    
    x = pickFirst ? answers[0] : answers[1];
  }
  
  if(l.B == 0) {
    auto y = 0.;
    assert(false);
    return {x, movingRight ? y : -y}; 
  }
  auto y = (l.C/l.B) - (l.A/l.B)*x;
 
  return {x, y};
}

double Angle(const Line& l1, const Line& l2) {
  double m1 = -l1.A/l1.B;
  double m2 = -l2.A/l2.B;
  return atan2((m1 - m2), (1 + m1*m2)); 
}

coord_t TangentSlope(const Ellipse& e, const Point& p) {
  return -e.X * p.x / (e.Y * p.y); 
}

Line Bounce(const Line& ray, const Line& wall, const Point& p) {

  float s = p.x * p.y < 0 ? -1 : 1;
  
  auto v1 = s*ray.B;
  auto v2 = s*-ray.A;
  auto vl = sqrt(v1*v1 + v2*v2);
  v1 /= vl; v2 /= vl;

  auto n1 = -wall.B; 
  auto n2 = -wall.A;
  auto nl = sqrt(n1*n1 + n2*n2);
  n1 = n1 / nl;  n2 = n2 / nl;
  auto dp = v1*n1 + v2*n2; 

  auto r1 = v1 - 2*dp*n1;
  auto r2 = v2 - 2*dp*n2;
  
  float sign = r2 > 0 != r1 > 0 ? -1. : 1.; 
  auto A = sign*r2;
  auto B = sign*-r1;
  auto C = A*p.x + B*p.y;  
  return {A, B, C}; 
}

int prob144() {
  Ellipse e = {4, 1, 100};
  Point p1 = {0, 10.1};
  Point p2 = {1.4, -9.6};
  Line  ray =  LineFromPoints(p1,p2);
  Point intersect = Intersection(ray, e);
  int rtn = 0;
  while(intersect.y < 0 || intersect.x < -0.01 || intersect.x > 0.01 ) {
    auto m = TangentSlope(e, intersect);
    Line wall = { m, 1, 0 };
    ray = Bounce(ray, wall, intersect);

    // This part is somewhat hacky;
    // I coudln't find a super nice way to make sure the ray returned
    // was going in the right direction, so we just find the intersection
    // for the given one, and the reverse ray of that. We go with whichever
    // ray didn't give us the intersection we were just at. 
    Line rayRev = { -ray.A, -ray.B, -ray.C };
    rtn++;
    auto i1 = Intersection(ray, e);
    auto i2 = Intersection(rayRev, e);
    if(Distance2(i1, intersect) >
       Distance2(i2, intersect)) {
      intersect = i1; 
    } else {
      ray = rayRev;
      intersect = i2; 
    }
        
    if(rtn > 1000000) break;
  }

  return rtn;
    
}

int main() {
  std::cout << prob144() << std::endl;
  return 0;
}
