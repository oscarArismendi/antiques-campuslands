# antiques-campuslands
 This project is an antique marketplace platform that manages users, roles, permissions, transactions, and inventory, with features for tracking price history and delivery statuses, built on PostgreSQL.

 ## Queries

## ** 1) Query to list all antiques available for sale:**

Get a list of all antique items that are currently available for sale, including the name of the piece, its category, price, and condition.

### SQL Function

To get antiques that are currently available for sale and marked as "In Stock," you can use the following SQL function. This function retrieves antiques from the database along with their names, categories, prices, conditions, and availability statuses.

### SQL Function Definition

```sql
DROP FUNCTION IF EXISTS GetAvailableAntiques();
-- Create a function to return antiques that are "In Stock"
CREATE OR REPLACE FUNCTION GetAvailableAntiques()
RETURNS TABLE (
    antique_name VARCHAR,
    category VARCHAR,
    price NUMERIC,
    condition VARCHAR,
    availability VARCHAR
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        a.name AS antique_name,
        a.category AS category,
        a.price AS price,
        c.state AS condition,
        av.name AS availability
    FROM
        Antiques a
    JOIN
        Conditions c ON a.condition_id = c.id
    JOIN
        Inventory i ON a.id = i.antique_id
    JOIN
        Availabilities av ON a.availability_id = av.id
    WHERE
        i.available_quantity > 0
        AND av.name = 'In Stock';  -- Filter for "In Stock" availability
END;
$$ LANGUAGE plpgsql;

```

Result:
```sql
-- Call the function to get available antiques
SELECT antique_name,category,price,condition,availability FROM GetAvailableAntiques();

  antique_name   | category  | price  | condition | availability
-----------------+-----------+--------+-----------+--------------
 Victorian Chair | Furniture | 150.00 | New       | In Stock
(1 row)
```

## ** 2) Query to search antiques by category and price range:**

Search for all antiques within a specific category (e.g., 'Furniture') that have a price within a given range (e.g., between $500 and $2000).

### SQL Function

This function provides a way to search for antiques based on their category and price range

### SQL Function Definition

```sql
DROP FUNCTION IF EXISTS SearchAntiquesByCategoryAndPrice(VARCHAR, NUMERIC, NUMERIC);
-- Create a function to search antiques by category and price range
CREATE OR REPLACE FUNCTION SearchAntiquesByCategoryAndPrice(
    category_in VARCHAR,
    min_price NUMERIC,
    max_price NUMERIC
)
RETURNS TABLE (
    antique_name VARCHAR,
    category VARCHAR,
    price NUMERIC,
    condition VARCHAR,
    availability VARCHAR
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        a.name AS antique_name,
        a.category AS category,
        a.price AS price,
        c.state AS condition,
        av.name AS availability
    FROM
        Antiques a
    JOIN
        Conditions c ON a.condition_id = c.id
    JOIN
        Inventory i ON a.id = i.antique_id
    JOIN
        Availabilities av ON a.availability_id = av.id
    WHERE
        a.category = category_in
        AND a.price BETWEEN min_price AND max_price;
END;
$$ LANGUAGE plpgsql;

```

Result:
```sql
-- Example usage of the function
SELECT antique_name,category,price,condition,availability FROM SearchAntiquesByCategoryAndPrice('Furniture', 100, 2000);

  antique_name   | category  | price  | condition | availability
-----------------+-----------+--------+-----------+--------------
 Victorian Chair | Furniture | 150.00 | New       | In Stock
 Colonial Desk   | Furniture | 600.00 | Poor      | Coming Soon
(2 rows)

```

## ** 3) Query to show the sales history of a specific client:**

Show all antique pieces that a specific client has sold, including the sale date, sale price, and buyer

### SQL Function

The following SQL function retrieves the sales history for a specific client. It takes a client_id as a parameter and returns details of all antiques sold by that client, including the sale date, sale price, and buyer.

### SQL Function Definition

```sql
DROP FUNCTION IF EXISTS GetClientSalesHistory(BIGINT);
-- Create a function to show the sales history of a specific client with seller/buyer indicator
CREATE OR REPLACE FUNCTION GetClientSalesHistory(client_id BIGINT)
RETURNS TABLE (
    antique_name VARCHAR,
    sale_date TIMESTAMP WITH TIME ZONE,
    sale_price NUMERIC,
    buyer_username VARCHAR,
    role TEXT  -- New column to indicate if the client was the buyer or seller
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        a.name AS antique_name,
        t.transaction_date AS sale_date,
        t.sale_price AS sale_price,
        u.username AS buyer_username,
        CASE 
            WHEN t.buyer_id = c.user_id THEN 'Buyer'
            WHEN a.seller_id = c.user_id THEN 'Seller'
            ELSE 'Unknown'  -- This case shouldn't occur with proper data
        END AS role
    FROM
        Transactions t
    JOIN
        Antiques a ON t.antique_id = a.id
    JOIN
        Users u ON t.buyer_id = u.id
    JOIN
        Clients c ON t.buyer_id = c.user_id OR a.seller_id = c.user_id
    WHERE
        c.id = client_id;
END;
$$ LANGUAGE plpgsql;



```

Result:
```sql
-- Example usage of the function
SELECT antique_name,sale_date,sale_price,buyer_username,role FROM GetClientSalesHistory(1);

  antique_name   |           sale_date           | sale_price | buyer_username | role
-----------------+-------------------------------+------------+----------------+-------
 Victorian Chair | 2024-09-17 20:22:40.297169-05 |     150.00 | john_doe       | Buyer
(1 row)


```

## ** 4) Query to obtain the total sales made within a specific time period: **

Calculates the total sales made during a specific period, for example, over the last month.

### SQL Function

This function allows you to calculate the total sales within a specified date range by providing the start and end dates. You can call it with appropriate timestamp values to get the total sales amount.

### SQL Function Definition

```sql
-- Drop the function if it exists
DROP FUNCTION IF EXISTS CalculateTotalSalesInPeriod(TIMESTAMP , TIMESTAMP );

-- Create the function to calculate total sales in a specific time period
CREATE OR REPLACE FUNCTION CalculateTotalSalesInPeriod(start_date TIMESTAMP , end_date TIMESTAMP )
RETURNS NUMERIC AS $$
DECLARE
    total_sales NUMERIC;
BEGIN
    SELECT
        SUM(t.sale_price) INTO total_sales
    FROM
        Transactions t
    WHERE
        t.transaction_date BETWEEN start_date AND end_date;

    RETURN COALESCE(total_sales, 0);  -- Return 0 if there are no sales
END;
$$ LANGUAGE plpgsql;




```

Result:
```sql
-- Example usage of the function
-- SELECT CalculateTotalSalesInPeriod('2024-09-01 00:00:00', '2024-09-17 21:50:59') AS total_sales;
-- Example call to CalculateTotalSalesInPeriod function using NOW() with explicit casting
SELECT CalculateTotalSalesInPeriod(
    (NOW() - INTERVAL '1 month')::TIMESTAMP,
    NOW()::TIMESTAMP
) AS total_sales;

 total_sales
-------------
    18600.00
(1 row)

```
