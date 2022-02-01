-- Все клиенты с МастерКард
SELECT cust_name
FROM customer_info
INNER JOIN order_body USING(cust_id)
INNER JOIN transakt USING(trans_id)
INNER JOIN card USING(card_id)
WHERE card_type LIKE 'MasterCard%';


-- Все отзывы с 2019 года по жанру Научная литература 
SELECT review
FROM review
INNER JOIN book_review USING(review_id)
INNER JOIN book USING(book_id)
INNER JOIN book_genre USING(book_id)
INNER JOIN genre USING(genre_id)
WHERE DATE_TRUNC('year', review_date) > 2019 AND genre_name = 'Научная литература'; 
ORDER BY review_date DESC;


-- Все книги, которые соответствуют более чем одному жанру
SELECT name
FROM book
WHERE book.book_id IN (           
/*подзапрос выбирает book_id которым соответствет более genre_id*/
	SELECT book_id                    
	FROM book_genre
	GROUP BY book_id HAVING COUNT(genre_id) > 1) 
