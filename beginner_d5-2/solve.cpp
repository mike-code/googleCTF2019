#include <iostream>
#include <string>
#include <boost/multiprecision/cpp_int.hpp>
#include <thread>
#include <vector>

using namespace boost::multiprecision;

// Returns sqrt as round up integer
cpp_int isqrt(cpp_int in)
{
    cpp_int o = sqrt(in);

    if (o*o != in) o += 1;

    return o;
}

// Checks if int is a perfect square root slighly faster using well-known rules
bool fast_is_perfect(cpp_int in)
{
    std::string s = in.str();
    int len = s.length();
    int a = s[--len] - '0', b = s[--len] - '0';

    if (a == 2 || a == 3 || a == 7 || a == 8) return false;
    if (a == 6 && b % 2 == 0) return false;
    if (a != 6 && b % 2 == 1) return false;
    if (a == 5 && b != 2) return false;
    if ((10*b + a) % 2 == 0 && (10*b + a) % 4 != 0) return false;

    cpp_int o = sqrt(in);

    return o*o == in;
}

int main()
{
    std::vector<std::thread> workers;
    cpp_int N("17450892350509567071590987572582143158927907441748820483575144211411640241849663641180283816984167447652133133054833591585389505754635416604577584488321462013117163124742030681698693455489404696371546386866372290759608301392572928615767980244699473803730080008332364994345680261823712464595329369719516212105135055607592676087287980208987076052877442747436020751549591608244950255761481664468992126299001817410516694015560044888704699389291971764957871922598761298482950811618390145762835363357354812871474680543182075024126064364949000115542650091904557502192704672930197172086048687333172564520657739528469975770627");
    cpp_int N4 = 4*N;

    int work[] = {0,288,408,500,577,645,707,764,816,866,913,957,1000};

    for (int i = 0; i < 12; i++)
    {
        int from = work[i] + 1, to = work[i+1];

        workers.push_back(
            std::thread([from, to, N4]() {
                for(int a = from; a <= to; a++)
                {
                    for(int b = 1; b < a; b++)
                    {
                        cpp_int opt = N4 * a * b;
                        cpp_int check = pow(isqrt(opt), 2) - opt;

                        if (fast_is_perfect(check))
                        {
                            printf("a: %d\nb: %d\nd: ", a, b);
                            std::cout << isqrt(check) << "\n";
                        }
                    }
                }
            })
        );
    }

    std::for_each(workers.begin(), workers.end(), [](std::thread &t)
    {
        t.join();
    });
}
