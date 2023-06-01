javascript:(async function () {
    const iframeDocument = document.getElementById("applicationIframe").contentWindow.document;
    const meinBereichButton = iframeDocument.querySelector("li#mygroup");
    meinBereichButton.click();

    const arbeitszeituebersichtButton = iframeDocument.querySelector("li#zemstimecard");
    arbeitszeituebersichtButton.click();

    async function untilDefined(factory, checkInterval) {
        let value;
        await until(() => {
            value = factory();
            return value != null;
        }, checkInterval);
        return value;
    }

    async function until(check, checkInterval = 100) {
        while (!check()) {
            await sleep(checkInterval);
        }
    }

    async function sleep(timeout) {
        return new Promise(res => setTimeout(res, timeout));
    }
})();
