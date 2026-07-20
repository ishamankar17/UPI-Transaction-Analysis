# 💳 UPI Transaction Analysis Dashboard

End-to-end Data Analytics project analyzing **250,000+ UPI transactions** using **SQL, Python, Excel, and Power BI**, combined with state-wise GDP, population, and NPCI monthly stats.

---

## 📂 Repository Structure
```
UPI-Transaction-Analysis/
│
├── Dataset/
├── SQL Scripts/
├── EDA/
│   └── UPI_Transactions_2024_EDA.ipynb
├── PowerBI/
│   └── UPI_Transaction_Analysis.pbix
└── README.md
```

## 🛠 Tools & Technologies
Oracle SQL · Power BI · Python (Pandas, NumPy, Matplotlib) · Excel · Git & GitHub

## 📊 Dashboard Pages
1. **Executive Overview** – KPIs, monthly trends, top states
2. **Transaction & Customer Analysis** – type, merchant, device, network, age, weekday/weekend, hourly trends
3. **State Performance** – interactive map, rankings, top/bottom states
4. **Economic Insights** – GDP & population vs transactions
5. **NPCI Growth & Fraud** – volume/value trends, banks live, fraud analysis, recommendations

## 📈 Key KPIs
Total Transactions · Total Amount · Avg Transaction Amount · Success/Failure/Fraud Rate · UPI Volume & Value · Banks Live on UPI

## 📌 Dataset Summary
| Dataset | Records |
|---------|---------|
| UPI Transactions | 250,000 |
| Monthly NPCI Statistics | 12 Months |
| State GDP & Population | 28 States |

## 🧩 Data Model

Star schema with a central fact table and supporting dimensions:

- **Fact_Transactions** — 250K UPI transactions (amount, status, timestamp, IDs)
- **Dim_State** — state name, region, GDP, population
- **Dim_Date** — calendar table for time intelligence (MTD, YoY, weekday/weekend)
- **Dim_Bank / Dim_Device / Dim_Merchant** — lookup dimensions for segmentation

**Key relationships:**
- `Fact_Transactions[sender_state] → Dim_State[state]` (many-to-one)
- `Fact_Transactions[date] → Dim_Date[date]` (many-to-one)

Sender and receiver state both link to `Dim_State`, so an inactive/second 
relationship handles receiver-side analysis — avoided duplicating the 
dimension table and kept the model single-directional to prevent 
circular references.

## 📸 Dashboard Preview

**Page 1 – Executive Overview**
<img width="1325" height="743" alt="image" src="https://github.com/user-attachments/assets/afc827aa-8417-4dc2-b93f-6d3b2e4168d8" />


**Page 2 – Transaction & Customer Analysis**
<img width="1313" height="745" alt="image" src="https://github.com/user-attachments/assets/b202b28b-5588-45c2-96eb-3f4699d3f037" />

**Page 3 – State Performance**
<img width="1322" height="746" alt="image" src="https://github.com/user-attachments/assets/cdae6c5a-63b2-4286-b31d-c928fad3f435" />


**Page 4 – Economic Insights**
<img width="1320" height="737" alt="image" src="https://github.com/user-attachments/assets/b55a254d-72b3-465d-aca5-5330f672cd63" />


**Page 5 – NPCI Growth & Fraud**
<img width="1326" height="742" alt="image" src="https://github.com/user-attachments/assets/387ffdcf-45e8-4f6d-89b1-06887f412368" />


## 🚀 Skills Demonstrated
Data Cleaning · Data Modeling · SQL Joins & Window Functions · DAX · KPI Development · Interactive Dashboard Design · EDA

---
**Data Analyst | SQL | Power BI | Python | Excel**
