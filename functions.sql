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
