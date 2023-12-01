
#include <iostream>
#include <fstream>

#include <vector>

using namespace std;

int main() {
    
    int Št;
    int ID;
    double x;
    double y;
    char d;
    vector<int> seznamID;
    vector<double> seznamX;
    vector<double> seznamY;
    vector<double> seznamOdvod;
    
    ifstream file;
    file.open("poly.txt",ios::in);

    if (file.is_open()) {

        file >> Št;

        while (file >> ID >> d >> x >> y) {
            seznamID.push_back(ID);
            seznamX.push_back(x);
            seznamY.push_back(y);
        }

        file.close();

        for (int i = 0; i < Št; i++) {
            
            if (seznamID.at(i) == seznamID.at(0)) {
                seznamOdvod.push_back((-3 * seznamY.at(i) + 4 * seznamY.at(i + 1) - seznamY.at(i + 2)) / (2 * (seznamX.at(i + 1) - seznamX.at(i))));
                //cout << seznamOdvod.at(i) << endl;
            }
            else if (seznamID.at(i) == seznamID.at(Št-1)) {
                seznamOdvod.push_back((3 * seznamY.at(i) - 4 * seznamY.at(i - 1) + seznamY.at(i - 2)) / (2 * (seznamX.at(i) - seznamX.at(i - 1))));
                //cout << seznamOdvod.at(i) << endl;
            }
            else {
                seznamOdvod.push_back((seznamY.at(i + 1) - seznamY.at(i - 1)) / (2 * (seznamX.at(i) - seznamX.at(i - 1))));
                //cout << seznamOdvod.at(i) << endl;
            }
        }
        ofstream newFile;
        newFile.open("diff_poly.txt", ios::out);

        if (newFile.is_open()) {
            for (int i = 0; i < Št; i++) {
                newFile << seznamOdvod.at(i) << endl;
            }
            newFile.close();
        }
        else cout << "Beležke ni bilo možno napisati\n";
    }
    else cout << "Beležka ni odprta\n";
    
    return 0;
}
