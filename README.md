# About

Quickstart repo for a Maven managed AJAX web-application using Servlets and JDBC.

## `DataSource`

Before deploying to a webserver create a `Resource` like in your webserver's config (e.g. for Apache Tomcat in `conf/context.xml`).

```
<Resource name="jdbc/couponStore"
          type="javax.sql.DataSource"
          username="postgres"
          password="admin"
          driverClassName="org.postgresql.Driver"
          url="jdbc:postgresql://localhost:5432/coupon_store"
          closeMethod="close"/>
```

*Note*: the `closeMethod="close"` attribute is important. [As per Tomcat's documentation][1] this ensures that connections retrieved from the datasource are closed properly when a webapp context is reloaded/restarted/redeployed/etc.

[1]: https://tomcat.apache.org/tomcat-9.0-doc/config/context.html#Resource_Definitions

CREATE OR REPLACE FUNCTION count_slots() RETURNS TRIGGER AS '
DECLARE
	slot_counter INTEGER := 0;
	need_to_check BOOLEAN := false;

BEGIN
	IF
END;
' LANGUAGE plpgsql;

CREATE TRIGGER count_slots
    BEFORE INSERT OR UPDATE ON slots
    FOR EACH ROW EXECUTE PROCEDURE count_slots();
