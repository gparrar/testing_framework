
enum VehicleCountingDirection {
  NORTH = 1,
  SOUTH = 2,
  EAST = 3,
  WEST = 4,
  MAX_DIRECTION = 5
}

enum VehicleCountingOrientation {
  NORTH_SOUTH = 1,
  EAST_WEST = 2,
  FOUR_DIRECTIONS = 3,
  NORTH = 4,
  SOUTH = 5,
  EAST = 6,
  WEST = 7,
  MAX_ORIENTATION = 8
}

typedef string VehicleCountingId

struct VehicleCountingSite {
    1: required VehicleCountingId id,
    2: required double latitude,
    3: required double longitude,
    4: optional i64 updated_at,
    5: required string name,
    6: required VehicleCountingOrientation orientation, /* VehicleCountingOrientation int values */
    7: optional i32 num_lanes,
}

struct VehicleCountingData {
    1: required VehicleCountingId id,
    2: required VehicleCountingDirection direction,     /* VehicleCountingDirection int values */
    3: required i32 lane,
    4: required i64 time,                               /* in Unix time                    */
    5: optional i32 speed,                              /* In km/h                         */
    6: required i32 occupancy,                          /* in %                            */
    7: optional i32 length,                             /* in meters                       */
    8: required i32 flow,                               /* vehicles per integration period */
    9: optional i32 headway,                            /* amount of time between two vehicles in ms */
    10: optional i32 load,                              /* in %           */
    11: optional bool congested,
    12: optional bool inverted,
    13: required i32 integration_period,                /* in seconds     */
    14: optional i32 server_time,                       /* time when the data was measured in the server */
}

struct VehicleCountingPushData {
    1: list<VehicleCountingSite> sites,
    2: list<VehicleCountingData> data,
}

service DataService {
  oneway void addSites(1: string source, 2: list<VehicleCountingSite> sites),
  oneway void addData(1: string source, 2: list<VehicleCountingData> data),
  oneway void push(1: string source, 2: VehicleCountingPushData data),
  oneway void refreshVisualization(1: string source),
  oneway void enable(1: string source, 2: list<VehicleCountingId> ids),
  oneway void disable(1: string source, 2: list<VehicleCountingId> ids),
  oneway void disableOthers(1: string source, 2: list<VehicleCountingId> ids),
}
