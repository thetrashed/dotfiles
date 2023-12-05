//
// ==UserScript==
// @name         Auto Skip YouTube Ads 
// @version      1.0.1
// @description  Speed up and skip YouTube ads automatically 
// @author       jso8910
// @match        *://*.youtube.com/*
// @exclude      *://*.youtube.com/subscribe_embed?*
// ==/UserScript==
// let main = new MutationObserver(() => {
//    let ad = [...document.querySelectorAll('.ad-showing')][0];
//    if (ad) {
//        let btn = document.querySelector('.videoAdUiSkipButton,.ytp-ad-skip-button')
//        if (btn) {
//            btn.click()
//        }
//    }
// })

// main.observe(document.querySelector('.videoAdUiSkipButton,.ytp-ad-skip-button'), {attributes: true, characterData: true, childList: true})

// ==UserScript==
// @name         Auto Skip YouTube Ads 
// @version      1.0.0
// @description  Speed up and skip YouTube ads automatically 
// @author       jso8910
// @match        *://*.youtube.com/*
// @exclude      *://*.youtube.com/subscribe_embed?*
// ==/UserScript==
setInterval(() => {
    const btn = document.querySelector('.videoAdUiSkipButton,.ytp-ad-skip-button')
    if (btn) {
        btn.click()
    }
    const ad = [...document.querySelectorAll('.ad-showing')][0];
    if (ad) {
        document.querySelector('video').playbackRate = 16;
    }
}, 50)

const ad = [...document.querySelectorAll('.ad-showing')][0];
if (ad) {
    console.log("ad found");
    // Speed up and mute
    document.querySelector('video').playbackRate = 25;
    document.querySelector('video').muted = true;
} else {
    console.log("ad not found");
}
