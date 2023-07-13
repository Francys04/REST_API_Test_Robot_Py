***Setting***
#define library request
Library     RequestsLibrary
#get from dict for verify header
Library    Collections


***Variables***
#create objects ${} and define url, params for searching json-data from request
${base_url}     https://api.openweathermap.org
${lat}      44.43
${long}     26.09
${api_key}      a709cc9dae11cd35e9142adb31eb9c86

***Test Cases***
#name of test
Get_weatherInfo
#create test by session for acces url and after to response with the last perams of url
    Create Session    mysession    ${base_url}
    ${response}=    GET On Session    mysession    url=/data/2.5/weather?lat=${lat}&lon=${long}&appid=${api_key}
#    show in terminal the status code=>200, content and headers
#    log to console  ${response.status_code}
#    log to console  ${response.content}
#    log to console  ${response.headers}

#VALIDATION
#create a obj for store status code and after copare

#for status_code
#int not compare to str, 200(str), (200)str <=> (status_code)str
    ${status_code}=     Convert To String   ${response.status_code}
#    use build-in fun of requestlibrary
    Should Be Equal    ${status_code}    200

#for body_contains, create a obj to sotre content, get json format with convert to str
    ${body}=    Convert To String    ${response.content}
#    verify if country is correct indetify
    Should Contain    ${body}    RO

#for headers(json format verify)
#dict value should be equal with key: Content-Type == application/json
    ${contentTypeValue}=    Get From Dictionary    ${response.headers}     Content-Type
    Should Be Equal    ${contentTypeValue}    application/json; charset=utf-8