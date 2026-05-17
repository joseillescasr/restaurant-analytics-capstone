# 🍽️ Análisis de Rentabilidad y Eficiencia Operativa — Restaurante

**Autor:** Jose Illescas Regalett  
**Herramientas:** SQL · Google Sheets · Looker Studio  
**Dataset:** Restaurant Sales - Dirty Data (Kaggle)  
**Estado:** Completado ✅

---

## 📋 Descripción del Proyecto

Análisis end-to-end de operaciones de restauración desarrollado como Capstone del Google Data Analytics Professional Certificate. El proyecto simula el rol de un analista BI junior analizando la rentabilidad, eficiencia operativa y patrones de demanda de un restaurante.

---

## 🎯 Preguntas de Negocio

1. ¿Qué categorías de platos generan más ingresos?
2. ¿Cuáles son los ítems más vendidos y más rentables?
3. ¿Qué tendencia de ingresos existe entre 2022 y 2023?
4. ¿Cómo se distribuyen los métodos de pago?
5. ¿Qué ítems tienen mayor volumen pero menor valor?

---

## 🔧 Proceso Analítico

### 1. Diagnóstico de Calidad de Datos
- 17,535 filas analizadas
- Nulos identificados: Item (10%), Payment Method (6%), Price (5%)
- Strings vacíos detectados en payment_method

### 2. Limpieza y Transformación
- Eliminación de 431 filas con quantity y order_total nulos
- Imputación de price mediante order_total / quantity
- Clasificación de métodos de pago no registrados
- Vista limpia creada: restaurant_clean (17,104 filas)

### 3. Análisis SQL
- Ingresos por categoría
- Top 10 ítems más vendidos
- Tendencia mensual de ingresos
- Análisis de métodos de pago

### 4. Dashboard en Looker Studio
- 3 KPIs principales (Ingresos, Órdenes, Ticket Medio)
- Gráfico de barras por categoría
- Tendencia de ingresos mensual
- Tabla Top 10 ítems

---

## 📊 Hallazgos Principales

- **Main Dishes** genera 7x más ingresos que Drinks con volumen similar
- **Grilled Chicken** tiene el ticket promedio más alto (45.47)
- **Water y Coca Cola** tienen alto volumen pero bajo valor — candidatos a revisión de carta
- Los ingresos de **2022 superaron a 2023** levemente — tendencia a monitorear
- El **6% de transacciones** no tienen método de pago registrado

---

## 🔗 Dashboard

[Ver Dashboard en Looker Studio](#) ← *agregar link aquí*

---

## 📁 Estructura del Repositorio

```
├── README.md
├── sql/
│   └── queries.sql
└── data/
    └── restaurant_clean.csv
```
