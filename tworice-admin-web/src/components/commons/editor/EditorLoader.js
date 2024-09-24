// src/utils/echartsLoader.js
import { loadScript } from '@/util/LoadScript';

let editorPromise = null;

export function loadEditor() {
    if (!editorPromise) {
        editorPromise = loadScript('/js/wangeditor.min.js');
    }
    return editorPromise;
}
