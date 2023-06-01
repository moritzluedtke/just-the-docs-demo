// ==UserScript==
// @name         Display AWS Account Name in AWS Console
// @namespace    http://tampermonkey.net/
// @version      1.1.0
// @description  Display AWS account name with environment appropriate color
// @author       mhlabs & mluedtke & bbrodersen
// @match        https://*.aws.amazon.com/*
// @icon         https://www.aws.amazon.com/favicon.ico
// @grant        none
// ==/UserScript==

// Based upon: https://github.com/mhlabs/aws-console-tampermonkey/blob/master/scripts/aws-sso-account-alert.js

(function() {
    "use strict";

    const accountInfo = getAccountInfo()

    // ==== Add account name label ====
    const style = document.createElement("style");
    const accentColor = getAccountDisplayColor(accountInfo);
    style.innerHTML = `.custom-account {
        padding: 4px 6px !important;
        margin: 0 14px 0 0;
        color: ${getContrastColor(accentColor)} !important;
        background-color: #${accentColor} !important;
    }`;

    const scriptTag = document.querySelector("script");
    scriptTag.parentNode.insertBefore(style, scriptTag);

    const accountEnvironmentLabel = document.createElement("span");
    accountEnvironmentLabel.className = "nav-elt custom-account";
    accountEnvironmentLabel.innerHTML =
        `<strong>${accountInfo.accountName ? "Account" : "Alias"}:</strong> ${accountInfo.accountName ? accountInfo.accountName : accountInfo.accountAlias}`;

    const usernameMenuElement = document.querySelector('#nav-usernameMenu')
    usernameMenuElement.insertBefore(accountEnvironmentLabel, usernameMenuElement.firstChild)

     // ==== Add indicator bar in production ====
    if (isProduction(accountInfo)) {
        const indicatorBarElement = document.createElement('div')
        indicatorBarElement.style.cssText = `
            height: 10px;
            background: repeating-linear-gradient(-45deg,  #${accentColor}, #${accentColor} 10px,  transparent 0px,  transparent 22px) !important;
        `;
        document.querySelector('#awsc-nav-header nav').appendChild(indicatorBarElement)
    }
})();


// ========================================================
// ==================== Util Functions ====================
// ========================================================

function getCookie(name) {
    return document.cookie.split('; ')
        .find(c => c.startsWith(`${name}=`))
        .replace(/^[^=]+=/, '')
}

function getAccountInfo() {
    const userInfo = JSON.parse(decodeURIComponent(getCookie('aws-userInfo')))
    let identityArn = userInfo.arn
    let identityDisplayName = decodeURIComponent(userInfo.username).replace(/^[^/]*\//, '')
    if (identityDisplayName.startsWith('AWSReservedSSO_')) {
        identityDisplayName = identityDisplayName.replace(/^AWSReservedSSO_/, '').replace(/_[^_]+\//, '/')
    }
    let accountId = userInfo.arn.split(':')[4]
    let accountAlias = userInfo.alias !== accountId ? userInfo.alias : undefined
    let issuer = decodeURI(userInfo.issuer)
    let issuerMatch = issuer.match(new RegExp(`/${accountId} \\((?<name>[^)]*)\\)/`))
    let accountName = issuerMatch ? issuerMatch.groups.name : undefined
    return {
        identityArn,
        identityDisplayName,
        accountId,
        accountAlias,
        issuer,
        accountName,
    }
}

function getAccountDisplayName(accountInfo) {
    return accountInfo.accountName || accountInfo.accountAlias || accountInfo.accountId
}

function isProduction(accountInfo) {
    const displayName = getAccountDisplayName(accountInfo)

    return displayName.match(/(^|[^a-zA-Z])(production|prod)([^a-zA-Z]|$)/)
}

function getAccountDisplayColor(accountInfo) {
    const displayName = getAccountDisplayName(accountInfo)

    if (displayName) {
        if(displayName.match(/(^|[^a-zA-Z])(production|prod)([^a-zA-Z]|$)/)) return 'e00000'
        if(displayName.match(/(^|[^a-zA-Z])(staging|stage|)([^a-zA-Z]|$)/)) return 'ffcd29'
        if(displayName.match(/(^|[^a-zA-Z])(lab|sandbox)([^a-zA-Z]|$)/)) return '81f561' //'55ee2b'
    }
    return '#bbb'
}

function getContrastColor(hexcolor) {
    const r = parseInt(hexcolor.substr(0, 2), 16);
    const g = parseInt(hexcolor.substr(2, 2), 16);
    const b = parseInt(hexcolor.substr(4, 2), 16);
    const yiq = (r * 299 + g * 587 + b * 114) / 1000;
    return yiq >= 128 ? "black" : "white";
}
