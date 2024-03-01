export default {
    /**
     * 构建Vue页面的表单
     * @param item {field: "create_time", name: "创建时间", type: "bigint", query: false, queryType: '', dict: '', update: false, table: true, select: false}
     * @param fieldHump
     * @param form_item
     */
    buildVueForm(item,fieldHump,form_item) {
        form_item += "<el-form-item label='" + item.name + "' :label-width='formLabelWidth' prop='" + fieldHump + "'>";

        if (item.queryType === '数据表') {
            form_item +=
                "<el-select size='mini' v-model='form." + fieldHump + "' placeholder='请选择' clearable>" +
                "<el-option v-for='item in " + fieldHump + "Dict' :key='item.id' :label='item.name' :value='item.id'></el-option>"
                + "</el-select>"
        } else if (item.queryType === '字典') {
            form_item +=
                "<el-select size='mini' v-model='form." + fieldHump + "' placeholder='请选择' clearable>" +
                "<el-option v-for='item in " + fieldHump + "Dict' :key='item.id' :label='item.content' :value='item.content'></el-option>"
                + "</el-select>"
        } else if (item.inputForm === '数字计数器' && (item.type==='int' || item.type==='bigint')) {
            form_item += "<el-input-number  v-model='form." + fieldHump + "' @change='isChange = true' size='small'></el-input-number>";
        } else if (item.inputForm === '开关' && item.type==='int') {
            form_item += "<el-switch v-model='form." + fieldHump + "' @change='isChange = true' size='small'></el-switch>";
        } else if (item.inputForm === '日期选择器' && item.type==='bigint') {
            form_item += "<el-date-picker placeholder='请选择" + item.name + "' v-model='form." + fieldHump + "' value-format='timestamp' @change='isChange = true' size='small' type='date'></el-date-picker>";
        } else if (item.inputForm === '日期时间选择器' && item.type==='bigint') {
            form_item += "<el-date-picker placeholder='请选择" + item.name + "' v-model='form." + fieldHump + "' value-format='timestamp' @change='isChange = true' size='small' type='datetime'></el-date-picker>";
        } else {
            form_item += "<el-input placeholder='请输入" + item.name + "' v-model='form." + fieldHump + "' @change='isChange = true' size='small'></el-input>";
        }

        form_item += "</el-form-item>";
        return form_item;
    },

    /**
     * 构建Vue页面的搜索框
     * @param item
     * @param fieldHump
     * @param search_item
     */
    buildVueSearch(item,fieldHump,search_item){
        console.log(item)
        search_item += "<div class='search-item'>" + item.name + " : ";
        if (item.queryType === '数据表') {
            search_item +=
                "<el-select size='mini' v-model='search." + fieldHump + "' placeholder='通过" + item.name + "查询' clearable>" +
                "<el-option v-for='item in " + fieldHump + "Dict' :key='item.id' :label='item.name' :value='item.id'></el-option>"
                + "</el-select>"
        } else if (item.queryType === '字典') {
            search_item +=
                "<el-select size='mini' v-model='search." + fieldHump + "' placeholder='通过" + item.name + "查询' clearable>" +
                "<el-option v-for='item in " + fieldHump + "Dict' :key='item.id' :label='item.content' :value='item.content'></el-option>"
                + "</el-select>"
        } else if (item.inputForm === '数字计数器' && item.type==='int') {
            search_item += "<el-input-number  v-model='search." + fieldHump + "' @change='isChange = true' size='small'></el-input-number>";
        } else if (item.inputForm === '开关' && item.type==='int') {
            search_item += "<el-switch v-model='search." + fieldHump + "' @change='isChange = true' size='small'></el-switch>";
        } else if (item.inputForm === '日期选择器' && item.type==='bigint') {
            search_item += "<el-date-picker placeholder='请选择" + item.name + "' v-model='search." + fieldHump + "' value-format='timestamp' @change='isChange = true' size='small' type='date'></el-date-picker>";
        } else if (item.inputForm === '日期时间选择器' && item.type==='bigint') {
            search_item += "<el-date-picker placeholder='请选择" + item.name + "' v-model='search." + fieldHump + "' value-format='timestamp' @change='isChange = true' size='small' type='datetime'></el-date-picker>";
        } else {
            search_item +=
                "<el-input size='mini' v-model='search." + fieldHump + "' placeholder='通过" + item.name + "查询' clearable></el-input>";
        }
        search_item += "</div>";
        return search_item;
    },
    /**
     * 构建表格项
     * @param item 表格行数据
     * @param fieldHump 字段名的驼峰名称
     * @param table_item 当前生成的内容
     */
    buildTableItem(item,fieldHump,table_item,){
        let format = '';
        if (item.field === 'create_time' || item.field === 'update_time' || item.inputForm === '日期时间选择器') {
            format = ":formatter='(row)=>$utils.formatDateTime(row." + fieldHump + ")'";
        } else if (item.inputForm === '日期选择器') {
            format = ":formatter='(row)=>$utils.formatDate(row." + fieldHump + ")'";
        }
        return table_item += "<el-table-column prop='" + fieldHump + "' label='" + item.name + "' " + format + "></el-table-column>";
    }
}