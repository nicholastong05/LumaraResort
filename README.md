# Lumara Resort

## How to Run
This project is configured to run with the Jetty Maven Plugin.

1.  **Prerequisites**: Ensure you have Java (JDK 11+) and Maven installed.
2.  **Run**:
    ```bash
    mvn jetty:run
    ```
3.  **Access**: Open your browser to [http://localhost:8081/](http://localhost:8081/).

## Deployment
To build a WAR file for production deployment (e.g., Tomcat):
```bash
mvn package
```
The WAR file will be generated in `target/LumaraResort-1.0-SNAPSHOT.war`.

## Status
- **Static Assets**: Ensure `css`, `js`, and `images` are in the `web/` directory.
- **Database**: Currently using a dummy login (`admin` / `admin123`).
