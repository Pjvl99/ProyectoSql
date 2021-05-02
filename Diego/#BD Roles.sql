DROP ROLE IF EXISTS user_dev, user_read, user_write, user_caja, user_ventas;
CREATE ROLE user_dev, user_read, user_write, user_caja, user_ventas;

GRANT ALL ON proyecto2.* TO "user_dev";
GRANT SELECT ON proyecto2.* TO "user_read";
GRANT INSERT, UPDATE, DELETE ON proyecto2.* TO "user_write";
GRANT INSERT, UPDATE, DELETE ON proyecto2.caja TO "user_caja";
GRANT INSERT, UPDATE, DELETE ON proyecto2.ventas TO "user_ventas";

GRANT 'user_dev' TO 'admin'@'34.123.87.111';
GRANT 'user_read' TO 'maria'@'34.123.87.111';
GRANT 'user_write' TO 'pablo'@'34.123.87.111';
GRANT 'user_caja' TO 'daniel'@'34.123.87.111';
GRANT 'user_ventas' TO 'diego'@'34.123.87.111';