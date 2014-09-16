//This header file is for the overall
//tracking of specific domains
#include <string>
#include "hit.h"

#ifndef METRIC_H
#define METRIC_H
class Metric {
 private:
  std::string link;
  int total;
  int unique;
  std::string visitors[500];
 public:
  Metric();
  void add_visit(Hit);
  void set_link(std::string);
  int get_total();
  int get_unique();
  int get_return();
  std::string get_link();
};
#endif
