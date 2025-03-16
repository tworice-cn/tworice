/**本插件实现全屏显示和退出全屏 */
export default {
    // 全屏显示
    requestScreenFull: function () {
        const docElm = document.documentElement
        if (docElm.requestFullscreen) {
            docElm.requestFullscreen()
        } else if (docElm.msRequestFullscreen) {
            docElm.msRequestFullscreen()
        } else if (docElm.mozRequestFullScreen) {
            docElm.mozRequestFullScreen()
        } else if (docElm.webkitRequestFullScreen) {
            docElm.webkitRequestFullScreen()
        }
    },
    // 退出全屏
    exitScreenFull: function () {
        if (document.exitFullscreen) {
            document.exitFullscreen()
        } else if (document.msExitFullscreen) {
            document.msExitFullscreen()
        } else if (document.mozCancelFullScreen) {
            document.mozCancelFullScreen()
        } else if (document.webkitCancelFullScreen) {
            document.webkitCancelFullScreen()
        }
    }
};