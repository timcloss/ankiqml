import QtQuick 1.1
import com.nokia.meego 1.0

PageStackWindow {
    id: root

    initialPage: mainPage
    signal deckUpdated
    property bool decksNeedUpdate: true;

    MainPage {id: mainPage}

    ToolBar {
        id: sharedToolBar
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
    }

    PageStack {
        id: pageStack
        anchors {
             left: parent.left
             right: parent.right
             top: parent.top
             bottom: sharedToolBar.top
        }

        toolBar: sharedToolBar
    }

    SyncProgress {
        id: syncProgress
    }
    
    function updateSyncProgress(message) {
        syncProgress.state = (message == "" || message == "finished") ? "" : "active";
        syncProgress.updateMessage(message);
        if (message == "finished")
            deckUpdated();
    }

    function updateReloadProgress(value ) {
        mainPage.toggleView(value);
    }

    function decksUpdateTrigger() {
        decksNeedUpdate = true;
    }

    showStatusBar: false
    Component.onCompleted: mainPage.updateDecks()
}
