# 🍽️ Restaurant Operations Analytics | Análisis de Operaciones en Restauración

**Author / Autor:** Jose Illescas Regalett  
**Tools / Herramientas:** SQL · Google Sheets · Looker Studio  
**Dataset:** Restaurant Sales - Dirty Data (Kaggle)  
**Status / Estado:** Completed ✅

> *"Data without context is just noise. Seven years running restaurant operations across three countries gave me the context — this project gave it a structure."*
>
> *"Los datos sin contexto son ruido. Siete años operando restaurantes en tres países me dieron el contexto — este proyecto le dio estructura."*

---

## 🇬🇧 English

### Background

I hold a degree in Mechanical Engineering from Tecnológico de Monterrey in Mexico and a Food & Beverage Management certification from George Brown College in Toronto, Canada. I have spent seven years working in high-end hospitality in New York, Toronto, and Granada — managing inventory, training staff, and coordinating operations under pressure.

This project was built at the intersection of those two worlds: analytical thinking from engineering applied to problems I have lived firsthand in restaurant operations. I did not choose this industry to appear relatable. I chose it because I understand the decisions behind the data.

### Business Questions

1. Which menu categories drive the most revenue?
2. Which items are most ordered vs. most profitable — and are they the same?
3. What revenue trend exists between 2022 and 2023?
4. How are payment methods distributed, and what does that mean for daily cash management?
5. Which high-volume items generate low value and should be reconsidered?

### Analytical Process

**1. Data Quality Assessment**

Starting with 17,535 records, I identified and documented four distinct data quality issues before modifying a single row:

| Column | Issue | Treatment |
|---|---|---|
| item | 1,758 nulls + invisible empty strings | Selective cleaning by analysis context |
| price | 876 nulls | Imputation via order_total / quantity |
| quantity + order_total | 430 simultaneous nulls | Justified removal |
| payment_method | 1,082 invisible empty strings + "0" value | Reclassified as "No registrado" |

The distinction between NULL and empty string was critical here — SQL treats them differently, and a naive `IS NOT NULL` filter would have missed over 1,000 problematic records.

**2. Data Cleaning in SQL**

Rather than modifying the source data, I created a clean view `restaurant_clean` using CASE WHEN logic to handle each data quality issue specifically. This preserves the original dataset while enabling reliable analysis downstream.

Final clean dataset: **17,104 records**.

**3. Exploratory Analysis**

Five SQL queries addressing each business question, with documented reasoning behind every filter, aggregation, and join decision.

**4. Dashboard — Looker Studio**

Executive-level dashboard with three KPI scorecards, revenue by category bar chart, monthly trend line chart, and top 10 items table.

### Key Findings

- **Main Dishes** generates nearly 3x more revenue than the next category at similar order volume — the margin gap is structural, not accidental
- **Grilled Chicken** has the highest average ticket (45.47) with strong order frequency — an underleveraged asset in menu positioning and upselling
- **Water and Coca Cola** rank in the top 5 by order count but generate minimal revenue — classic high-volume, low-value items that occupy inventory, staff time, and menu real estate
- **2022 consistently outperformed 2023** across all months — a trend that warrants investigation in a real operational context
- **6% of transactions have no payment method recorded** — a data capture failure that creates reconciliation work at end-of-shift and masks true payment behavior

### What I Would Do With Real Data

This analysis was built on a public dataset. Applied to actual restaurant data, I would extend it to include ingredient-level demand forecasting to prevent stockouts, staff performance analysis by shift to identify peak service periods and align team composition with actual demand patterns, and real margin analysis incorporating supplier costs — the problems I observe daily in restaurant operations.

---

## 🇪🇸 Español

### Contexto

Soy ingeniero mecánico egresado del Tecnológico de Monterrey en México con certificación en Food & Beverage Management por George Brown College en Toronto, Canadá. Llevo siete años trabajando en hostelería de alto nivel en Nueva York, Toronto y Granada — gestionando inventarios, formando personal y coordinando operaciones bajo presión.

Este proyecto nació en la intersección de esos dos mundos: el razonamiento analítico de la ingeniería aplicado a problemas que he vivido de primera mano en operaciones de restaurante. No elegí este sector para resultar cercano. Lo elegí porque entiendo las decisiones que hay detrás de los datos.

### Preguntas de Negocio

1. ¿Qué categorías de carta generan más ingresos?
2. ¿Qué ítems se piden más versus cuáles son más rentables — y coinciden?
3. ¿Qué tendencia de ingresos existe entre 2022 y 2023?
4. ¿Cómo se distribuyen los métodos de pago y qué implica para la gestión de caja diaria?
5. ¿Qué ítems de alto volumen generan bajo valor y deberían revisarse?

### Proceso Analítico

**1. Diagnóstico de Calidad de Datos**

Partiendo de 17,535 r
