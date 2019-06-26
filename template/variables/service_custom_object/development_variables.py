# Environment
VALID_USER = "worldsensing"
VALID_PASSWORD = "delHoorAifdoicseet1odNun"
SCHEME = "https"
SERVER = "development.mobility.wocs3.com"
LANGUAGE = "en"
WORKING_URL = SCHEME + "://" + SERVER + "/mb/app?language=" + LANGUAGE

# Common
custom_instance = 0
core_instance = 0

visualization_map_hotspot = """{"cartocss": "#df_agents_position_mview::points { marker-width: 8; marker-opacity: 0.7; marker-fill: red; marker-placement:point; marker-type:ellipse; marker-allow-overlap:true }"}"""
visualization_map_rubish_container = """{"cartocss": "#df_agents_position_mview::points { marker-width: 8; marker-opacity: 0.7; marker-fill: red; marker-placement:point; marker-type:ellipse; marker-allow-overlap:true }"}"""
visualization_map_invalid = """{"cartocss": { marker-width: 8; marker-opacity: 0.7; marker-fill: red; marker-placement:point; marker-type:ellipse; marker-allow-overlap:true }"}"""
visualization_popup_hotspot = """{}"""
visualization_popup_rubish_container = """{}"""
visualization_popup_invalid = """{{"."}}"""
