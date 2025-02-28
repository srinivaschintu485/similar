import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

# Generate clustered points on one side
np.random.seed(42)
cluster_x = np.random.normal(loc=2, scale=0.5, size=50)
cluster_y = np.random.normal(loc=2, scale=0.5, size=50)
cluster_z = np.random.normal(loc=2, scale=0.5, size=50)

# Generate scattered points on other sides
scatter_x = np.random.uniform(-3, 3, 50)
scatter_y = np.random.uniform(-3, 3, 50)
scatter_z = np.random.uniform(-3, 3, 50)

# Combine the points
x = np.concatenate([cluster_x, scatter_x])
y = np.concatenate([cluster_y, scatter_y])
z = np.concatenate([cluster_z, scatter_z])

# Create a figure for 3D plotting
fig = plt.figure(figsize=(10, 7))
ax = fig.add_subplot(111, projection='3d')

# Scatter plot the points
ax.scatter(cluster_x, cluster_y, cluster_z, color='blue', label="Clustered Points")
ax.scatter(scatter_x, scatter_y, scatter_z, color='red', label="Scattered Points")

# Define an inclined line (separating boundary)
angle = np.radians(135)  # Angle of inclination
line_x = np.linspace(-3, 5, 100)
line_y = np.linspace(-3, 5, 100)
line_z = np.tan(angle) * line_x  # Equation of inclined plane/line

# Plot the inclined line
ax.plot(line_x, line_y, line_z, color='black', linewidth=2, label="Inclined Line (Boundary)")

# Labels and title
ax.set_xlabel("X Axis")
ax.set_ylabel("Y Axis")
ax.set_zlabel("Z Axis")
ax.set_title("3D Data Points with Inclined Line")

ax.legend()
plt.show()

from pyspark.sql import SparkSession
from pyspark.sql.functions import col, udf, when, lit
from pyspark.sql.types import StringType, DoubleType, IntegerType
from Levenshtein import distance as levenshtein_distance
import re

# Initialize Spark Session
spark = SparkSession.builder.appName("LevenshteinOnly").getOrCreate()

# Load CSV File
csv_file_path = "/content/name_matching.csv"
df = spark.read.option("header", "true").csv(csv_file_path)

# Function to Normalize Text
def normalize_text(value):
    if value is None:
        return None  # Handle null values safely
    value = value.lower().strip()  # Convert to lowercase & remove extra spaces
    value = re.sub(r'\s+', ' ', value)  # Replace multiple spaces with a single space
    value = re.sub(r'[^a-zA-Z0-9\s]', '', value)  # Remove special characters (optional)
    return value

# Register UDF for Text Normalization
normalize_udf = udf(normalize_text, StringType())

# Apply Normalization to Both Columns
df = df.withColumn("Name_normalized", normalize_udf(col("Name"))) \
       .withColumn("Name_Variant_normalized", normalize_udf(col("Name_Variant")))

# Function to check if both values are applicable for similarity comparison
def is_applicable(value1, value2):
    if value1 is None or value2 is None or value1.strip() == "" or value2.strip() == "":
        return False  # Ensuring non-empty strings
    return (any(c.isalpha() for c in value1) or any(c.isdigit() for c in value1)) and \
           (any(c.isalpha() for c in value2) or any(c.isdigit() for c in value2))

# UDF to check format applicability (returns 1 for applicable, 0 otherwise)
def check_format(value1, value2):
    return 1 if is_applicable(value1, value2) else 0

format_udf = udf(check_format, IntegerType())

# Apply Format Check
df = df.withColumn("format_applicable", format_udf(col("Name_normalized"), col("Name_Variant_normalized")))

# UDF for Levenshtein Distance Calculation (Only if applicable)
def levenshtein_score(value1, value2):
    if not is_applicable(value1, value2):
        return 0  # Ensuring that invalid inputs return 0
    return float(levenshtein_distance(value1, value2))  # Explicitly converting to float for PySpark compatibility

levenshtein_udf = udf(levenshtein_score, DoubleType())

# Apply Levenshtein Distance Calculation (Only if format is applicable)
df = df.withColumn("levenshtein_score", 
                   when(col("format_applicable") == 1, levenshtein_udf(col("Name_normalized"), col("Name_Variant_normalized")))
                   .otherwise(lit(0)))

# Display Results (Ensuring full view of data)
df.show(truncate=False)

# Save Output to CSV
df.write.option("header", "true").csv("/content/levenshtein_output8.csv")



