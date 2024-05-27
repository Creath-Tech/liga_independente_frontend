import unittest
from appium import webdriver
from appium.options.android import UiAutomator2Options
from appium.webdriver.common.appiumby import AppiumBy
import time

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
        time.sleep(2)
        inputEmail.send_keys("naoexiste@ligaapp.com")
        time.sleep(2)
        inputPassword.click()
        time.sleep(2)
        inputPassword.send_keys("123456")
        time.sleep(2)
        buttonEntrar.click()
        time.sleep(2)
        labelError = self.driver.find_element(by=AppiumBy.XPATH, value='//*[@content-desc="LOGIN OU SENHA INVÁLIDO"]')

    def test_login_sucess(self) -> None:
        inputEmail = self.driver.find_element(by=AppiumBy.XPATH, value='//*[@hint="E-mail"]')
        inputPassword = self.driver.find_element(by=AppiumBy.XPATH, value='//*[@hint="Senha"]')
        buttonEntrar = self.driver.find_element(by=AppiumBy.XPATH, value='//*[@content-desc="ENTRAR"]')
        
        inputEmail.click()
        time.sleep(2)
        inputEmail.send_keys("qualidade@ligaapp.com")
        time.sleep(2)
        inputPassword.click()
        time.sleep(2)
        inputPassword.send_keys("123456")
        time.sleep(2)
        buttonEntrar.click()
        time.sleep(2)

        #TODO: MAPEAR COMPONENTE PARA SUCESSO

if __name__ == '__main__':
    unittest.main()