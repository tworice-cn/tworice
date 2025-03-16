/**
 * 动态懒加载加载js文件，
 * @param url
 * @returns {Promise<unknown>}
 */
export function loadScript(url) {
    return new Promise((resolve, reject) => {
        const script = document.createElement('script');
        script.type = 'text/javascript';
        script.src = url;
        script.onload = resolve;
        script.onerror = reject;
        document.head.appendChild(script);
    });
}
