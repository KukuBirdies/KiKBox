extends Node

# Used for distant nodes to signal to each other,
# to be used sparingly for events that are more "Global"
# and those that would be more complex to implement otherwise

# For any nodes to add the camera shake effect
# Received by the Player's Camera
signal player_cam_add_tremor(tremor: float)
