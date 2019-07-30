#include <iostream>

class Dupa
{
public:
	int huj;

	Dupa(int h)
	{
		huj = h;
	}
};

int main()
{
	Dupa c(3);
	std::cout << c.huj;
}
