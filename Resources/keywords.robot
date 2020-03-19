*** Keywords ***
Begin Web Test
    Open Browser                about:blank  ${BROWSER}
    Maximize Browser Window

Go to Web Page
    Load Page
    Verify Page Loaded

Load Page
    Go To                       ${URL}
Verify Page Loaded
    ${link_text} =              Get Text  id:title
    Should Be Equal             ${link_text}  Infotiv Car Rental

Page is loaded
    Load Page
    Verify Page Loaded

Continue button is pressed
    Click Button                id:continue

Show cars
    ${header_text} =            Get Text    id:questionText
    Should Be Equal             ${header_text}  What would you like to drive?

Search for Product
    [Arguments]                 ${search_term}  ${search_result}
    Enter Search Term           ${search_term}
    Submit Search
    Verify Search Completed     ${search_term}   ${search_result}

Enter Search Term
    [Arguments]                 ${search_term}
    Input Text                  id:twotabsearchtextbox  ${search_term}

Login User No Password
    Sleep  3s
    Click Button                xpath://button[@id="login"]
    Input Text                  id:email  555@telia.com
    Click Button                xpath://button[@id="login"]
    Should Be Equal             ${elem}

Click Login
    Click Button                id:login

Get and Compare Date
    ${collectDate} =            Get Value           id:start
    Set Suite Variable          ${collectDate}
    Log                         ${collectDate}
    ${currentDate} =            Get Current Date    result_format=%Y-%m-%d
    Should Be Equal             ${currentDate}      ${collectDate}

Add and Convert Date
    [Arguments]                 ${NumberOfDays}
    ${date} =	                Add Time To Date	${collectDate}	${NumberOfDays} days
    Log                         ${date}
    ${newDate} =                Convert Date        ${date}		    result_format=%m%d
    Set Suite Variable          ${newDate}
    Log                         ${newDate}

Cancel Reservation
    Click Button            id:mypage
    Click Button            id:unBook1
    Alert Should Be Present

Login User
    Input text                      name:email                      ${epost}
    Input text                      Id:password                     ${password}
    Click Login

Choose Car
    Click Button            xpath://button[@id="continue"]
    Click Button            id:bookQ7pass7

User Input
    Input text              id:cardNum                      ${kreditkort}
    Input text              id:fullName                     ${namn}
    Input text              id:cvc                          ${cvc}
    Click Button            id:confirm

User Input Cancel
    Input text              id:cardNum                      ${kreditkort}
    Input text              id:fullName                     ${namn}
    Input text              id:cvc                          ${cvc}
    Click Button            id:cancel

End Web Test
    Unbook all cars if they exist
    Close Browser

Unbook all cars if they exist
        ${no_of_booked_cars}=     Get Element Count     xpath://*[@id="middlepane"]/table/tbody/tr
        LOG TO CONSOLE   no_of_booked_cars ${no_of_booked_cars}
        :FOR  ${iteration}  IN RANGE      1        (${no_of_booked_cars})
        \     Unbook car