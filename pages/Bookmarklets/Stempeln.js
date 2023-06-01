javascript:(async function () {
    "// =======================================================";
    "// === Created by Bengt & Moritz =========================";
    "// =======================================================";

    "// === Configuration ====================================================";
    const nowTime = new Date().toLocaleString("de", { hour: "2-digit", hour12: false, minute: "2-digit" });
    "// ======================================================================";

    const iframeDocument = document.getElementById("applicationIframe").contentWindow.document;

    "// === Open Arbeitszeitübersicht ====================================================";
    const arbeitszeituebersichtButton = iframeDocument.querySelector("li#zemstimecard");
    arbeitszeituebersichtButton.click();

    "// === Add in time entry ====================================================";
    let rowNumber = 0;
    const body = await untilDefined(() => iframeDocument.querySelector(`#container_liste_zemstimecard_gridpart-body`));
    while (true) {
        rowNumber++;
        const row = body.querySelector(`table > tbody.z-rows > tr.z-row:nth-of-type(${ rowNumber })`);
        "// Need to query rows one by one, because row elements get replaced after inserting a time entry";
        if (!row) {
            console.info("Done!");
            break;
        }

        const date = row.querySelector("td:nth-of-type(2)").innerText;

        "// Break if newer than today";
        if ((parseGermanDate(date) - Date.now()) / 1000 / 60 / 60 / 24 > 0) {
            console.info("Done!");
            break;
        }

        const nowDate = new Date().toLocaleDateString("de", { year: "numeric", month: "2-digit", day: "2-digit" });
        if (date === nowDate) {
            const timecardCell = row.querySelector("td:nth-of-type(7)");
            timecardCell.click();
            let modalWindow = await untilDefined(() => iframeDocument.getElementById("modalWindow"));

            "// --- handle edit dialogue -------------------------------------------";
            const editButton = modalWindow.querySelector("button#spec_key1");
            if (editButton) {
                editButton.click();
                modalWindow = await untilDefined(() => {
                    const element = iframeDocument.getElementById("modalWindow");
                    if (element !== modalWindow) {
                        return element;
                    }
                })
            }

            "// --- Handle insert dialogue -----------------------------------------";
            const einstempelzeitInput = modalWindow.querySelector("input#time_in1");
            const ausstempelzeitInput = modalWindow.querySelector("input#time_out1");

            let timeHasChanged = false;

            if (einstempelzeitInput.value === "") {
                einstempelzeitInput.value = nowTime;
                einstempelzeitInput.dispatchEvent(new Event("blur"));
                timeHasChanged = true;
            } else if (ausstempelzeitInput.value !== nowTime) {
                ausstempelzeitInput.value = nowTime;
                ausstempelzeitInput.dispatchEvent(new Event("blur"));
                timeHasChanged = true;
            }

            let button = timeHasChanged
                ? modalWindow.querySelector("button#insert")
                : modalWindow.querySelector("button#acancel");

            button.click();
            await until(() => !iframeDocument.contains(modalWindow));
        }
    }
    "// === Util functions ===================================================";

    function parseGermanDate(dateString) {
        const dateSplit = dateString.split(".");
        return new Date(dateSplit[2], dateSplit[1] - 1, dateSplit[0]);
    }

    "// === in ms ===";

    async function sleep(timeout) {
        return new Promise(res => setTimeout(res, timeout));
    }

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
})();
