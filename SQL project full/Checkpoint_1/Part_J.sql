/**TODO 1: Find the revenue generated till date from the rented out vehicles of type car. The returned table should contain only 1 row and 
1 column and the column should be named as “Revenue by Car”**/
SELECT SUM(B.amount) AS "Revenue by Car" 
FROM booking B 
WHERE B.vehicle_id IN (
  SELECT V.vehicle_id FROM vehicle V 
  WHERE V.vehicle_subcategory_id IN (
   SELECT VS.vehicle_subcategory_id 
   FROM vehicle_subcategory VS 
   WHERE VS.vehicle_category_id = (
    SELECT VC.vehicle_category_id 
    FROM vehicle_category VC 
    WHERE VC.vehicle_category_name = 'CAR')));