#include <bits/stdc++.h>
#include "demo.h"

using namespace std;

// 解题模板
// 解题
// 给定字符串 s 和 t ，判断 s 是否为 t 的子序列。
class Solution
{
public:
    bool isSubsequence(string s, string t)
    {
        if (s.size() == 0)
            return true;
        if (s.size() > t.size())
            return false;
        // 快慢指针
        for (auto iter1 = s.begin(), iter2 = t.begin(); iter2 < t.end();
             iter2++)
        {
            if ((*iter1) == (*iter2))
            {
                iter1++;
                if (iter1 == s.end())
                    return true;
            }
        }
        return false;
    }
};

// 测试用例
bool test_func(string s, string t)
{
    Solution solve;
    return solve.isSubsequence(s, t);
}

int main(int argc, char **argv)
{
    vector<string> ss = {"abc", "axc"};
    vector<string> tt = {"ahbgdc", "ahbgdc"};
    vector<bool> pre_result = {true, false};
    for (int i = 0; i < ss.size(); i++)
    {
        auto beforeTime = chrono::steady_clock::now();
        auto result = test_func(ss[i], tt[i]);
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