-- Вывести имя, фамилию покупателей и даты их заказов(order_date).
select customers.CUST_FIRST_NAME, customers.CUST_LAST_NAME, orders.ORDER_DATE
from customers
join orders
on customers.CUSTOMER_ID = orders.CUSTOMER_ID;

-- Вывести даты заказов продуктов и описание этих продуктов(product_description).
select orders.ORDER_DATE, product_information.PRODUCT_DESCRIPTION
from orders
join order_items
on orders.ORDER_ID = order_items.ORDER_ID
join product_information
on product_information.PRODUCT_ID = order_items.PRODUCT_ID;

-- or this ???
select ORDER_DATE
from orders
union
select PRODUCT_DESCRIPTION
from product_information;

-- Вывести имя, фамилию покупателей, даты заказов(orderdate), описание продуктов, 
-- которые они заказали и категории соответствующих продуктов (categoryname).
select customers.CUST_FIRST_NAME, customers.CUST_LAST_NAME, orders.ORDER_DATE, product_information.PRODUCT_DESCRIPTION,
product_information.CATEGORY_ID, categories_tab.CATEGORY_NAME
from orders
left join customers
on orders.CUSTOMER_ID = customers.CUSTOMER_ID
join order_items
on orders.ORDER_ID = order_items.ORDER_ID
left join product_information
on product_information.PRODUCT_ID = order_items.PRODUCT_ID
left join categories_tab
on product_information.CATEGORY_ID = categories_tab.CATEGORY_ID;

-- Вывести названия(productname), описания категорий(categorydescription) и количества(quantity) 
-- тех продуктов, у которых минимальная стоимость (min_price) больше 300.
select product_information.PRODUCT_NAME, categories_tab.CATEGORY_DESCRIPTION, order_items.QUANTITY, 
product_information.MIN_PRICE
from product_information
join categories_tab
on product_information.CATEGORY_ID = categories_tab.CATEGORY_ID
join order_items
on product_information.PRODUCT_ID = order_items.PRODUCT_ID
where product_information.MIN_PRICE > 300;

-- Вывести имя, фамилию всех женатых мужчин покупателей, которые купили продукты со стоимостью (list_price) больше 550.
select customers.CUST_FIRST_NAME, customers.CUST_LAST_NAME, customers.MARITAL_STATUS, customers.GENDER, 
product_information.LIST_PRICE
from orders
right join customers
on orders.CUSTOMER_ID = customers.CUSTOMER_ID
right join order_items
on orders.ORDER_ID = order_items.ORDER_ID
right join product_information
on order_items.PRODUCT_ID = product_information.PRODUCT_ID
where customers.MARITAL_STATUS = "married" and customers.GENDER = "M" and product_information.LIST_PRICE > 550;

-- Вывести те продукты(productname), которых нет в заказанных (таблица orderitems).
select product_information.PRODUCT_NAME, order_items.ORDER_ID
from product_information
left join order_items
on product_information.PRODUCT_ID = order_items.PRODUCT_ID
where order_items.ORDER_ID is null;

-- Вывести покупателей(custfirstname, custlastname), которые ничего не заказали (таблица orders).
select customers.CUST_FIRST_NAME, customers.CUST_LAST_NAME, orders.ORDER_ID
from customers
left join orders
on customers.CUSTOMER_ID = orders.CUSTOMER_ID
where orders.ORDER_ID is null;