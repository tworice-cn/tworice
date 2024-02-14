import Vue from 'vue';
export function type(){
    return Vue.prototype.$axios({
        url: '/client/systemFeedback/type',
        method: 'GET'
    })
}

export function submitForm(form){
    Vue.loading = true;
    let formData = new FormData();
    Object.keys(form).map(key => {
        if (form[key] != undefined && form[key] != '') {
            formData.append(key, form[key]);
        }
    });
    return Vue.prototype.$axios({
        url: '/client/systemFeedback/add',
        method: 'POST',
        data:formData
    })
}

export function chart(){
    return Vue.prototype.$axios({
        url: '/client/systemFeedback/stat',
        method: 'GET'
    })
}

