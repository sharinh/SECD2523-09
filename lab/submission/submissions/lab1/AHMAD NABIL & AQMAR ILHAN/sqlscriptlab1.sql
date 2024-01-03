/*LAB 1 - DDL SQL SCRIPT
NAME: AHMAD NABIL BIN AHMAD NAZRIL
MATRIC NO: B23CS0020

NAME: AQMAR ILHAN BIN MOHAMAD FADZILAH
MATRIC NO: B23CS0027
*/

CREATE TABLE inventory_list ( 
    id      VARCHAR2(11) NOT NULL, 
    cost    NUMBER(7,2) NOT NULL, 
    units   NUMBER(4) NOT NULL, 
    CONSTRAINT inventory_list_pk PRIMARY KEY ( id ) 
);

CREATE TABLE items ( 
    itm_number    VARCHAR2(10) NOT NULL, 
    name          VARCHAR2(20) NOT NULL, 
    description   VARCHAR2(50) NOT NULL, 
    category      VARCHAR2(25) NOT NULL, 
    color         VARCHAR2(15), 
    "Size"        CHAR(1), 
    ilt_id        VARCHAR2(11) NOT NULL, 
    CONSTRAINT item_pk PRIMARY KEY ( itm_number ) 
);

CREATE TABLE price_history ( 
    start_date   DATE NOT NULL, 
    start_time   DATE NOT NULL, 
    price        NUMBER(7,2) NOT NULL, 
    end_date     DATE, 
    end_time     DATE, 
    itm_number   VARCHAR2(10) NOT NULL, 
    CONSTRAINT price_history_pk PRIMARY KEY ( itm_number, start_date, start_time ), 
    CONSTRAINT price_history_items_fk FOREIGN KEY ( itm_number ) REFERENCES items ( itm_number ) 
 
);

CREATE TABLE sales_representatives ( 
    id               VARCHAR2(4) NOT NULL, 
    email            VARCHAR2(50) NOT NULL, 
    first_name       VARCHAR2(20) NOT NULL, 
    last_name        VARCHAR2(30) NOT NULL, 
    phone_number     VARCHAR2(11) NOT NULL, 
    commission_rate   NUMBER(2) NOT NULL, 
    supervisor_id    VARCHAR2(4) NOT NULL, 
    CONSTRAINT sales_representative_pk PRIMARY KEY ( id ), 
    CONSTRAINT sre_email_uk UNIQUE (email) 
);

CREATE TABLE sales_rep_addresses ( 
    id               VARCHAR2(4) NOT NULL, 
    address_line_1   VARCHAR2(30) NOT NULL, 
    address_line_2   VARCHAR2(30), 
    city             VARCHAR2(15) NOT NULL, 
    zip_code         VARCHAR2(7) NOT NULL, 
    CONSTRAINT sales_rep_address_pk PRIMARY KEY ( id ) 
);

CREATE TABLE teams ( 
    id                  VARCHAR2(4) NOT NULL, 
    name                VARCHAR2(20) NOT NULL, 
    number_of_players   NUMBER(2) NOT NULL, 
    discount            NUMBER(2), 
    CONSTRAINT team_pk PRIMARY KEY ( id ) 
);

CREATE TABLE customers ( 
    ctr_number            VARCHAR2(6) NOT NULL, 
    email                 VARCHAR2(50) NOT NULL, 
    first_name            VARCHAR2(20) NOT NULL, 
    last_name             VARCHAR2(30) NOT NULL, 
    phone_number          VARCHAR2(11) NOT NULL, 
    current_balance       NUMBER(6,2) NOT NULL, 
    sre_id                VARCHAR2(4), 
    tem_id                VARCHAR2(4), 
    loyalty_card_number   VARCHAR2(6), 
    CONSTRAINT customer_pk PRIMARY KEY ( ctr_number ), 
    CONSTRAINT ctr_email_uk UNIQUE (email), 
    CONSTRAINT ctr_lcn_uk UNIQUE (loyalty_card_number) 
);

CREATE TABLE customers_addresses ( 
    id               VARCHAR2(8) NOT NULL, 
    address_line_1   VARCHAR2(30) NOT NULL, 
    address_line_2   VARCHAR2(30), 
    city             VARCHAR2(15) NOT NULL, 
    zip_code         VARCHAR2(7) NOT NULL, 
    ctr_number       VARCHAR2(6) NOT NULL, 
    CONSTRAINT customer_address_pk PRIMARY KEY ( id ) 
);

CREATE TABLE orders ( 
    id                VARCHAR2(9) NOT NULL, 
    odr_date          DATE NOT NULL, 
    odr_time          DATE NOT NULL, 
    number_of_units   NUMBER(2) NOT NULL, 
    ctr_number        VARCHAR2(6) NOT NULL, 
    CONSTRAINT orders_pk PRIMARY KEY ( id ) 
);

CREATE TABLE ordered_items ( 
    quantity_ordered   NUMBER(3) NOT NULL, 
    quantity_shipped   NUMBER(3) NOT NULL, 
    itm_number         VARCHAR2(10) NOT NULL, 
    odr_id             VARCHAR2(9) NOT NULL, 
    CONSTRAINT ordered_item_pk PRIMARY KEY ( itm_number,odr_id ) 
);

ALTER TABLE customers_addresses ADD CONSTRAINT customer_address_customer_fk FOREIGN KEY ( ctr_number ) 
    REFERENCES customers ( ctr_number );

ALTER TABLE customers ADD CONSTRAINT customer_sales_rep_fk FOREIGN KEY ( sre_id ) 
    REFERENCES sales_representatives ( id );

ALTER TABLE customers ADD CONSTRAINT customer_team_fk FOREIGN KEY ( tem_id ) 
    REFERENCES teams ( id );

ALTER TABLE items ADD CONSTRAINT item_inventory_list_fk FOREIGN KEY ( ilt_id ) 
    REFERENCES inventory_list ( id );

ALTER TABLE orders ADD CONSTRAINT order_customer_fk FOREIGN KEY ( ctr_number ) 
    REFERENCES customers ( ctr_number );

ALTER TABLE ordered_items ADD CONSTRAINT ordered_item_item_fk FOREIGN KEY ( itm_number ) 
    REFERENCES items ( itm_number );

ALTER TABLE ordered_items ADD CONSTRAINT ordered_item_order_fk FOREIGN KEY ( odr_id ) 
    REFERENCES orders ( id );

ALTER TABLE sales_rep_addresses ADD CONSTRAINT sales_rep_add_sales_rep_fk FOREIGN KEY ( id ) 
    REFERENCES sales_representatives ( id );

ALTER TABLE sales_representatives ADD CONSTRAINT sales_rep_sales_rep_fk FOREIGN KEY ( supervisor_id ) REFERENCES sales_representatives ( id );

CREATE OR REPLACE TRIGGER fkntm_orders BEFORE 
    UPDATE OF ctr_number ON orders 
BEGIN 
    raise_application_error( 
        -20225, 
        'Non Transferable FK constraint  on table orders is violated' 
    ); 
END;
/

DESCRIBE inventory_list


DESCRIBE items


DESCRIBE price_history


DESCRIBE sales_representatives


DESCRIBE sales_rep_addresses


DESCRIBE teams


DESCRIBE customers


DESCRIBE customers_addresses


DESCRIBE orders


DESCRIBE ordered_items


