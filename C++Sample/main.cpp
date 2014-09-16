//Shan Liu
//Main file for the hit recording program.
#include <iostream>
#include <iomanip>
#include <fstream>
#include <string>
#include "hit.cpp"
#include "metric.cpp"

void range_info(Hit *hits, int c);
void all_info(Metric *metrics, int h);


using namespace std;

int main(){
  Hit *hits = new Hit[500];
  Metric *metrics = new Metric[500];
  int count = 0;
  int hosts = 0;
  string file;
  ifstream hit_file;
  string ip;
  string link;
  string date;
  int action = 0;

  
  cout << "Please enter the name of the text file you would like to read in:" << endl;
  cin >> file;
  
  hit_file.open(file.c_str());
  
  while(hit_file.good()){
    hit_file >> ip >> link >> date;
    if(hit_file.eof()){
      break;
    }
    if(ip.size() < 1 || link.size() < 1 || date.size() < 1) {
      cout << "Error reading in line...will be ignored" << endl;
    }
    else {
      hits[count].set_ip(ip);
      hits[count].set_link(link);
      hits[count].set_date(date);
      
      if(!hits[count].is_valid()) {
	cout << "Invalid input on line, ignoring hit information" << endl;
      }
      else {
	count++;
	int i =0;
	int flag = 1;
	for(i; i < hosts; i++){
	  if(metrics[i].get_link() == link){
	    metrics[i].add_visit(hits[count-1]);
	    flag = 0;
	  }
	}
	if(flag){
	  metrics[hosts].set_link(link);
	  hosts++;
	}
      }
    }
  }
  cout << "Successfully read " << count << " hits to be used for calculations."<< endl;

  while(true){
    cout << endl << "Please enter a number for your desired action:" << endl
	 << "1. Link information in date range." << endl
	 << "2. Information about all links." << endl
	 << "3. Exit the program." << endl;

    cin >> action;

    if(action == 1) {
      range_info(hits, count);
    }
    else if (action == 2) {
      all_info(metrics, hosts);
    }
    else if (action == 3) {
      break;
    }
  }
}


void range_info(Hit *hits, int c) {
  string link;
  string sd;
  string ed;
  
  
  cout << "Enter a link name: ";
  cin >> link;
  cout << "Enter a start date (mm/dd/yyy): ";
  cin >> sd;
  cout << "Enter an end date (mm/dd/yyyy): ";
  cin >> ed;
  
  if(!valid_date(sd) || !valid_date(ed) || (date_compare(sd,ed) > 0)){
    cout << "Bad date(s) provided." << endl;
  }
  else {
    int i = 0;
    int total = 0;
    int unique = 0;
    string visitors[500];

    for(i; i < c; i++){
      if(hits[i].get_link() == link) {
	if(date_compare(sd, hits[i].get_date()) < 1){
	  if(date_compare(hits[i].get_date(), ed) < 1){
	    total++;
	    int flag = 0;
	    int j = 0;
	    for(j; j < unique; j++){
	      if(visitors[j] == hits[i].get_ip()){
		flag = 1;
	      }
	    }
	    if(!flag){
	      visitors[unique] = hits[i].get_ip();
	      unique++;
	    }
	  }
	}
      }
    }

    cout << "Link:     " << link << endl
	 << "Total:    " << total << endl
	 << "Unique:   " << unique << endl
	 << "Return:   " << (total-unique) << endl;
  }
}

void all_info(Metric *metrics, int h) {
  int count = 0;
  int num_done = 0;
  cout << "          Link Name            Unique Return Total" << endl
       << "------------------------------ ------ ------ -----" << endl;

  while(num_done < h){
    int i = 0;
    for(i; i < h; i++){
      if(metrics[i].get_unique() == count){
	cout << left << setw(30) << metrics[i].get_link() 
	     << right << setw(7) << metrics[i].get_unique() 
	     << setw(7) << metrics[i].get_return()
	     << setw(5) << metrics[i].get_total()
	     << endl;
	num_done++;
      }
    }
    count++;
  }
}
