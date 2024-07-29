// src/utils/echartsLoader.js
import { loadScript } from '@/util/LoadScript';

let editorPromise = null;

export function loadEditor() {
    if (!editorPromise) {
        editorPromise = loadScript('https://cdn.jsdelivr.net/npm/@wangeditor/editor@5.1.23/dist/index.min.js');
    }
    return editorPromise;
}
