# Environment
SCHEME = "https"
SERVER = "192.168.1.150"
PORT = "8443"
WORKING_URL = SCHEME + "://" + SERVER + "/emp"
PROBLEM_URL = SCHEME + "://" + SERVER + ":" + PORT + "/emp"

# Credentials
ADMIN_USER = "admin"
ADMIN_PASSWORD = "5737b3f"
ADMIN2_USER = "saes"
ADMIN2_PASSWORD = "Abcd1234!"
ADMIN2_PASSWORD2 = "saes1234!"

#XPATHS
login = """/html/body/div/div[2]/div/div/div"""
finish_btn = """//*[@id="nextBtn"]/span"""
polling_place_check = """//*[@id="form-views"]/ui-view/form/div[5]/div/div[2]/label"""
info = """//*[@id="header"]/div[1]/nav/div[2]/ul[2]/li/a"""
header_name = """//*[@id="header"]/div[2]/div/div/div/div/span"""

# Home Menu
menu = """//*[@id="landing-pages-dropdown"]/li/a"""
menu_drop_sysadmin = """//*[@id="landing-pages-dropdown"]/li/ul/li[2]/a"""

# tasks
divele_btn = """//*[@id="test-stage-"]/div[3]/div/div/div[4]/div/div[1]/task-widget/ssp-options-button/div/button[2]"""
complete_divele = """//*[@id="test-stage-"]/div[3]/div/div/div[4]/div/div[1]/task-widget/ssp-options-button/div/ul/li[1]/a/span[2]"""
distritos_btn = """//*[@id="test-stage-"]/div[3]/div/div/div[4]/div/div[2]/task-widget/ssp-options-button/div/button[2]"""
complete_distritos = """//*[@id="test-stage-"]/div[3]/div/div/div[4]/div/div[2]/task-widget/ssp-options-button/div/ul/li[1]/a/span[2]"""

## admin
import_data = """//*[@id="test-stage-"]/div[3]/div/div/div[4]/div/div[1]/a/div"""
import_filechooser = """//*[@id="linkSelectFiles"]/span"""

# Import
validate_btn = """//*[@id="form-container"]/div[2]/div[2]/button[2]"""
next_btn = """//*[@id="form-container"]/div[2]/div[2]/button[3]"""
