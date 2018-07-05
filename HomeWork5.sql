*1. What are the prodid of the products whose name begins with a 'p' and

worth less than $300.00?*/



SELECT prodid FROM product WHERE pname LIKE 'p%' AND price<=300.00;



/*2. Names of the products stocked in 'd2'.

(a) without in/not in

(b) with in/not in*/



SELECT pname FROM  product, stock WHERE product.prodid = stock.prodid

AND stock.depid = 'd2';



SELECT prodid FROM product WHERE prodid IN (SELECT prodid FROM stock WHERE

depid = 'd2');



/*3. prodid and pname of the products that are out of stock.

(a) without in/not in

(b) with in/not in*/



SELECT prodid, pname FROM product, stock WHERE product.prodid = stock.prodid

AND stock.quantity <= 0;



SELECT prodid, pname FROM product WHERE prodid IN (SELECT prodid  FROM

stock WHERE quantity <= 0);



/*4. Addresses of the depots where the product 'p1' is stocked.

(a) without exists/not exists and without in/not in

(b) with in/not in

(c) with exists/not exists*/



SELECT d.depid, d.addr FROM depot d, stock s WHERE s.prodid = 'p1'  AND

s.depid = d.depid



SELECT d.depid, d.addr FROM depot d WHERE d.depid IN (SELECT s.depid  FROM

stock WHERE s.prodid = 'p1')



SELECT d.depid, d.addr FROM depot d WHERE EXISTS (SELECT * FROM stock  WHERE

s.prodid = 'p1' AND s.depid = d.depid)



/*5. prodids of the products whose price is between $250.00 and $400.00.

(a) using intersect.

(b) without intersect.*/



SELECT prodid FROM product WHERE price >= 250 INTERSECT SELECT prodid

FROM product WHERE price <= 400.0



SELECT prodid FROM product WHERE price >= 250 AND price <= 400.0



/*6. How many products are out of stock?*/

SELECT COUNT(*) FROM stock WHERE quantity <= 0



/*7. Average of the prices of the products stocked in the 'd2' depot.*/



SELECT avg(price) FROM depot d, stock s, product p WHERE d.depid = s.depid

AND s.prodid = p.prodid



/*8. depids of the depots with the largest capacity (volume).*/



SELECT depid, addr FROM depot WHERE volume in (SELECT max(volume)  FROM

depot)



/*9. Sum of the stocked quantity of each product.*/



SELECT prodid, sum(quantity) FROM stock WHERE quantity > 0 GROUP BY

prodid



/*10. Prodids of the products stocked in at least 3 depots.

(a) using count

(b) without using count*/



SELECT prodid FROM stock GROUP BY prodid HAVING COUNT(*) > 2



SELECT s1.prodid FROM stock s1, stock s2, stock s3 WHERE s1.prodid = s2.prodid

AND s1.prodid = s3.prodid AND s1.depid <> s2.depid AND s1.depid <>

s3.depid AND s2.depid <> s3.depid



/*11. prodids of the products stocked in all depots.

(a) using count

(b) using exists/not exists*/



SELECT prodid FROM stock GROUP BY prodid HAVING COUNT(*) = (SELECT COUNT(*)

FROM depot)



SELECT prodid FROM stock s WHERE NOT EXISTS (SELECT * FROM depot d  WHERE

NOT EXISTS (SELECT * FROM stock WHERE s.prodid = p.prodid AND s.depid =

d.depid))