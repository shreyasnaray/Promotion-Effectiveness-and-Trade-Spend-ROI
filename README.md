README: Promotion Effectiveness and Trade Spend ROI Analysis
Project Title
CPG Promotion Effectiveness: Identifying Which Promotions Drive Lift, Profit, and ROI

Business Case
A consumer packaged goods company wants to evaluate whether its retail promotions are actually creating profitable growth. The business is running promotions across Walmart, Target, and Kroger for three products: P1 Snacks, P2 Beverages, and P3 Dairy. The company needs to know which promotions should be repeated, optimized, or stopped.
The core business question is:
Are our promotions driving profitable incremental sales, or are we buying volume at the expense of margin?
The R code builds a promotion analytics workflow using weekly retailer-product data, including base price, promo price, discount depth, units sold, baseline units, incremental units, trade spend, gross profit, display support, coupon support, competitor promotions, and store traffic.

Problem
Promotions often increase units sold, but higher volume does not automatically mean better business performance.
A promotion can look successful because it drives more units, but still be financially weak if:
The discount is too deep.
Trade spend is too high.
Incremental gross profit does not cover the spend.
Competitors are also promoting.
The promotion pulls forward demand without creating profitable growth.
This project answers five major questions:
Which promotions generated the most incremental units?
Which promotions generated the most net incremental profit?
Which retailer had the best trade spend ROI?
Which products were most responsive to promotion?
Which promotions should be repeated, changed, or stopped?

Dataset
Dataset Structure
Each row represents a:
week × retailer × product combination

Key Findings
Finding 1: Promotions generated volume, but not profit
Across all active promotions, incremental units increased. However, net incremental profit was negative across retailers.
Retailer	Incremental Units	Net Incremental Profit	Trade Spend ROI
Walmart	1,625	-$964.75	-36.4%
Kroger	1,340	-$1,101.25	-45.9%
Target	980	-$1,124.50	-48.4%
Business interpretation: Promotions worked from a volume standpoint, but failed from a profitability standpoint.

Finding 2: Walmart had the best relative ROI, but it was still negative
Walmart had the highest incremental units and the least negative ROI.
However, the ROI was still below zero.
This means Walmart was the “best” retailer only in relative terms.
Business interpretation: Walmart promotions were less bad, not truly profitable.

Finding 3: P1 Snacks was the strongest product financially
Product-level performance: P2 had the highest weighted lift, but P1 had the best profitability profile.
Business interpretation: P2 was highly promo-responsive, but the economics were weak. P1 was the better candidate for future promotion optimization.

Finding 4: P3 Dairy was the weakest promotion product
P3 had:
Lowest incremental units
Lowest promo lift
Worst ROI
Weakest net incremental profit
Business interpretation: P3 promotions should be stopped or heavily reworked unless there is a strategic reason to support the product.

Finding 5: Display features increased lift but did not improve ROI
Promotions with display support had stronger lift:
Business interpretation: Displays helped move units, but the extra promotional investment still did not pay back. This is a very realistic CPG insight: displays can drive volume while still hurting profitability.

Finding 6: Coupons increased lift but worsened ROI
Coupon-supported promotions had higher lift but weaker ROI.
Business interpretation: Coupons helped drive incremental units, but they were too expensive or too margin-dilutive to be profitable.

Finding 7: Competitor promotions reduced lift
When competitors were promoting, our weighted lift was lower.
Business interpretation: Competitor promotions reduced our volume response, even though ROI was similarly negative. This suggests that promotional timing matters.

Insight Section: Surprising Findings
Insight 1: The biggest unit-lift promotions were still unprofitable
The top volume-driving promotion was:
Walmart P1 in 2024-W02: +490 incremental units
But it still generated negative net incremental profit.
Surprising takeaway: High lift does not equal high-quality promotion performance.

Insight 2: P2 looked like a winner until profit was included
P2 Beverages had the strongest weighted promo lift at about 33.2%. But P2 also had a deeply negative ROI of about -52.2%.
Surprising takeaway: P2 is highly responsive to discounts, but the business is buying volume too expensively.

Insight 3: Display support created more lift but worse ROI
Displays improved weighted lift from 23.4% to 38.1%. But ROI worsened from -37.8% to -49.4%.
Surprising takeaway: Better merchandising can increase units while still destroying profit if trade spend is too high.

Insight 4: Coupons created more lift but weaker economics Coupon promotions generated nearly the same total incremental units as non-coupon promotions, but at much worse ROI. Surprising takeaway: Coupons may be training shoppers to buy only on deal without producing enough incremental margin.

Insight 5: The “best retailer” still lost money Walmart had the best ROI among the three retailers, but it was still negative.
Surprising takeaway: Ranking retailers is not enough. The company needs an absolute profitability threshold.

Metric Story
Main Metric: Trade Spend ROI
What metric changed?

The analysis moved from looking at:
Incremental units

Net incremental profit and trade spend ROI

That shift changed the business conclusion.

At first, the promotions appeared successful because they generated incremental units. But after subtracting trade spend, the promotions became unprofitable.

Why did it change? The metric changed because volume alone ignored the cost of promotion.
A promotion can generate hundreds of incremental units, but if each unit has low margin and the trade spend is high, the business can still lose money.

What caused it?

The main causes were:

High trade spend
Lower gross margin per unit during promotions
Deep discounting
Coupon and display costs
Weak profitability on P2 and P3
Competitor promotional pressure

The promotion formula tells the story:

Net Incremental Profit = Incremental Gross Profit - Trade Spend

The problem was not that incremental gross profit was zero. The problem was that trade spend was larger than incremental gross profit.

What should we do?

The business should stop judging promotions by incremental units alone.

Instead, the decision framework should prioritize:

Net incremental profit
Trade spend ROI
Promo lift percentage
Gross margin percentage
Competitor promo environment
Product-retailer fit

The practical action is:

Repeat only promotions with positive net incremental profit and positive ROI. Rework or stop promotions that create volume but lose money.

Business Impact
Financial Impact
The active promotions generated strong unit lift but negative financial returns.
Total active-promotion net incremental profit was approximately: -$3,190.50
This means the company spent more on trade support than it recovered through incremental gross profit.
Business interpretation: The current promotion strategy is creating sales activity, but not profitable growth.

Retailer Impact
Walmart should be the first retailer to optimize because it has the strongest relative response. Target should be reviewed carefully because it produced the weakest retailer-level economics.

Product Impact
P1 is the most promising product because it has the least negative ROI.
P2 should not be abandoned because it is responsive, but the company needs to reduce trade spend, reduce discount depth, or improve margin.
P3 should be paused or reworked because it has weak lift and poor economics.

Strategic Impact
The project shows that the business should move from a sales-volume mindset to a profitable-growth mindset. Instead of asking:
Which promotion sold the most? The team should ask: Which promotion generated profitable incremental demand after trade spend?

Recommendations
Recommendation 1: Stop using incremental units as the main success metric

Incremental units should be a supporting metric, not the final decision metric.

Primary success metrics should be:

Net incremental profit
Trade spend ROI
Weighted promo lift percentage
Gross margin percentage

Recommendation 2: Rework P1 promotions first
P1 had the best relative economics.
Although P1 was still negative overall, it was closest to profitability.
Reduce trade spend.
Test smaller discounts.
Keep display support only where it proves profitable.
Prioritize Walmart and Kroger tests.
Use P1 as the first product for promotion optimization.

Recommendation 3: Fix P2 economics before scaling
P2 had strong lift but poor ROI.
Recommended actions:
Reduce discount depth.
Negotiate lower trade spend.
Avoid running P2 promotions during competitor promo weeks.
Test whether coupons are necessary.
Track margin per incremental unit.

Recommendation 4: Pause or redesign P3 promotions

P3 had the weakest performance.

Recommended actions:

Pause broad P3 promotions.
Test narrower targeted promotions.
Use lighter discounts.
Avoid expensive displays.
Reassess whether the product has enough promo responsiveness to justify trade spend.

Executive Summary

This project evaluates promotion effectiveness across Walmart, Target, and Kroger for three CPG products. The analysis calculates incremental revenue, incremental gross profit, net incremental profit, trade spend ROI, weighted promo lift, display impact, coupon impact, competitor promo impact, and final promotion recommendations.

The key finding is that promotions increased units but failed to generate profitable growth. Walmart had the best relative performance, but still had negative ROI. P1 Snacks was the strongest product financially, P2 Beverages was highly responsive but too expensive to promote, and P3 Dairy was the weakest promotion candidate.

The most important business insight is:

Promotions should not be judged by unit lift alone. The right question is whether incremental gross profit covers trade spend.

Final Recommendation

The company should stop or rework the current promotion plan and rebuild it around profitability.

Priority actions:

Optimize P1 promotions first.
Rework P2 economics before scaling.
Pause or redesign P3 promotions.
Reduce trade spend and avoid unnecessary coupon/display support.
Avoid promoting during competitor promo weeks when possible.
Use net incremental profit and trade spend ROI as the final decision metrics.

Final business message:

The promotions are driving volume, but not profitable volume. The next step is not to promote more; it is to promote smarter.






































































