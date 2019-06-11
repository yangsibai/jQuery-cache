localVersion = [
    "1.2.1"
    "1.2.2"
    "1.2.3"
    "1.2.4"
    "1.2.5"
    "1.2.6"
    "1.3.1"
    "1.3.2"
    "1.4.1"
    "1.4.2"
    "1.4.3"
    "1.4.4"
    "1.5.1"
    "1.5.2"
    "1.6.1"
    "1.6.2"
    "1.6.3"
    "1.6.4"
    "1.7.0"
    "1.7.1"
    "1.7.2"
    "1.8.0"
    "1.8.1"
    "1.8.2"
    "1.8.3"
    "1.9.0"
    "1.9.1"
    "1.10.0"
    "1.10.1"
    "1.10.2"
    "1.11.0"
    "1.11.1"
    "1.12.4"
    "2.0.0",
    "2.0.1",
    "2.0.2",
    "2.0.3",
    "2.1.0",
    "2.1.1",
    "2.2.1",
    "2.2.2",
    "2.2.3",
    "2.2.4",
    "3.0.0",
    "3.1.0"
]

filter =
    urls: [
        "http://*/*.js",
        "https://*/*.js"
    ]

whiteLists = [
    'g.alicdn.com'
]

notInWhiteList = (url)->
    for item in whiteLists
        if url.indexOf(item) isnt -1
            return false
    return true

handler = (details)->
    jQueryVersion = execJQueryVersion(details.url)
    if jQueryVersion
        localCache = getLocalJsFile(jQueryVersion)
        if localCache and notInWhiteList(details.url)
            return {
                redirectUrl: localCache
            }

###
    get jquery version if url is a valid jquery
    @return {String} jquery version, empty if is not a valid jquery
###
execJQueryVersion = (originalURL)->
    if originalURL.toLowerCase().indexOf('jquery') > -1
        jQueryVersionRegex = /\d\.\d*\.\d/g
        matches = originalURL.match jQueryVersionRegex;
        return matches[0] if matches?.length is 1
    return ""

###
    get local jquery file by version
    @return {String} local js file, empty if not have one
###
getLocalJsFile = (version)->
    if version in localVersion
        return chrome.extension.getURL("files/jQuery/jquery-#{version}.min.js")
    return ""

chrome.webRequest.onBeforeRequest.addListener handler, filter, ["blocking"]
