typedef string TrackingId          /* Can only contain [a-zA-Z0-9_-.~] */
typedef i32 TrackingTypeId

struct TrackingElement {
  1: required TrackingId id,
  2: required TrackingTypeId type,
  3: required string name,         /* Human readable name (limited to 50 chars) */
  4: optional i64 updated_at,
}

struct TrackingType {
  1: required TrackingTypeId id,
  2: required string name,         /* Human readable name (limited to 50 chars)         */
  3: optional string description,  /* Human readable description (limited to 256 chars) */
  4: optional i64 updated_at,
}

enum TrackingHeading {
  NORTH = 1,
  SOUTH = 2,
  EAST = 3,
  WEST = 4,
  NORTH_EAST = 5,
  NORTH_WEST = 6,
  SOUTH_EAST = 7,
  SOUTH_WEST = 8,
  MAX_HEADING = 9,
}

struct TrackingData {
  1: required TrackingId id,
  2: required i64 time,
  3: required double latitude,
  4: required double longitude
  5: optional double altitude,
  6: optional double accuracy,         /* Radius in m                                     */
  7: optional double speed,            /* In km/h                                         */
  8: optional TrackingHeading heading,
  9: optional string location,         /* Human readable location  (limited to 256 chars) */
  10: optional string status,          /* Human readable status    (limited to 256 chars) */
  11: optional bool inactive           /* Element is not active in this moment            */
}

struct TrackingPushData {
  1: list<TrackingType> types,
  2: list<TrackingElement> elements,
  3: list<TrackingData> data,
}

struct TrackingGeofence {
  1: required string id,
  2: required string geojson_geom,
  3: optional i64 updated_at,
}


service DataService {
  /* source can only contain [A-Za-z] chars and max len is 6 */
  oneway void addTypes(1: string source, 2: list<TrackingType> types),
  oneway void addElements(1: string source, 2: list<TrackingElement> elements),
  oneway void addData(1: string source, 2: list<TrackingData> data),
  oneway void push(1: string source, 2: TrackingPushData data),
  oneway void refreshVisualization(1: string source),
  oneway void enable(1: string source, 2: list<TrackingId> ids),
  oneway void disable(1: string source, 2: list<TrackingId> ids),
  oneway void disableOthers(1: string source, 2: list<TrackingId> ids),
  oneway void setGeofences(1: string source, 2: list<TrackingGeofence> geofences),
}
