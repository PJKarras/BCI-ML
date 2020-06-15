/*  Author: Peter Karras
    Small file to extract the max and min values from a list of csv files
    
*/
#include <iostream>
#include <time.h>
#include <string>
#include <vector>
#include <fstream>
#include <utility> // std::pair
#include <stdexcept> // std::runtime_error
#include <sstream> // std::stringstream
#include <Windows.h> // Sorry



std::pair<double,double> get_min_max_csv(std::string filename, double minIN, double maxIN)
{
    // Pair to be returned
    std::pair<double,double> min_max(minIN, maxIN);

    // Create an input filestream
    std::ifstream myFile(filename);

    // Make sure the file is open
    if(!myFile.is_open()) throw std::runtime_error("Could not open file");

    // Helper vars
    double value;
    std::string line;

    if(myFile.good())
    {   
        // Extract the first line in the file, the column headers
        std::getline(myFile, line);
    }
    else
        std::cout << "Something went wrong with: ios::good failed...";
    // Loop 
    while(std::getline(myFile, line))
    {
        // Create a stringstream of the current line
        std::stringstream ss(line);
        
        // Extract each integer
        while(ss >> value)
        {
            // Check if value is new min
            if(value < min_max.first)
                min_max.first = value;
            if(value > min_max.second)
                min_max.second = value;
            // If the next token is a comma, ignore it and move on
            if(ss.peek() == ',') ss.ignore();
        }
    }
    return min_max;
}

std::vector<std::string> get_all_files_names_within_folder(std::string folder)
{
    std::vector<std::string> names;
    std::string search_path = folder + "/*.csv";
    WIN32_FIND_DATA fd; 
    HANDLE hFind = ::FindFirstFile(search_path.c_str(), &fd); 
    if(hFind != INVALID_HANDLE_VALUE) { 
        do { 
            // read all (real) files in current folder
            // , delete '!' read other 2 default folder . and ..
            if(! (fd.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY) ) {
                names.push_back(fd.cFileName);
            }
        }while(::FindNextFile(hFind, &fd)); 
        ::FindClose(hFind); 
    } 
    return names;
}


int main()
{
    clock_t start, end;
    double cpu_time_used;
    start = clock();
     
    /* 
    std::pair<double,double> min_maxTEST = get_min_max_csv("2015_03_03_02_35_bci_t.csv");

    std::cout << min_maxTEST.first << std::endl;
    std::cout << min_maxTEST.second << std::endl;
    */
    double maxIN = -10.0;
    double minIN = 9999.9;

    std::cout << "NOTE: Make sure this executable is within the same folder as the files you wish to get the min_max statistics of (Windows system required).\n";
    std::cout << "Please type the file path of your data (ex: C:/Users/Bob/csvdata), or 'exit' to quit this program: ";
    std::string csvFilePath;
    std::getline(std::cin, csvFilePath);
    int found = csvFilePath.find("/");
    if(found == std::string::npos)
    {
        std::cout << csvFilePath[csvFilePath.length()-1] << std::endl;
        std::cout << "Invalid file path or exit condition reached...\n";
        return 0;
    }




    //csvFilePath = "C:/Users/Peter/Desktop/Thermo_R_Code/FinalThermo/new2/csvdata/BCIML_Dataset";
    std::vector<std::string> fileList = get_all_files_names_within_folder(csvFilePath);
    for(int i=0; i < fileList.size(); i++)
    {
        std::pair<double,double> min_maxTEST = get_min_max_csv(fileList[i], minIN, maxIN);
        if(min_maxTEST.first < minIN)
            minIN = min_maxTEST.first; 
        if(min_maxTEST.second > maxIN)
            maxIN = min_maxTEST.second; 
        if (i % 200 == 0)
            std::cout << "On file " << i << std::endl;
    }
    end = clock();

    std::ofstream myfile;
    myfile.open("output_get_min_max.txt");



    cpu_time_used = ((double) (end - start)) / CLOCKS_PER_SEC;
    std::cout << "Time taken (s): " << cpu_time_used << std::endl;
    myfile << "Time taken (s): " << cpu_time_used << std::endl;

    std::cout << "Number of Files Analyzed: " << fileList.size() << std::endl;
    myfile << "Number of Files Analyzed: " << fileList.size() << std::endl;

    std::cout << "Max value is: " << maxIN << std::endl;
    std::cout << "Min value is: " << minIN << std::endl;
    myfile << "Max value is: " << maxIN << std::endl;
    myfile << "Min value is: " << minIN << std::endl;
    // 1,000 file name grabs take ~0.862 seconds
    // 1 min_max search takes ~0.341 seconds
    myfile.close();


}
