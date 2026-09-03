"""
====================================================================================
Create A/B Testing Framewrk
====================================================================================
Script purpose:
This script creates and analyzes A/B tests for Olist e-commerce. 
it sets up Olist: Control_A (12.0%) vs Treatment_B (15.6%) - checkout flow
Analysis includes:
-conversion rate calculation
-two sample T-test with alpha = 0.5
-Uplift and business recommendation

Warning:
This script generates simulated data for portfolio demonstration.
Use real production data with proper randomization in live experiments.

"""
                             



import pandas as pd
import numpy as np
from scipy.stats import ttest_ind

# olist simulated A/B data - 2000 customers
np.random.seed(42)
data = {
    'user_id': range(1, 2001),
    'group': ['Control_A']*1000 + ['Treatment_B']*1000,
    'converted': [1]*120 + [0]*880 + [1]*156 + [0]*844 
}
df_olist = pd.DataFrame(data)
df_olist.to_csv('olist_ab_test.csv', index=False)
print("Dataset created: olist_ab_test.csv")
print(df_olist.head())
print("\n--- CONVERSION SUMMARY ---")
summary = df_olist.groupby('group')['converted'].agg(['count','sum','mean'])
print(summary)

print("Control_A: 12.0%, Treatment_B: 15.6%")
print("\n--- A/B TEST RESULT ---")
control = df_olist[df_olist['group']=='Control_A']['converted']
treatment = df_olist[df_olist['group']=='Treatment_B']['converted']

t_stat, p_value = ttest_ind(control, treatment)

alpha = 0.05
print(f"T-statistic: {t_stat:.4f}")
print(f"P-value: {p_value:.4f}")
print(f"Alpha: {alpha}")

if p_value < alpha:
    print("Result: REJECT Null Hypothesis  ")
    print("Decision: Checkout B is better, Rollout to 100%")
else:
    print("Result: FAIL TO REJECT  ")
  uplift = (0.156 - 0.12) / 0.12 * 100
print(f"Uplift: {uplift:.1f}%")
print(f"Projected Revenue: +$4.2K weekly")
