library(dplyr)
library(tidyverse)
library(ggplot2)
library(ggrepel)
library(forcats)
library(scales)
week <- c('2024-W01', '2024-W01', '2024-W01', '2024-W02', '2024-W02', '2024-W02',
          '2024-W03', '2024-W03', '2024-W03', '2024-W04', '2024-W04', '2024-W04',
          '2024-W01', '2024-W01', '2024-W01', '2024-W02', '2024-W02', '2024-W02', 
          '2024-W03', '2024-W03', '2024-W03', '2024-W04', '2024-W04', '2024-W04',
          '2024-W01', '2024-W01', '2024-W01', '2024-W02', '2024-W02', '2024-W02',
          '2024-W03', '2024-W03', '2024-W03', '2024-W04', '2024-W04', '2024-W04')
retailer <- c('Walmart', 'Walmart', 'Walmart', 'Walmart', 'Walmart', 'Walmart',
              'Walmart', 'Walmart', 'Walmart', 'Walmart', 'Walmart', 'Walmart',
              'Target', 'Target', 'Target','Target', 'Target', 'Target', 
              'Target', 'Target', 'Target', 'Target', 'Target', 'Target', 
              'Kroger', 'Kroger', 'Kroger', 'Kroger', 'Kroger', 'Kroger',
              'Kroger', 'Kroger', 'Kroger', 'Kroger', 'Kroger', 'Kroger')
region <- c('West', 'West', 'West', 'West', 'West', 'West', 
            'West', 'West', 'West', 'West', 'West', 'West',
            'East', 'East', 'East', 'East', 'East', 'East',
            'East', 'East', 'East', 'East', 'East', 'East',
            'Central', 'Central', 'Central', 'Central', 'Central', 'Central',
            'Central', 'Central', 'Central', 'Central', 'Central', 'Central')
store_id <- c(101, 101, 101, 101, 101, 101, 
              101, 101, 101, 101, 101, 101, 
              201, 201, 201, 201, 201, 201,
              201, 201, 201, 201, 201, 201,
              301, 301, 301, 301, 301, 301,
              301, 301, 301, 301, 301, 301)
product_id <- c('P1', 'P2', 'P3', 'P1', 'P2', 'P3',
                'P1', 'P2', 'P3', 'P1', 'P2', 'P3',
                'P1', 'P2', 'P3', 'P1', 'P2', 'P3',
                'P1', 'P2', 'P3', 'P1', 'P2', 'P3',
                'P1', 'P2', 'P3', 'P1', 'P2', 'P3', 
                'P1', 'P2', 'P3', 'P1', 'P2', 'P3')
category <- c('Snacks', 'Beverages', 'Dairy', 'Snacks', 'Beverages', 'Dairy',
              'Snacks', 'Beverages', 'Dairy', 'Snacks', 'Beverages', 'Dairy',
              'Snacks', 'Beverages', 'Dairy', 'Snacks', 'Beverages', 'Dairy',
              'Snacks', 'Beverages', 'Dairy', 'Snacks', 'Beverages', 'Dairy',
              'Snacks', 'Beverages', 'Dairy', 'Snacks', 'Beverages', 'Dairy',
              'Snacks', 'Beverages', 'Dairy', 'Snacks', 'Beverages', 'Dairy')
base_price <- c(4.99, 3.49, 5.99, 4.99, 3.49, 5.99,
                4.99, 3.49, 5.99, 4.99, 3.49, 5.99,
                5.29, 3.79, 6.29, 5.29, 3.79, 6.29, 
                5.29, 3.79, 6.29, 5.29, 3.79, 6.29,
                4.79, 3.39, 5.79, 4.79, 3.39, 5.79,
                4.79, 3.39, 5.79, 4.79, 3.39, 5.79)
promo_price <- c(4.99, 3.49, 5.99, 3.99, 2.99, 5.49,
                 4.49, 3.49, 5.99, 4.99, 2.79, 5.99,
                 5.29, 3.79, 6.29, 4.49, 3.19, 5.79,
                 5.29, 3.79, 5.49, 4.79, 3.79, 6.29,
                 4.79, 3.39, 5.79, 3.99, 2.89, 5.29,
                 4.49, 3.39, 5.79, 4.79, 2.79, 5.79)
discount_depth <- c(0, 0, 0, 0.2, 0.14, 0.08,
                    0.10, 0, 0, 0, 0.2, 0,
                    0, 0, 0, 0.15, 0.16, 0.08,
                    0, 0, 0.13, 0.09, 0, 0,
                    0, 0, 0, 0.17, 0.15, 0.09,
                    0.06, 0, 0, 0, 0.18, 0)
units_sold <- c(980, 1250, 720, 1450, 1580, 780,
                1200, 1235, 710, 965, 1700, 700,
                840, 1030, 650, 1120, 1340, 710,
                825, 990, 760, 1010, 1005, 640,
                910, 1160, 680, 1280, 1480, 740, 
                1050, 1125, 665, 895, 1540, 675)
baseline_units <- c(950, 1200, 700, 960, 1220, 705,
                    970, 1210, 700, 955, 1230, 690,
                    820, 1000, 640, 830, 1010, 645,
                    815, 995, 650, 825, 1000, 635,
                    890, 1130, 670, 900, 1140, 675, 
                    900, 1120, 670, 890, 1135, 665)
incremental_units <- c(30, 50, 20, 490, 360, 75,
                       230, 25, 10, 10, 470, 10,
                       20, 30, 10, 290, 330, 65,
                       10, -5, 110, 185, 5, 5,
                       20, 30, 10, 380, 340, 65, 
                       150, 5, -5, 5, 405, 10)
revenue <- c(4890.20, 4362.50, 4312.80, 5785.50, 4724.20, 4282.20,
             5388.00, 4310.15, 4252.90, 4815.35, 4743.00, 4193.00,
             4443.60, 3903.70, 4088.50, 5028.80, 4274.60, 4110.90,
             4364.25, 3752.10, 4172.40, 4837.90, 3808.95, 4025.60,
             4358.90, 3932.40, 3937.20, 5107.20, 4277.20, 3914.60,
             4714.50, 3813.75, 3850.35, 4287.05, 4296.60, 3908.25)
gross_margin_per_unit <- c(1.80, 1.25, 1.60, 1.15, 0.95, 1.25,
                           1.45, 1.25, 1.60, 1.80, 0.75, 1.60,
                           1.95, 1.35, 1.70, 1.35, 0.95, 1.35,
                           1.95, 1.35, 1.10, 1.55, 1.35, 1.70,
                           1.70, 1.20, 1.55, 1.10, 0.85, 1.20,
                           1.40, 1.20, 1.55, 1.70, 0.75, 1.55)
gross_profit <- c(1764.00, 1562.50, 1152.00, 1667.50, 1501.00, 975.00,
                  1740.00, 1543.75, 1136.00, 1737.00, 1275.00, 1120.00,
                  1638.00, 1390.50, 1105.00, 1512.00, 1273.00, 958.50,
                  1608.75, 1336.50, 836.00, 1565.50, 1356.75, 1088.00,
                  1547.00, 1392.00, 1054.00, 1408.00, 1258.00, 888.00,
                  1470.00, 1350.00, 1030.75, 1521.50, 1155.00, 1046.25)
promo_active <- c(0, 0, 0, 1, 1, 1, 
                  1, 0, 0, 0, 1, 0,
                  0, 0, 0, 1, 1, 1,
                  0, 0, 1, 1, 0, 0,
                  0, 0, 0, 1, 1, 1,
                  1, 0, 0, 0, 1, 0)
display_feature <- c(0, 0, 0, 1, 0, 0, 
                     0, 0, 0, 0, 1, 0,
                     0, 0, 0, 0, 0, 0,
                     0, 0, 1, 0, 0, 0,
                     0, 0, 0, 1, 0, 0,
                     0, 0, 0, 0, 1, 0)
coupon_active <- c(0, 0, 0, 0, 1, 0,
                   0, 0, 0, 0, 1, 0,
                   0, 0, 0, 1, 0, 0,
                   0, 0, 1, 0, 0, 0,
                   0, 0, 0, 0, 1, 0,
                   0, 0, 0, 0, 1, 0)
trade_spend <- c(0, 0, 0, 650, 500, 300,
                 350, 0, 0, 0, 850, 0,
                 0, 0, 0, 500, 650, 275,
                 0, 0, 600, 300, 0, 0,
                 0, 0, 0, 575, 550, 250, 
                 225, 0, 0, 0, 800, 0)
competitor_promo <- c(0, 0, 0, 0, 0, 1,
                      1, 0, 0, 0, 0, 0, 
                      0, 0, 0, 0, 1, 0,
                      1, 0, 0, 0, 0, 1,
                      0, 0, 1, 0, 0, 0,
                      0, 1, 0, 0, 0, 0)
store_traffic <- c(8200, 8200, 8200, 8500, 8500, 8500,
                   8300, 8300, 8300, 8100, 8100, 8100,
                   6900, 6900, 6900, 7100, 7100, 7100,
                   6800, 6800, 6800, 7000, 7000, 7000,
                   7400, 7400, 7400, 7600, 7600, 7600,
                   7350, 7350, 7350, 7450, 7450, 7450)

df <- data.frame(week = week, retailer = retailer, region = region, store_id = store_id,
           product_id = product_id, category = category, base_price = base_price,
           promo_price = promo_price, discount_depth = discount_depth, units_sold = units_sold,
           baseline_units = baseline_units, incremental_units = incremental_units, revenue = revenue,
           gross_margin_per_unit = gross_margin_per_unit, gross_profit = gross_profit,
           promo_active = promo_active, display_feature = display_feature, coupon_active = coupon_active,
           trade_spend = trade_spend, competitor_promo = competitor_promo, store_traffic = store_traffic)

df$incremental_revenue <- df$incremental_units * df$promo_price

df$incremental_gross_profit <- df$incremental_units * df$gross_margin_per_unit

df$net_incremental_profit <- df$incremental_gross_profit - df$trade_spend

df <- df %>%
  mutate(
    trade_spend_roi =ifelse(
      trade_spend > 0,
      net_incremental_profit/trade_spend,
      NA),
    trade_spend_roi = round(trade_spend_roi, 2)
    )

# Which promotions generated the highest incremental units?
df$week = as.factor(df$week)
promo_incremental_units <- df %>%
  filter(promo_active == 1) %>%
  group_by(week, retailer, region, product_id, category) %>%
  summarise(
    units_sold = sum(units_sold),
    baseline_units = sum(baseline_units),
    incremental_units = sum(incremental_units),
    trade_spend = sum(trade_spend),
    discount_depth = mean(discount_depth)
  ) %>%
  arrange(desc(incremental_units))

print(promo_incremental_units, width = Inf)


top_promos <- promo_incremental_units %>%
  mutate(
    promo_label = paste(retailer, product_id, week, sep = ' | '),
    promo_label = fct_reorder(promo_label, incremental_units, .desc = TRUE)
  )
print(top_promos, width = Inf)

# Which exact promotions generated the most lift above baseline?
ggplot(top_promos, aes(x = promo_label, y = incremental_units, fill = retailer)) +
  geom_col() + 
  coord_flip() +
  labs(
    title = 'Top Promotions by Incremental Units',
    x = 'Promotion', 
    y = 'Incremental Units',
    fill = 'Retailer'
  )

# Which exact promotions generated lift above baseline not just because the discount
# depth was very large?
ggplot(top_promos, aes(x = promo_label, y = incremental_units, fill = discount_depth)) +
  geom_col() +
  coord_flip() +
  labs(
    title = 'Top Promotions by Incremental Units and Discount Depth',
    x = 'Promotion', 
    y = 'Incremental Units',
    fill = 'Discount Depth'
  )

# Did the highest-lift promotions require a lot of spend?
promo_incremental_units %>%
  ggplot(aes(x = trade_spend, y = incremental_units, color = retailer)) +
  geom_point(size = 3, alpha = 0.8) +
  geom_smooth(method = 'lm', se = FALSE) +
  labs(
    title = 'Incremental Units vs Trade Spend',
    x = 'Trade Spend', 
    y = 'Incremental Units',
    color = 'Retailer'
  )

# Which promotions generated the highest incremental profit?

promo_incremental_profit <- df %>%
  filter(promo_active == 1) %>%
  group_by(week, retailer, region, product_id, category) %>%
  summarise(
    units_sold = sum(units_sold),
    baseline_units = sum(baseline_units),
    incremental_units = sum(incremental_units),
    trade_spend = sum(trade_spend),
    incremental_gross_profit = sum(incremental_gross_profit),
    net_incremental_profit = sum(net_incremental_profit),
    discount_depth = mean(discount_depth)
  ) %>%
  arrange(desc(net_incremental_profit))

print(promo_incremental_profit, width = Inf)

top_promo_profit <- promo_incremental_profit %>%
  mutate(
    promo_label = paste(retailer, product_id, week, sep = ' | '),
    promo_label = fct_reorder(promo_label, net_incremental_profit)
  )

print(top_promo_profit, width = Inf)

# Which promotions generated the most incremental profit above baseline?
ggplot(top_promo_profit, aes(x = promo_label, y = net_incremental_profit, 
                             fill = retailer)) +
  geom_col() +
  coord_flip() +
  labs(
    title = 'Top Promotions by Net Incremental Profit',
    x = 'Promotion', 
    y = 'Net Incremental Profit', 
    fill = 'Retailer'
  )
# Which retailer had best performing promotions?
promo_incremental_profit %>%
  mutate(
    promo_label = paste(product_id, week, sep = ' | '),
    promo_label = fct_reorder(promo_label, net_incremental_profit)
  ) %>%
ggplot(aes(x = promo_label, y = net_incremental_profit,
                             fill = product_id)) +
  geom_col() + 
  coord_flip() +
  facet_wrap(~retailer, scales = 'free_y') +
  labs(
    title = 'Top Promotions by Incremental Profit above Baseline',
    x = 'Promotion', 
    y = 'Incremental Gross Profit', 
    fill = 'Discount Depth'
  )
# Did highest-lift promotions require a lot of spend?
promo_incremental_profit %>%
  ggplot(aes(x = trade_spend, y = incremental_gross_profit, 
             color = retailer)) +
  geom_point(size = 3, alpha = 0.8) +
  geom_smooth(method = 'lm', se = FALSE) +
  geom_abline(slope = 1, intercept = 0, linetype = 'dashed')
  labs(
    title = 'Incremental Profit vs Trade Spend',
    x = 'Trade Spend',  
    y = 'Incremental Profit',
    color = 'Retailer'
  )

# Which retailer had the best trade spend ROI?
retailer_roi <- df %>%
  filter(promo_active == 1) %>%
  group_by(retailer) %>%
  summarise(
    total_incremental_units = sum(incremental_units),
    total_incremental_gross_profit = sum(incremental_gross_profit),
    total_trade_spend = sum(trade_spend),
    total_net_incremental_profit = sum(net_incremental_profit),
    trade_spend_roi = ifelse(
      total_trade_spend > 0,
      total_net_incremental_profit / total_trade_spend,
      NA_real_
    ),
    .groups = 'drop'
  ) %>%
  arrange(desc(trade_spend_roi))


retailer_roi <- retailer_roi %>%
  mutate(
    trade_spend_roi = round(trade_spend_roi, 2),
    total_incremental_gross_profit = round(total_incremental_gross_profit, 2),
    total_net_incremental_profit = round(total_net_incremental_profit, 2)
  )

print(retailer_roi, width = Inf)

retailer_roi %>%
  mutate(
    retailer = fct_reorder(retailer, trade_spend_roi)
  ) %>%
  ggplot(aes(x = retailer, y = trade_spend_roi, fill = retailer)) +
  geom_col() +
  coord_flip() +
  labs(
    title = 'Trade Spend ROI by Retailer',
    x = 'Retailer',
    y = 'Trade Spend ROI', 
    fill = 'Retailer'
  )

retailer_roi %>%
  ggplot(aes(x = total_trade_spend, y = trade_spend_roi, color = retailer, 
             size = total_incremental_units)) +
  geom_point(alpha = 0.8) +
  geom_hline(yintercept = 0, linetype = 'dashed') +
  labs(
    title = 'Retailer Trade Spend ROI vs. Trade Spend',
    x = 'Total Trade Spend', 
    y = 'Trade Spend ROI',
    color = 'Retailer',
    size = 'Incremental Units'
  )

# Check if a retailer is strong overall or just strong for one product
retailer_product_roi <- df %>%
  filter(promo_active == 1) %>%
  group_by(retailer, product_id) %>%
  summarise(
    total_incremental_units = sum(incremental_units),
    total_incremental_gross_profit = sum(incremental_gross_profit),
    total_trade_spend = sum(trade_spend),
    total_net_incremental_profit = sum(net_incremental_profit),
    trade_spend_roi = ifelse(
      total_trade_spend > 0,
      total_net_incremental_profit / total_trade_spend,
      NA_real_
    ),
    .groups = 'drop'
  ) %>%
  arrange(desc(trade_spend_roi))

print(retailer_product_roi, width = Inf)

retailer_product_roi %>%
  mutate(
    product_id = fct_reorder(product_id, trade_spend_roi)
  ) %>%
  ggplot(aes(x = product_id, y = trade_spend_roi, fill = product_id)) +
  geom_col() + 
  facet_wrap(~retailer) +
  geom_hline(yintercept = 0, linetype = 'dashed') +
  labs(
    title = 'Trade Spend ROI by Retailer and Product',
    x = 'Product', 
    y = 'Trade Spend ROI',
    fill = 'Product'
  )

# Which product is the most promo-responsive?
product_promo <- df %>%
  mutate(
    promo_lift_pct = incremental_units/baseline_units
  ) %>%
  filter(promo_active == 1) %>%
  group_by(product_id, category) %>%
  summarise(
    promo_weeks = n(),
    total_units_sold = sum(units_sold),
    total_baseline_units = sum(baseline_units),
    total_incremental_units = sum(incremental_units),
    avg_promo_lift_pct = mean(promo_lift_pct),
    weighted_promo_lift_pct = total_incremental_units/total_baseline_units,
    avg_discount_depth = mean(discount_depth),
    avg_trade_spend = mean(trade_spend),
    total_trade_spend = sum(trade_spend),
    .groups = 'drop'
  ) %>%
    arrange(desc(weighted_promo_lift_pct))

product_promo %>%
  mutate(
    product_id = fct_reorder(product_id, weighted_promo_lift_pct)
  ) %>%
  ggplot(aes(x = product_id, y = weighted_promo_lift_pct, fill = product_id)) +
  geom_col() +
  coord_flip() +
  labs(
    title = 'Promo Responsiveness by Product',
    x = 'Product', 
    y = 'Weighted Promo Lift ',
    fill = 'Product'
  )

product_promo %>%
  mutate(
    product_id = fct_reorder(product_id, weighted_promo_lift_pct)
  ) %>%
  ggplot(aes(x = product_id, y = weighted_promo_lift_pct, fill = product_id)) +
  geom_col() +
  coord_flip() +
  scale_y_continuous(labels = percent_format(accuracy = 1)) +
  labs(
    title = 'Promo Responsiveness by Product',
    x = 'Product', 
    y = 'Weighted Promo Lift %',
    fill = 'Product'
  )
# Promo Responsiveness should be measured against the size of the discount
df %>%
  mutate(
    promo_lift_pct = incremental_units/baseline_units
  ) %>%
  filter(promo_active == 1) %>%
  ggplot(aes(x = discount_depth, y = promo_lift_pct, color = product_id)) +
  geom_point(size = 3, alpha = 0.8) +
  geom_smooth(method = 'lm', se = FALSE) +
  scale_x_continuous(labels = percent_format(accuracy = 1)) +
  scale_y_continuous(labels = percent_format(accuracy = 1)) +
  labs(
    title = 'Promo Lift vs Discount Depth',
    x = 'Discount Depth',
    y = 'Promo Lift %',
    color = 'Product'
  )
print(product_promo, width = Inf)
product_promo <- product_promo %>%
  mutate(
    promo_type = case_when(
      weighted_promo_lift_pct >= 0.25 ~ 'High Response',
      weighted_promo_lift_pct >= 0.10 ~ 'Moderate Response',
      TRUE ~ 'Low Response'
    )
  )

# Does deeper discounting improve ROI or destroy margin?
df <- df %>%
  mutate(
    gross_margin_pct = gross_profit / revenue,
    gross_margin_pct = round(gross_margin_pct, 2)
  ) 
# Discount Depth vs Trade Spend ROI
df %>%
  filter(promo_active == 1) %>%
  ggplot(aes(x = discount_depth, y = trade_spend_roi, color = product_id)) +
  geom_point(size = 3, alpha = 0.8) +
  geom_smooth(method = 'lm', se = FALSE) +
  geom_hline(yintercept = 0, linetype = 'dashed') +
  scale_x_continuous(labels = percent_format(accuracy = 1)) +
  scale_y_continuous(labels = percent_format(accuracy = 1)) +
  labs(
    title = 'Does Deeper Discounting Improve Trade Spend',
    x = 'Discount Depth',
    y = 'Trade Spend ROI',
    color = 'Product'
  )
# Discount Depth vs Promo Active
df %>%
  filter(promo_active == 1) %>%
  ggplot(aes(x = discount_depth, y = gross_margin_pct, color = product_id)) +
  geom_point(size = 3, alpha = 0.8) +
  geom_smooth(method = 'lm', se = FALSE) +
  scale_x_continuous(labels = percent_format(accuracy = 1)) +
  scale_y_continuous(labels = percent_format(accuracy = 1)) +
  labs(
    title = 'Discount Depth vs Gross Margin %',
    x = 'Discount Depth',
    y = 'Gross Margin %',
    color = 'Product'
  )

# Discount Depth vs Incremental Units
df %>%
  filter(promo_active == 1) %>%
  ggplot(aes(x = discount_depth, y = incremental_units, color = product_id)) +
  geom_point(size = 3, alpha = 0.8) +
  geom_smooth(method = 'lm', se = FALSE) +
  scale_x_continuous(labels = percent_format(accuracy = 1)) +
  labs(
    title = 'Discount Depth vs Incremental Units',
    x = 'Discount Depth',
    y = 'Incremental Units',
    color = 'Product'
  )

# Discount Depth Buckets
df
discount_buckets <- df %>%
  filter(promo_active == 1) %>%
  mutate(
    discount_bucket = case_when(
      discount_depth < 0.10 ~ 'Low Discount: <10%',
      discount_depth < 0.17 ~ 'Medium Discount: 10-17%',
      TRUE ~ 'Deep Discount: 17%+'
    )
  ) %>%
  group_by(discount_bucket) %>%
  summarise(
    promos = n(),
    avg_discount_depth = mean(discount_depth),
    total_incremental_units = sum(incremental_units),
    total_incremental_gross_profit = sum(incremental_gross_profit),
    total_trade_spend = sum(trade_spend),
    total_net_incremental_profit = sum(net_incremental_profit),
    trade_spend_roi = ifelse(
      total_trade_spend > 0,
      total_net_incremental_profit / total_trade_spend,
      NA_real_
    ),
    avg_gross_margin_pct = mean(gross_margin_pct),
    .groups = 'drop'
  )
print(discount_buckets, width = Inf)

discount_buckets %>%
  ggplot(aes(x = discount_bucket, y = trade_spend_roi, fill = discount_bucket)) +
  geom_col() +
  geom_hline(yintercept = 0, linetype = 'dashed') +
  labs(
    title = 'Trade Spend ROI by Discount Depth',
    x = 'Discount Depth Bucket', 
    y = 'Trade Spend ROI', 
    fill = 'Discount Bucket'
  )

discount_buckets %>%
  ggplot(aes(x = discount_bucket, y = avg_gross_margin_pct, fill = discount_bucket)) +
  geom_col() +
  scale_y_continuous(labels = percent_format(accuracy = 1)) +
  labs(
    title = 'Average Gross Margin % by Discount Depth',
    x = 'Discount Depth Bucket',
    y = 'Average Gross Margin %'
  )
df
# Do display features improve promo effectiveness?
promo_display <- df %>%
  filter(promo_active == 1) %>%
  group_by(display_feature) %>%
  summarise(
    incremental_units = sum(incremental_units),
    incremental_revenue = sum(incremental_revenue),
    incremental_gross_profit = sum(incremental_gross_profit),
    weighted_promo_lift_pct = sum(incremental_units) / sum(baseline_units),
    avg_net_incremental_profit = sum(net_incremental_profit),
    avg_trade_spend_roi = mean(trade_spend_roi)
  ) %>%
  arrange(desc(avg_trade_spend_roi))

print(promo_display, width = Inf)


promo_display %>%
  ggplot(aes(x = display_feature, y = weighted_promo_lift_pct, fill = display_feature)) +
  geom_col() +
  scale_y_continuous(labels = percent_format(accuracy = 1)) +
  labs(
    title = 'Promo Lift With vs Without Display Feature',
    x = 'Display Feaature',
    y = 'Weighted Promo Lift %', 
    fill = 'Display Feature'
  )

promo_display %>%
  ggplot(aes(x = display_feature, y = avg_trade_spend_roi, fill = display_feature)) +
  geom_col() +
  geom_hline(yintercept = 0, linetype = 'dashed') +
  labs(
    title = 'Trade Spend ROI With vs Without Display', 
    x = 'Display Support',
    y = 'Trade Spend ROI',
    fill = 'Display Support'
  )
# How does display help or not help for each product?
display_product <- df %>%
  filter(promo_active == 1) %>%
   group_by(product_id, display_feature) %>%
  summarise(
    promos = n(),
    total_incremental_units = sum(incremental_units),
    weighted_promo_lift_pct = sum(incremental_units)/sum(baseline_units),
    total_trade_spend = sum(trade_spend),
    total_net_incremental_profit = sum(net_incremental_profit),
    trade_spend_roi = mean(trade_spend_roi)
  )

print(display_product, width = Inf)

# Promo Lift by Product
display_product %>%
  ggplot(aes(x = product_id, y = weighted_promo_lift_pct, fill = display_feature)) +
  geom_col(position = 'dodge') +
  scale_y_continuous(labels = percent_format(accuracy = 1)) +
  labs(
    title = 'Promo Lift With vs Without Display by Product',
    x = 'Product', 
    y = 'Weighted Promo Lift %',
    fill = 'Display Support'
  )

display_product %>%
  ggplot(aes(x = product_id, y = trade_spend_roi, fill = display_feature)) +
  geom_col(position = 'dodge') +
  geom_hline(yintercept = 0, linetype = 'dashed') +
  labs(
    title = 'Trade Spend ROI With vs Without Display by Product',
    x = 'Product', 
    y = 'Trade Spend ROI', 
    fill = 'Display Support'
  )
df
df <- df %>%
  mutate(
    weighted_promo_lift_pct = incremental_units/baseline_units,
    weighted_promo_lift_pct = round(weighted_promo_lift_pct, 2)
  ) 
ggplot(df, aes(x = discount_depth, y = weighted_promo_lift_pct, color = display_feature)) +
  geom_point(size = 3, alpha = 0.8) +
  geom_smooth(method = 'lm', se = FALSE) + 
  scale_x_continuous(labels = percent_format(accuracy = 1)) +
  scale_y_continuous(labels = percent_format(accuracy = 1)) +
  labs(
    title = 'Promo Lift vs Discount Depth by Display Support'
  )

display_model <- lm(
  weighted_promo_lift_pct ~ display_feature + discount_depth + coupon_active +
    competitor_promo + store_traffic + product_id + retailer, 
  data = df
)
summary(display_model)

profit_model <- lm(
  net_incremental_profit ~ display_feature + discount_depth + coupon_active +
    competitor_promo + store_traffic + product_id + retailer,
  data = df
)
summary(profit_model)

# Do coupons improve performance?
coupon_performance <- df %>%
  filter(promo_active == 1) %>%
  group_by(coupon_active) %>%
  summarise(
    incremental_units = sum(incremental_units),
    incremental_revenue = sum(incremental_revenue),
    incremental_gross_profit = sum(incremental_gross_profit),
    weighted_promo_lift_pct = sum(incremental_units)/sum(baseline_units),
    net_incremental_profit = sum(net_incremental_profit),
    trade_spend_roi = mean(trade_spend_roi)
  )

print(coupon_performance, width = Inf)

ggplot(coupon_performance, aes(x = coupon_active, y = weighted_promo_lift_pct, 
                               fill = coupon_active)) +
  geom_col() +
  coord_flip() +
  scale_y_continuous(labels = percent_format(accuracy = 1)) +
  labs(
    x = 'Active Coupon',
    y = 'Weighted Promo Lift (%)',
    fill = 'Active Coupon'
  )

ggplot(coupon_performance, aes(x = coupon_active, y = trade_spend_roi,
                               fill = coupon_active)) +
  geom_col() +
  coord_flip() +
  scale_y_continuous(labels = percent_format(accuracy = 1)) +
  labs(
    x = 'Active Coupon', 
    y = 'Trade Spend ROI', 
    fill = 'Active Coupon'
  )

# What kind of impact does coupon have on each product?
df
coupon_product <- df %>%
  filter(promo_active == 1) %>%
  group_by(product_id, coupon_active) %>%
  summarise(
    promos = n(),
    avg_incremental_units = mean(incremental_units),
    weighted_promo_lift_pct = sum(incremental_units)/sum(baseline_units),
    avg_trade_spend = mean(trade_spend),
    avg_net_incremental_profit = mean(net_incremental_profit),
    avg_trade_spend_roi = mean(trade_spend_roi)
  )
print(coupon_product, width = Inf)

ggplot(coupon_product, aes(x = product_id, y = weighted_promo_lift_pct, 
                           fill = coupon_active)) +
  geom_col() +
  scale_y_continuous(labels = percent_format(accuracy = 1)) +
  labs(
    title = 'Promo Lift With vs Without Active Coupon',
    x = 'Product ID',
    y = 'Weighted Promo Lift (%)',
    fill = 'Active Coupon'
  )

ggplot(coupon_product, aes(x = product_id, y = avg_trade_spend_roi,
                           fill = coupon_active)) +
  geom_col() +
  scale_y_continuous(labels = percent_format(accuracy = 1)) +
  labs(
    title = 'Trade Spend ROI With vs Without Active Coupon',
    x = 'Product ID',
    y = 'Average Trade Spend ROI',
    fill = 'Active Coupon'
  )

ggplot(df, aes(x = discount_depth, y = weighted_promo_lift_pct, 
               color = coupon_active)) +
  geom_point(size = 3, alpha = 0.8) +
  geom_smooth(method = 'lm', se = FALSE) +
  scale_x_continuous(labels = percent_format(accuracy = 1)) +
  scale_y_continuous(labels = percent_format(accuracy = 1)) +
  labs(
    title = 'Promo Lift vs Discount Depth by Active Coupon',
    x = 'Discount Depth',
    y = 'Promo Lift %',
    color = 'Coupon Support'
  )

coupon_model <- lm(weighted_promo_lift_pct ~ coupon_active + discount_depth + display_feature + 
     competitor_promo + store_traffic + product_id + retailer,
   data = df)
summary(coupon_model)


coupon_profit_model <- lm(net_incremental_profit ~ coupon_active + discount_depth + display_feature +
     competitor_promo + store_traffic + product_id + retailer, 
   data = df)

summary(coupon_profit_model)

# Are competitor promos reducing our lift?
competitor_lift <- df %>%
  group_by(competitor_promo) %>%
  summarise(
    avg_incremental_units = mean(incremental_units),
    avg_incremental_revenue = mean(incremental_revenue),
    avg_incremental_gross_profit = mean(incremental_gross_profit),
    weighted_promo_lift_pct = sum(incremental_units)/sum(baseline_units),
    avg_trade_spend = mean(trade_spend),
    avg_net_incremental_profit = mean(net_incremental_profit),
    avg_trade_spend_roi = mean(trade_spend_roi)
  )

print(competitor_lift, width = Inf)

# Promo Lift with vs without competitor promo
ggplot(competitor_lift, aes(x = competitor_promo, 
                            y = weighted_promo_lift_pct,
                            fill = competitor_promo)) +
  geom_col() +
  coord_flip() +
  scale_y_continuous(labels = percent_format(accuracy = 1)) +
  labs(
    title = 'Promo Lift With vs Without Competitor Promo',
    x = 'Competitor Promo Environment',
    y = 'Weighted Promo Lift %',
    fill = 'Competitor Promo'
  )

# Average Net Incremental Profit with vs without competitor promo
ggplot(competitor_lift, aes(x = competitor_promo, 
                            y = avg_net_incremental_profit, 
                            fill = competitor_promo)) +
  geom_col() +
  geom_hline(yintercept = 0, linetype = 'dashed') +
  labs(
    title = 'Average Net Incremental Profit With or Without Competitor Promo',
    x = 'Competitor Promo Environment',
    y = 'Average Net Incremental Profit',
    fill = 'Competitor Promo'
  )

# How do competitor-promos affect certain kinds of products?
competitor_product <- df %>%
  group_by(product_id, competitor_promo) %>%
  summarise(
    promos = n(),
    avg_incremental_units = mean(incremental_units),
    weighted_promo_lift_pct = sum(incremental_units)/sum(baseline_units),
    avg_incremental_gross_profit = mean(incremental_gross_profit),
    avg_trade_spend = mean(trade_spend),
    avg_net_incremental_profit = mean(net_incremental_profit),
    avg_trade_spend_roi = mean(trade_spend_roi)
  )

print(competitor_product, width = Inf)

# Promo Lift by Product
ggplot(competitor_product, aes(x = product_id, y = weighted_promo_lift_pct,
                               fill = competitor_promo)) +
  geom_col() +
  scale_y_continuous(labels = percent_format(accuracy = 1)) +
  labs(
    title = 'Promo Lift by Product: Competitor Promo vs No Competitor Promo',
    x = 'Product', 
    y = 'Weighted Promo Lift %',
    fill = 'Competitor Promo'
  )

# Average Net Incremental Profit by Product with Respect to Competitor Promo
ggplot(competitor_product, aes(x = product_id, y = avg_net_incremental_profit,
                               fill = competitor_promo)) +
  geom_col() +
  geom_hline(yintercept = 0, linetype = 'dashed') +
  labs(
    title = 'Average Net Incremental Profit by Product: Competitor Promo vs No Competitor Promo',
    x = 'Product', 
    y = 'Trade Spend ROI',
    fill = 'Competitor Promo'
  )

# How do Competitor Promos relate with Discount Depth when it comes to Weighted Promo Lift Pct?

ggplot(df, aes(x = discount_depth, y = weighted_promo_lift_pct, color = competitor_promo)) +
  geom_point(size = 3, alpha = 0.8) +
  geom_smooth(method = 'lm', se = FALSE) +
  scale_x_continuous(labels = percent_format(accuracy = 1)) +
  scale_y_continuous(labels = percent_format(accuracy = 1)) +
  labs(
    title = 'Promo Lift vs Discount Depth',
    x = 'Discount Depth',
    y = 'Promo Lift %',
    color = 'Competitor Promo'
  )

competitor_model <- lm(weighted_promo_lift_pct ~ competitor_promo + discount_depth + display_feature +
     coupon_active + store_traffic + product_id + retailer, 
   data = df)
summary(competitor_model)

# Which promos should we repeat, change, or stop?
df
promo_decision <- df %>%
  filter(promo_active == 1) %>%
  group_by(week, retailer, region, product_id, category) %>%
  summarise(
    incremental_units = sum(incremental_units),
    weighted_promo_lift_pct = sum(incremental_units)/sum(baseline_units),
    incremental_gross_profit = sum(incremental_gross_profit),
    trade_spend = sum(trade_spend),
    net_incremental_profit = sum(net_incremental_profit),
    trade_spend_roi = mean(trade_spend_roi),
    avg_discount_depth = mean(discount_depth),
    display_feature = max(display_feature),
    coupon_active = max(coupon_active),
    competitor_promo = max(competitor_promo)
  )

print(promo_decision, width = Inf)  

promo_decision <- promo_decision %>%
  mutate(
    recommendation = case_when(
      trade_spend_roi > 0.25 &
        net_incremental_profit > 0 &
        weighted_promo_lift_pct > 0.20 ~ 'Repeat',
      
      trade_spend_roi > 0 &
        net_incremental_profit > 0 ~ 'Change / Optimize',
      
      trade_spend_roi <= 0 |
        net_incremental_profit <= 0 ~ 'Stop / Rework',
      
      TRUE ~ 'Review'
    )
  ) %>%
  arrange(desc(trade_spend_roi))

ggplot(promo_decision, aes(x = trade_spend_roi, 
                           y = net_incremental_profit,
                           color = recommendation, 
                           size = incremental_units)) +
  geom_point(alpha = 0.85) +
  geom_vline(xintercept = 0, linetype = 'dashed') +
  geom_hline(yintercept = 0, linetype = 'dashed') +
  labs(
    title = 'Promo Decision Matrix: Repeat, Change, or Stop',
    x = 'Trade Spend ROI', 
    y = 'Net Incremental Profit',
    color = 'Recommendation',
    size = 'Incremental Units'
  )

promo_decision %>%
  mutate(
    promo_label = paste(retailer, product_id, week, sep = ' | ')
  ) %>%
  ggplot(aes(x = trade_spend_roi, y = net_incremental_profit, 
             color = recommendation, size = incremental_units,
             label = promo_label)) +
  geom_point(alpha = 0.85) +
  geom_vline(xintercept = 0, linetype = 'dashed') +
  geom_hline(yintercept = 0, linetype = 'dashed') +
  labs(
    title = 'Promo Decision Matrix with Promo Labels',
    x = 'Trade Spend ROI',
    y = 'Net Incremental Profit',
    color = 'Recommendation',
    size = 'Incremental Units'
  )
# Plot by recommendation count
promo_decision %>%
  count(recommendation) %>%
  ggplot(aes(x = recommendation, y = n, fill = recommendation)) +
  geom_col() +
  labs(
    title = 'Number of Promotions by Recommendation', 
    x = 'Recommendation', 
    y = 'Number of Promotions',
    fill = 'Recommendation'
  )

# Plot average metrics by recommendation
promo_decision %>%
  group_by(recommendation) %>%
  summarise(
    promos = n(),
    avg_promo_lift_pct = mean(weighted_promo_lift_pct),
    avg_trade_spend_roi = mean(trade_spend_roi, na.rm = TRUE),
    total_net_incremental_profit = sum(net_incremental_profit),
    total_trade_spend = sum(trade_spend),
    total_incremental_units = sum(incremental_units),
    .groups = 'drop'
  ) %>%
  ggplot(aes(x = recommendation, y = total_net_incremental_profit,
             fill = recommendation)) +
  geom_col() +
  labs(
    title = 'Total Net Incremental Profit by Promo Recommendation', 
    x = 'Recommendation', 
    y = 'Total Net Incremental Profit',
    fill = 'Recommendation'
  )

print(promo_decision, width = Inf)

promo_decision %>%
  ggplot(aes(x = avg_discount_depth, y = trade_spend_roi, 
             color = recommendation, size = net_incremental_profit)) +
  geom_point(alpha = 0.85) +
  geom_hline(yintercept = 0, linetype = 'dashed') +
  scale_x_continuous(labels = percent_format(accuracy = 1)) +
  labs(
    title = 'Discount Depth vs Trade Spend ROI',
    x = 'Average Discount Depth',
    y = 'Trade Spend ROI',
    color = 'Recommendation',
    size = 'Net Incremental Profit'
  )




























