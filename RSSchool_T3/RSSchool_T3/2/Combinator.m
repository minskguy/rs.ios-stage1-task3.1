#import "Combinator.h"

double factorial(int n) {
    if (n == 0) return 1;
    else return n*factorial(n-1);
};

double binomialCoefficient(int n, int k) {
    double temp = n;
    for (int i = 1; i < k; i++) temp *= (n-i);
    return temp/factorial(k);
}

@implementation Combinator
- (NSNumber*)chechChooseFromArray:(NSArray <NSNumber*>*)array {
    int N = [array[0] intValue], n = [array[1] intValue], k = 1;
    double m = n;
    while ((N != m || m < N) && k < n) {
        k++;
        m = binomialCoefficient(n, k);
    }
    if (N == m) return @(k);
    else return nil;
}
@end
