//Implementation for metric.h
#include <string>
#include "hit.h"
#include "metric.h"


Metric::Metric(){
  link = "";
  total = 1;
  unique = 0;
}

void Metric::add_visit(Hit h){
  int i = 0;
  for(i; i < unique; i++){
    if(h.get_ip() == visitors[i]){
      total++;
      return;
    }
  }
  visitors[unique] = h.get_ip();
  unique++;
  total++;
}

void Metric::set_link(std::string s){
  link = s;
}

int Metric::get_total(){
  return total;
}

int Metric::get_unique(){
  return unique;
}

int Metric::get_return(){
  return total - unique;
}

std::string Metric::get_link(){
  return link;
}

