-- ================================================
-- Restaurant Operations Analytics
-- Autor: Jose Illescas Regalett
-- Dataset: Restaurant Sales - Dirty Data (Kaggle)
-- ================================================


-- ------------------------------------------------
-- EXPLORACIÓN INICIAL
-- ------------------------------------------------

-- Vista general del dataset
SELECT *
FROM restaurant_sales_data
LIMIT 10;

-- Total de filas
SELECT COUNT(*) AS total_filas
FROM restaurant_sales_data;

-- Estructura de la tabla
PRAGMA table_info(restaurant_sales_data);

-- Verificación de nulos y strings vacíos por columna
SELECT COUNT(*) AS nulos_order_id FROM restaurant_sales_data WHERE order_id IS NULL OR order_id = '';
SELECT COUNT(*) AS nulos_customer_id FROM restaurant_sales_data WHERE customer_id IS NULL OR customer_id = '';
SELECT COUNT(*) AS nulos_category FROM restaurant_sales_data WHERE category IS NULL OR category = '';
SELECT COUNT(*) AS nulos_item FROM restaurant_sales_data WHERE item IS NULL OR item = '';
SELECT COUNT(*) AS nulos_price FROM restaurant_sales_data WHERE price IS NULL;
SELECT COUNT(*) AS nulos_quantity FROM restaurant_sales_data WHERE quantity IS NULL;
SELECT COUNT(*) AS nulos_order_total FROM restaurant_sales_data WHERE order_total IS NULL;
SELECT COUNT(*) AS nulos_order_date FROM restaurant_sales_data WHERE order_date IS NULL OR order_date = '';
SELECT COUNT(*) AS nulos_payment_method FROM restaurant_sales_data WHERE payment_method IS NULL OR payment_method = '';

-- Valores distintos en payment_method (detectar valores inesperados)
SELECT DISTINCT payment_method, LENGTH(payment_method) AS longitud
FROM restaurant_sales_data
ORDER BY longitud;


-- ------------------------------------------------
-- LIMPIEZA Y TRANSFORMACIÓN
-- ------------------------------------------------

-- Vista limpia con tratamiento de cada problema de calidad
-- Decisiones:
-- 1. item vacío → NULL (limpieza selectiva por análisis)
-- 2. price nulo → calculado como order_total / quantity
-- 3. quantity y order_total nulos → eliminados con WHERE
-- 4. payment_method vacío o "0" → "No registrado"
-- 5. Columna mes extraída de order_date para análisis temporal

CREATE VIEW restaurant_clean AS
SELECT
    order_id,
    customer_id,
    category,
    CASE WHEN item IS NULL OR TRIM(item) = '' THEN NULL
         ELSE item END AS item,
    CASE WHEN price IS NULL AND quantity IS NOT NULL AND order_total IS NOT NULL
         THEN ROUND(order_total / quantity, 2)
         ELSE price END AS price,
    quantity,
    order_total,
    order_date,
    SUBSTR(order_date, 1, 7) AS mes,
    CASE WHEN payment_method IS NULL
              OR TRIM(payment_method) = ''
              OR payment_method = '0'
         THEN 'No registrado'
         ELSE payment_method END AS payment_method
FROM restaurant_sales_data
WHERE quantity IS NOT NULL
AND order_total IS NOT NULL;

-- Verificación del dataset limpio
SELECT COUNT(*) AS total_filas_limpias
FROM restaurant_clean;


-- ------------------------------------------------
-- ANÁLISIS EXPLORATORIO
-- ------------------------------------------------

-- CONSULTA 1: Ingresos totales por categoría
-- Pregunta: ¿Qué categorías generan más ingresos?
SELECT
    category,
    COUNT(*) AS total_ordenes,
    ROUND(SUM(order_total), 2) AS ingresos_totales,
    ROUND(AVG(order_total), 2) AS ticket_medio
FROM restaurant_clean
WHERE order_total IS NOT NULL
GROUP BY category
ORDER BY ingresos_totales DESC;


-- CONSULTA 2: Top 10 ítems más vendidos
-- Pregunta: ¿Cuáles son los ítems más vendidos y cuánto ingreso generan?
SELECT
    item,
    COUNT(*) AS veces_pedido,
    ROUND(SUM(order_total), 2) AS ingresos_totales,
    ROUND(AVG(order_total), 2) AS precio_promedio
FROM restaurant_clean
WHERE item IS NOT NULL
AND item != ''
AND order_total IS NOT NULL
GROUP BY item
ORDER BY veces_pedido DESC
LIMIT 10;


-- CONSULTA 3: Top 15 días por ingreso
-- Pregunta: ¿Cuáles son los días de mayor facturación?
SELECT
    order_date,
    COUNT(*) AS total_ordenes,
    ROUND(SUM(order_total), 2) AS ingresos_dia
FROM restaurant_clean
WHERE order_total IS NOT NULL
GROUP BY order_date
ORDER BY ingresos_dia DESC
LIMIT 15;


-- CONSULTA 4: Ingresos por mes
-- Pregunta: ¿Qué tendencia de ingresos existe entre 2022 y 2023?
SELECT
    SUBSTR(order_date, 1, 7) AS mes,
    COUNT(*) AS total_ordenes,
    ROUND(SUM(order_total), 2) AS ingresos_mes,
    ROUND(AVG(order_total), 2) AS ticket_medio_mes
FROM restaurant_clean
WHERE order_total IS NOT NULL
AND order_date IS NOT NULL
GROUP BY mes
ORDER BY mes ASC;


-- CONSULTA 5: Análisis de métodos de pago
-- Pregunta: ¿Cómo pagan los clientes y qué método genera mayor ticket medio?
SELECT
    payment_method,
    COUNT(*) AS total_ordenes,
    ROUND(SUM(order_total), 2) AS ingresos_totales,
    ROUND(AVG(order_total), 2) AS ticket_medio
FROM restaurant_clean
WHERE order_total IS NOT NULL
GROUP BY payment_method
ORDER BY ingresos_totales DESC;
