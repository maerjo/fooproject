*** Settings ***
Documentation
Resource        ../Resources/keywords.robot
Library         SeleniumLibrary
Library         DateTime

Test Setup     Begin Web Test
Test Teardown  End Web Test

*** Variables ***
${BROWSER} =  chrome
${URL} =  http://rental21.infotiv.net/
${elem} =  GetWebElement id:logout
${epost} =  555@telia.com
${password} =  Aa1234
${kreditkort} =  1234567891011121
${namn} =  Anders Andersson
${cvc} =  187

*** Test Cases ***
User can access Infotiv Car Rental Service
    [Documentation]         Verfiera att sidan laddas
    [Tags]                  Test ladda in sida
    Go to Web Page

User test negativ
    [Documentation]         Skriva in negativ tom textbox, Ska ej logga in EXPECT FAIL
    [Tags]                  Textbox tom
    Go to Web Page
    Login User No Password

Select date
    [Documentation]         Väljer startdatum och slutdatum
    [Tags]                  DateSelector
    Go to Web Page
    Get and Compare Date
    Add and Convert Date    10                  #Manipulerar startdatum
    Log                     ${newDate}          #Verifierar att rätt värde läses in
    Input text              name:start          ${newDate}
    Add and Convert Date    20                  #Manipulerar slutdatum
    Input text              name:end            ${newDate}
    Click Button            id:reset

Book A Car
    [Documentation]
    [Tags]                  bokabil
    Go to Web Page
    Login User
    Choose Car
    User Input
    Cancel Reservation

Gherkin-style
    [Tags]                  gurkan
    Given Page is loaded
    When Continue button is pressed
    Then Show cars

Length CreditCardNumber
    [Documentation]         Loggar in, väljer bil och kontrollerar kreditkortsnummerlängden.
    [Tags]                  creditlength
    Go to Web Page
    Login User
    Choose Car
    ${AntalSiffror} =               Get Length  ${kreditkort}
    Log                             ${AntalSiffror}
    Should Be Equal As Integers     ${AntalSiffror}     16

Cancel test at Creditcard Page
    [Documentation]         Below is a Cancel button, that will take the user back to the car selection page.
    [Tags]                  CancelBooking
    Go to Web Page
    Login User
    Choose Car
    User Input Cancel
    ${backButtonText} =     Get Text    id:backToDateButton
    Should Be Equal         ${backButtonText}   Back to date selection