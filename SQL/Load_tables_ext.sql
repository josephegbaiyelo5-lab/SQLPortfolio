COPY plants
FROM 'C:\SQLPortfolio\CSV_Tables\plants.csv'
DELIMITER ',' CSV HEADER;

COPY vendors
FROM 'C:\SQLPortfolio\CSV_Tables\vendors.csv'
DELIMITER ',' CSV HEADER;

COPY assets
FROM 'C:\SQLPortfolio\CSV_Tables\assets.csv'
DELIMITER ',' CSV HEADER;

COPY inventory
FROM 'C:\SQLPortfolio\CSV_Tables\inventory.csv'
DELIMITER ',' CSV HEADER;

COPY work_orders
FROM 'C:\SQLPortfolio\CSV_Tables\work_orders.csv'
DELIMITER ',' CSV HEADER;

COPY inspections
FROM 'C:\SQLPortfolio\CSV_Tables\inspections.csv'
DELIMITER ',' CSV HEADER;

COPY meter_readings
FROM 'C:\SQLPortfolio\CSV_Tables\meter_readings.csv'
DELIMITER ',' CSV HEADER;

COPY purchase_orders
FROM 'C:\SQLPortfolio\CSV_Tables\purchase_orders.csv'
DELIMITER ',' CSV HEADER;

COPY financial_transactions
FROM 'C:\SQLPortfolio\CSV_Tables\financial_transactions.csv'
DELIMITER ',' CSV HEADER;