# BoatGrid
## Rescue Boat Math Class Challenge Implemented in Objective-C With a GUI
### Task Backstory:
You are leading a team of 3 rescue craft, stationed in the water ready for an emergency.

The sea can be pictured as a grid of regions, like bellow. You have three craft stationed in the water, The craft can move nicely but they can only travel North, South, East and West through the grid, they cannot travel diagonally. A craft can move through one square in one minute.

|---|---|---|
|---|---|---|
| C |---|---|
|---| C |---|
|---|---|---|
|---| C |---|
C = Craft
`---` = Water

Each region is protected by the craft closest to it, as measured by the time it takes each craft to reach it, if a region is equally close to each craft it is protected by both.

### What this app does
This app allows the user to input 3 ship coordinates on a 7 by 7 grid, then it shows how far each block is away from the ship.
There is also an additional empty grid view for fun.
