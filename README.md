# Riding-the-Data-Wave-
Merging Citi Bike and Weather Insights for Smarter Analytics


## Project Overview
This project combines Citi Bike ridership data with NOAA weather data to create a comprehensive PostgreSQL database for analyzing weather impacts on bike rental patterns. The resulting database and analytics-ready views help bike rental companies make data-driven decisions about their operations.

## Features
- Clean and merged bike rental and weather datasets
- Normalized PostgreSQL database schema
- Five analytical views for business insights
- Complete data pipeline from raw data to analytics-ready views

## Technology Stack
- Python (Pandas, SQLAlchemy)
- PostgreSQL
- Jupyter Notebooks
- Git

## Project Structure
```
├── Notebooks
│   └── bike_rental_data_prep.ipynb
├── Tables
│   ├── dates.csv
│   ├── stations.csv
│   ├── trips.csv
│   ├── users.csv
│   └── weather.csv
├── Views
│   ├── 00_views_write_up.md
│   ├── 01_average_trip_duration.csv
│   ├── 02_trips_by_station.csv
│   ├── 03_trip_counts_by_user_weather.csv
│   ├── 04_stations_with_most_frequent_users.csv
│   └── 05_weather_impact_trip_duration.csv
├── bike_rental_relational_database.png
└── bike_rental_relational_database.sql
```

## Database Schema
The database follows a normalized schema design with the following tables:
- Dates
- Stations
- Trips
- Users
- Weather

![Database Schema](bike_rental_relational_database.png)

## Analytical Views

1. **Average Trip Duration by Day of Week**
   - Analyzes typical trip durations across different days
   - Reveals patterns in usage duration

2. **Trips by Station Pair**
   - Maps popular routes between stations
   - Identifies high-traffic station connections

3. **Trip Counts by User Type and Weather**
   - Segments user behavior by weather conditions
   - Helps understand weather impact on different user types

4. **Stations with Most Frequent Users**
   - Identifies high-engagement stations
   - Guides infrastructure and maintenance planning

5. **Weather Impact on Trip Duration**
   - Correlates weather conditions with trip duration
   - Supports operational planning based on weather forecasts

## Getting Started

### Prerequisites
- Python 3.x
- PostgreSQL
- Required Python packages:
  ```
  pandas
  sqlalchemy
  psycopg2
  jupyter
  ```

### Installation
1. Clone the repository
2. Install required packages:
   ```bash
   pip install -r requirements.txt
   ```
3. Set up PostgreSQL database
4. Run the schema creation script:
   ```bash
   psql -d your_database -f bike_rental_relational_database.sql
   ```

### Data Pipeline
1. Run data preparation notebook:
   ```bash
   jupyter notebook bike_rental_data_prep.ipynb
   ```
2. Import cleaned data into PostgreSQL
3. Create analytical views using provided SQL scripts

## Usage
1. Connect to your PostgreSQL database
2. Query the analytical views:
   ```sql
   SELECT * FROM avg_trip_duration_by_day;
   ```

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License
[MIT](https://choosealicense.com/licenses/mit/)

## Contact
Your Name - [Your Email]
Project Link: [https://github.com/yourusername/riding-the-data-wave]
