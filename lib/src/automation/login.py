import unittest
from appium import webdriver
from appium.options.android import UiAutomator2Options
from appium.webdriver.common.appiumby import AppiumBy

capabilities = dict(
    platformName='Android',
    automationName='uiautomator2',
    deviceName='Android',
    appPackage='com.creath.ligaapp.liga_independente_frontend',
    appActivity='.MainActivity',
    ensureWebviewsHavePages= True,
    nativeWebScreenshot= True,
    newCommandTimeout= 3600,
    connectHardwareKeyboard= True,
    language='en',
    locale='US'
)

appium_server_url = 'http://127.0.0.1:4723'

class TestAppium(unittest.TestCase):
    def setUp(self) -> None:
        self.driver = webdriver.Remote(appium_server_url, options=UiAutomator2Options().load_capabilities(capabilities))

    def tearDown(self) -> None:
        if self.driver:
            self.driver.quit()

    # def test_login(self) -> None:
    #     self.driver.sleep(500)

    def test_login_error(self) -> None:
        inputEmail = self.driver.find_element(by=AppiumBy.XPATH, value='//*[@hint="E-mail"]')
        inputPassword = self.driver.find_element(by=AppiumBy.XPATH, value='//*[@hint="Senha"]')
        buttonEntrar = self.driver.find_element(by=AppiumBy.XPATH, value='//*[@content-desc="ENTRAR"]')
        
        inputEmail.click()
        inputEmail.send_keys("admin@admin.com")
        
        inputPassword.click()
        inputPassword.send_keys("12345")
        
        buttonEntrar.click()


if __name__ == '__main__':
    unittest.main()