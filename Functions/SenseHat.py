from sense_hat import SenseHat
sense = SenseHat()

sense.set_imu_config(True,True,True) # Enable compass, gyro, acc

# Returns json
print(sense.orientation)

# Returns float
print(sense.compass)
print(sense.humidity)
print(sense.pressure)