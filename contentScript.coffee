get_local_path = (js_path)->
    console.log js_path
    if js_path
        return chrome.extension.getURL("contentScript.js")
    return ""

all_js = document.getElementsByTagName('script')
for item in all_js
    js_path = item.getAttribute('src')
    console.log js_path
    local_path = get_local_path(js_path)
    if local_path
        console.log local_path
        item.setAttribute('src', local_path)
