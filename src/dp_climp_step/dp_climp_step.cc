#include <bits/stdc++.h>
#include "dp_climp_step.h"

using namespace std;

// 解题模板
// 解题
// 给定字符串 s 和 t ，判断 s 是否为 t 的子序列。
class Solution
{
public:
    int climbStairs(int n)
    {
        if (n == 1)
            return 1;
        vector<int> dp;
        dp.push_back(1);
        dp.push_back(2);
        for (int i = 2; i < n; i++)
        {
            dp.push_back(dp[i - 1] + dp[i - 2]);
        }
        return dp[n - 1];
    }
};

// 测试用例
int test_func(int n)
{
    Solution solve;
    return solve.climbStairs(n);
}

int main(int argc, char **argv)
{
    vector<int> n = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
    vector<int> pre_result = {1, 2, 3, 5, 8, 13, 21, 34, 55, 89};
    for (int i = 0; i < n.size(); i++)
    {
        auto beforeTime = chrono::steady_clock::now();
        auto result = test_func(n[i]);
        auto afterTime = chrono::steady_clock::now();
        if (result == pre_result[i])
        {
            cout << "test" << i << " success! ";
            double duration_millsecond = chrono::duration<double, milli>(afterTime - beforeTime).count();
            cout << "algorithm_time: " << duration_millsecond << "ms" << endl;
        }
        else
        {
            cout << "test" << i + 1 << " error!   :-" << n[i] << "-\n";
        }
    }

    return 0;
}