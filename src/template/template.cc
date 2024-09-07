#include <bits/stdc++.h>

using namespace std;

// class template
class Solution
{
public:
    bool demo(void)
    {
        return true;
    }
};

// test template
bool test_func(void)
{
    Solution solve;
    return solve.demo();
}

// main template
int main(int argc, char **argv)
{
    /**
     * input test params.
     */

    vector<int> ss(2, 0);

    /**
     * pre result.
     */
    vector<bool> pre_result = {true, false};
    for (int i = 0; i < ss.size(); i++)
    {
        auto beforeTime = chrono::steady_clock::now();
        auto result = test_func();
        auto afterTime = chrono::steady_clock::now();
        if (result == pre_result[i])
        {
            cout << "test" << i << " success! ";
            double duration_millsecond = chrono::duration<double, milli>(afterTime - beforeTime).count();
            cout << "algorithm_time: " << duration_millsecond << "ms" << endl;
        }
        else
        {
            cout << "test" << i << " error!   :-" << ss[i] << "-\n";
        }
    }

    return 0;
}