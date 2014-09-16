//This file defines the implementation for the 
//Hit class
#include <string>
#include "hit.h"

//Default constructor
Hit::Hit(){
  ip = link = date = "";
}

Hit::Hit(std::string i, std::string l, std::string d) {
  
  ip = i;
  link = l;
  date = d;
}

std::string Hit::get_ip() {
  return ip;
}

std::string Hit::get_link(){
  return link;
}

std::string Hit::get_date(){
  return date;
}

void Hit::set_ip(std::string i){
  ip = i;
}

void Hit::set_link(std::string l){
  link = l;
}

void Hit::set_date(std::string d){
  date = d;
}

//Returns true if the date is correctly formatted and is a valid date, false otherwise
bool valid_date(std::string date) {
  int m1, m2, d1, d2, y1, y2, y3, y4;
  int m, d, y;
  int c = std::sscanf(date.c_str(), "%1d%1d/%1d%1d/%1d%1d%1d%1d", &m1, &m2, &d1, &d2, &y1, &y2, &y3, &y4);
  int r = std::sscanf(date.c_str(), "%2d/%2d/%4d", &m, &d, &y);
  if (c < 8 || r < 3) {
    return false;
  }

  int max_d = 0;
  if(m <= 12 && m >= 1){
    if(m == 4 || m == 6 || m == 9 || m == 11){
      max_d = 30;
    }
    else if(m == 2){
      if(y % 4 == 0){
	max_d = 29;
      }
      else{
	max_d = 28;
      }
    }
    else {
      max_d = 31;
    }
    
    if(d > 0 && d <= max_d){
      return true;
    }
  }
  return false;
}

//Returns -1 if the first date is before the second, 0 if they are the same, and 1 if the first date is after the second.
int date_compare(std::string date1, std::string date2) {
  int m1,m2,d1,d2,y1,y2;
  std::sscanf(date1.c_str(), "%2d/%2d/%4d", &m1, &d1, &y1);
  std::sscanf(date2.c_str(), "%2d/%2d/%4d", &m2, &d2, &y2);
  if(y1 < y2){
    return (-1);
  }
  else if (y1 > y2) {
    return 1;
  }
  else {
    if(m1 < m2) {
      return (-1);
    }
    else if (m1 > m2) {
      return 1;
    }
    else {
      if(d1 < d2){
	return (-1);
      }
      else if (d1 > d2){
	return 1;
      }
      else {
	return 0;
      }
    }
  }
  return 0;
}

bool Hit::is_valid() {

  if (valid_date(date)) {
    return true;
  }
  else {
    return false;
  }
}
