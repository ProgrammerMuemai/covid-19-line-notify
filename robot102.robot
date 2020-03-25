*** Settings ***
Library  SeleniumLibrary
Library  RequestsLibrary
Library  BuiltIn

*** Variable ***
${URL}  https://ddc.moph.go.th/viralpneumonia/
${Browser}  chrome
${token}  your_token
${url_post}  https://notify-api.line.me

*** Keyword ***
ส่งข้อมูลเข้า line
  [Arguments]  ${message}
  Create Session  covid  ${url_post}
  &{params}=    Create Dictionary  message=${message}
  &{headers}=    Create Dictionary  Content-Type=application/x-www-form-urlencoded  Authorization=Bearer ${token}
  ${resp}=    POST Request  covid  /api/notify  params=${params}  headers=${headers}

*** Test Cases ***
เปิดไปที่เว็บไซต์กรมควบคุมโรค
  Open Browser  ${URL}  ${Browser}
  Maximize Browser Window
  Click Element  css:body > div > div > div > div:nth-child(1) > div.bgsmall.noselect > div > h5
  ${Total}  Get Text  css:#covic_popup > div > div > div.modal-body > div:nth-child(3) > table > tbody > tr:nth-child(4) > td:nth-child(1)
  ${New}  Get Text  css:#covic_popup > div > div > div.modal-body > div:nth-child(3) > table > tbody > tr:nth-child(4) > td:nth-child(2)
  ${Critical}  Get Text  css:#covic_popup > div > div > div.modal-body > div:nth-child(3) > table > tbody > tr:nth-child(6) > td:nth-child(1)
  ${Dead}  Get Text  css:#covic_popup > div > div > div.modal-body > div:nth-child(3) > table > tbody > tr:nth-child(6) > td:nth-child(2)
  ${Go_Home}  Get Text  css:#covic_popup > div > div > div.modal-body > div:nth-child(3) > table > tbody > tr:nth-child(6) > td:nth-child(3)
  ส่งข้อมูลเข้า line  สะสม ${Total}
  ส่งข้อมูลเข้า line  รายใหม่ ${New}
  ส่งข้อมูลเข้า line  รุนแรง ${Critical}
  ส่งข้อมูลเข้า line  เสียชีวิตแล้ว ${Dead}
  ส่งข้อมูลเข้า line  กลับบ้านแล้ว ${Go_Home}
  Close Browser