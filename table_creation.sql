use warehouse retail_sales_wh;
use database retail_sales_db;

-- create customers table in raw_schema
create or replace table raw_schema.customers
(
    id int not null,
    first_name varchar(100) not null,
    last_name varchar(100),
    email varchar(250) not null,
    gender varchar(20) not null,
    city varchar(100) not null,
    country varchar(100) not null,
    date_of_birth date not null,
    signup_date date not null,
    created_at timestamp default current_timestamp(),
    updated_at timestamp default current_timestamp(),
    created_by varchar default current_user(),
    updated_by varchar default current_user(),
    -- constraints
    constraint pk_customers primary key(id),
    constraint uq_customers_email unique(email)
)
comment = 'Customers master data';

-- create category table in raw schema
create or replace table raw_schema.category
(
    id int not null,
    category_name varchar(100) not null,
    created_at timestamp default current_timestamp(),
    updated_at timestamp default current_timestamp(),
    created_by varchar default current_user(),
    updated_by varchar default current_user(),
    -- constraints
    constraint pk_category primary key(id),
    constraint uq_category_name unique(category_name)
)
comment = 'Category master data';

-- create suppliers table in raw schema 
create or replace table raw_schema.suppliers
(
    id int not null,
    supplier_name varchar(100) not null,
    contact_person varchar(100) not null,
    email varchar(100) not null,
    phone varchar(100) not null,
    created_at timestamp default current_timestamp(),
    updated_at timestamp default current_timestamp(),
    created_by varchar default current_user(),
    updated_by varchar default current_user(),
    -- contrainst
    constraint pk_suppliers primary key(id),
    constraint uq_supplier_name unique(supplier_name),
    constraint uq_phone unique(phone)
)
comment = 'Suppliers master data';

-- create products table in raw schema
create or replace table raw_schema.products
(
    id int not null,
    category_id int not null,
    product_name varchar(100) not null,
    retail_price decimal(10, 2) not null,
    supplier_price decimal(10, 2) not null,
    stock_quantity int not null,
    created_at timestamp default current_timestamp(),
    updated_at timestamp default current_timestamp(),
    created_by varchar default current_user(),
    updated_by varchar default current_user(),
    -- constraints
    constraint pk_product primary key(id),
    constraint fk_category_id foreign key(category_id)
        references raw_schema.category(id)
)
comment = 'Products master data';

-- create orders table in raw schema 
create or replace table raw_schema.orders
(
    id int not null,
    order_date date not null,
    customer_id int not null,
    order_status varchar(100) not null,
    created_at timestamp default current_timestamp(),
    updated_at timestamp default current_timestamp(),
    created_by varchar default current_user(),
    updated_by varchar default current_user(),
    -- constraints
    constraint pk_orders primary key(id),
    constraint fk_customers foreign key(customer_id)
        references raw_schema.customers(id)
)
comment = 'Orders master data';

-- create order_items table in raw schema
create or replace table raw_schema.order_items
(
    id int not null,
    order_id int not null,
    product_id int not null,
    quantity int not null,
    unit_price decimal(10, 2) not null,
    discounts decimal(10, 2),
    created_at timestamp default current_timestamp(),
    updated_at timestamp default current_timestamp(),
    created_by varchar default current_user(),
    updated_by varchar default current_user(),
    -- constraints
    constraint pk_order_items primary key(id),
    constraint fk_order_id foreign key(order_id)
        references raw_schema.orders(id),
    constraint fk_product_id foreign key(product_id)
        references raw_schema.products(id)
)
comment = 'Order Items master data';
