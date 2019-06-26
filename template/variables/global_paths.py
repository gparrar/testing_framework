# Left Menu

menu_title_path = 'xpath://span[contains(@class, "mainTitleText")]'
left_menu = '//*[@id="leftside"]'

# Generic Pop ups
popup_base = '//*[@id="popup-generic"]//div[contains(@class, "is-current")]'
popup_header = popup_base + '//div[contains(@class, "popup-title")]'
popup_body = popup_base + '/div[2]'  # Assumes header, body
popup_close = popup_base + '//button[contains(@class,"popup-close")]'
