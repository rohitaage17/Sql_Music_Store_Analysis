select * from track
select * from Invoice_line
select * from artist
select * from album
select * from genre
select * from employee
select * from customer

/*1.Top 10 most purchased tracks*/
SELECT top 10 t.Name AS Track, COUNT(il.Track_Id) AS PurchaseCount
FROM Invoice_Line as il
JOIN Track t ON il.Track_Id = t.Track_Id
GROUP BY t.Name
ORDER BY PurchaseCount DESC

/*2.Top 5 best-selling artists*/
SELECT top 5 ar.Name AS Artist, COUNT(il.Invoice_Line_Id) AS TotalSales
FROM Invoice_Line il
JOIN Track t ON il.Track_Id = t.Track_Id
JOIN Album al ON t.Album_Id = al.Album_Id
JOIN Artist ar ON al.Artist_Id = ar.Artist_Id
GROUP BY ar.Name
ORDER BY TotalSales DESC


/*3.Revenue by Genre*/
SELECT g.Name AS Genre, SUM(il.Unit_Price * il.Quantity) AS Revenue
FROM Invoice_Line il
JOIN Track t ON il.Track_Id = t.Track_Id
JOIN Genre g ON t.Genre_Id = g.Genre_Id
GROUP BY g.Name
ORDER BY Revenue DESC;

/*4.Top 3 countries by revenue*/
SELECT top 3 c.Country, SUM(i.Total) AS Revenue
FROM Invoice i
JOIN Customer c ON i.Customer_Id = c.Customer_Id
GROUP BY c.Country
ORDER BY Revenue DESC


/*5.Which customers spent the most?*/
SELECT TOP 10 c.First_Name + ' ' + c.Last_Name AS Customer,SUM(i.Total) AS TotalSpent
FROM Invoice i
JOIN Customer c ON i.Customer_Id = c.Customer_Id
GROUP BY c.First_Name, c.Last_Name
ORDER BY TotalSpent DESC;

/*6.Average invoice value per country*/
SELECT c.Country, AVG(i.Total) AS AvgInvoice
FROM Invoice i
JOIN Customer c ON i.Customer_Id = c.Customer_Id
GROUP BY c.Country
ORDER BY AvgInvoice DESC;

/*7.Employees with most sales (support agents)*/
SELECT e.First_Name + ' ' + e.Last_Name AS Employee,SUM(i.Total) AS TotalSales
FROM Invoice i
JOIN Customer c ON i.Customer_Id = c.Customer_Id
JOIN Employee e ON c.Support_Rep_Id = e.Employee_Id
GROUP BY e.First_Name, e.Last_Name
ORDER BY TotalSales DESC;

/*8.Top 5 customers by number of invoices*/
SELECT TOP 5 c.First_Name + ' ' + c.Last_Name AS Customer,COUNT(i.Invoice_Id) AS InvoiceCount
FROM Customer c
JOIN Invoice i ON c.Customer_Id = i.Customer_Id
GROUP BY c.First_Name, c.Last_Name
ORDER BY InvoiceCount DESC;

/*9.Find the top-selling album*/
SELECT top 1 al.title AS album, ar.Name AS artist, SUM(il.Quantity) AS TotalSold
FROM Invoice_Line il
JOIN track t ON il.track_Id = t.track_Id
JOIN album al ON t.album_Id = al.album_Id
JOIN artist ar ON al.artist_Id = ar.artist_Id
GROUP BY al.title, ar.Name
ORDER BY TotalSold DESC

/*10.Top 3 genres by sales in the USA*/
SELECT top 3 g.Name AS Genre, SUM(il.Quantity) AS TotalSold
FROM Invoice_Line il
JOIN Invoice i ON il.Invoice_Id = i.Invoice_Id
JOIN Customer c ON i.Customer_Id = c.Customer_Id
JOIN Track t ON il.Track_Id = t.Track_Id
JOIN Genre g ON t.Genre_Id = g.Genre_Id
WHERE c.Country = 'USA'
GROUP BY g.Name
ORDER BY TotalSold DESC

