/* Direction of the lane */
enum Direction {
  NORTH = 1,
  SOUTH = 2,
  EAST = 3,
  WEST = 4
}
/* Orientation of the roadway */
enum Orientation {
  NORTH_SOUTH = 1, /* Example: A roadway with two lanes, */
  EAST_WEST = 2,      /* on with North direction, and the other with South Direction  */
  NORTH = 3,
  SOUTH = 4,
  EAST = 5,
  WEST = 6
}
typedef string RoadSegmentId
typedef string LaneId


struct RoadSegment {
    1: required RoadSegmentId id,
    2: required string name,
    3: required Orientation orientation,
    4: required double latitude,
    5: required double longitude,
    6: optional string type,              /* Must be one of the road types defined in the object instance */
    7: optional string description,       /* human-readable description, e.g. address */
    8: optional i64 updated_at,           /* Last time when the roadway information was updated */
}

/* A lane belongs to a road segment and can have only one direction: North, South, East, West. */
struct Lane {
  1: required LaneId id,                  /* unique in its road segment */
  2: required RoadSegmentId road_segment_id,
  3: optional string name,
  4: required Direction direction,
  5: optional string type,                /* Must be one of the lane types defined in the object instance */
  6: optional double latitude,
  7: optional double longitude,
  8: optional i64 lane_num, /* This field indicates the order of the lanes. The lower values indicates left most lanes, and greater values the most right. */
}

/* Valid class ids are defined in the object instance */
struct VehicleClassificationCount {
    1: required i32 class_id,
    2: required i32 class_count,
}

/*Vehicle Counting data aggregated by lanes / time interval*/
struct LaneMeasurement {
    1: required LaneId lane_id,
    2: required RoadSegmentId road_segment_id,
    3: required i64 time_unix_ms,             /* in Unix time in milliseconds  */
    4: required i32 integration_period_s,     /* in seconds                            */
    5: required i32 number_vehicles,          /* vehicles per integration period */
    6: required i32 avg_speed_kmh,            /* In km/h */
    7: optional i32 occupancy_percentage,     /* in %                            */
    8: optional double avg_length_m,             /* in meters                       */
    9: optional i32 avg_headway_ms,           /* amount of time between two vehicles in ms */
    10: optional bool congested,              /* True if the lane is congested */
    11: optional bool period_inverted,        /* True if the lane is inverted during the period*/
    12: optional list<VehicleClassificationCount> classified_counts,

}

/* Push data without vehicle classification data */
struct TrafficPushData {
    1: list<RoadSegment> road_segments,
    2: list<Lane> lanes,
    3: list<LaneMeasurement> lanes_data,
}

/* API methods */
service DataService {
  oneway void add_road_segments(1: string source, 2: list<RoadSegment> road_segments),
  oneway void add_lanes(1: string source, 2: list<Lane> lanes),
  oneway void add_lane_measurements(1: string source, 2: list<LaneMeasurement> lanes_data),
  oneway void push(1: string source, 2: TrafficPushData data),
  oneway void enable_roadsegments(1: string source, 2: list<RoadSegmentId> ids),
  oneway void disable_roadsegments(1: string source, 2: list<RoadSegmentId> ids),
  oneway void disable_other_roadsegments(1: string source, 2: list<RoadSegmentId> ids),
}
