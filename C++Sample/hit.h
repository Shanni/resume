//This header file defines the class used to store
//a record of an individual hit.
#include <string>

#ifndef HIT_H
#define HIT_H
class Hit {
 private:
  std::string ip;
  std::string link;
  std::string date;
 public:
  Hit();
  Hit(std::string, std::string, std::string);
  std::string get_ip();
  std::string get_link();
  std::string get_date();
  void set_ip(std::string);
  void set_link(std::string);
  void set_date(std::string);
  bool is_valid();
};
#endif
