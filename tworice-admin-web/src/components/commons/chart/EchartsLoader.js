// src/utils/echartsLoader.js
import { loadScript } from '@/util/LoadScript';

let echartsPromise = null;
let wordCloudPromise = null;

export function loadECharts() {
    if (!echartsPromise) {
        echartsPromise = loadScript('https://cdnjs.cloudflare.com/ajax/libs/echarts/5.4.2/echarts.min.js');
    }
    return echartsPromise;
}

export function loadEChartsWordCloud() {
    if (!wordCloudPromise) {
        wordCloudPromise = loadScript('https://cdn.jsdelivr.net/npm/echarts-wordcloud/dist/echarts-wordcloud.min.js');
    }
    return wordCloudPromise;
}
