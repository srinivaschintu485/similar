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

