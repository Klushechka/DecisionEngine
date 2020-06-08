# DecisionEngine

DecisionEngine is a test application which was created to decide if a customer can get approval from a bank for the loan with _requested amount and period_ and also to calculate a maximal possible amount of loan for particular customer. 

At first DecisionEngine checks if a customer has any debt. If yes, then a negative decision message is shown. 
If no, then after that the engine calculates credit score with the formula. If the result is < 1, then a negative decision is shown for current loan amount and period. Otherwise a positive decision message is shown for the loan amount and period requested by a user.

At the end the DecisionEngine calculates a credit score with the requested loan amount and maximal loan period for customers without a debt. Then _max loan amount_ = requested loan amount * credit score with maximal period. 

If the result is bigger than €10000, then it gets equated to €10000. 

* Minimal loan period is 12 months, maximal is 60 months.

* Minimal loan amount is €2000, maximal is €10000.

All amounts are rounded by nearest 100.

### Tests

The project also includes unit tests which are placed in DecisionEngineTests folder. 

If you have any questions or suggestions, please reach me via klyushkina.olga@gmail.com.
