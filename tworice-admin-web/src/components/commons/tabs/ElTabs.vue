<template>
    <div class="el-tabs">
        <!-- 标签头部 -->
        <div class="el-tabs__header">
            <div
                v-for="pane in panes"
                :key="pane.name"
                :class="['el-tabs__item', { 'is-active': pane.name === currentName }]"
                @click="handleTabClick(pane.name)"
            >
                {{ pane.label }}
            </div>
        </div>
        <!-- 标签内容区域 -->
        <div class="el-tabs__content">
            <slot></slot>
        </div>
    </div>
</template>

<script>
export default {
    name: 'ElTabs',
    props: {
        value: {
            type: String,
            default: ''
        }
    },
    data() {
        return {
            currentName: this.value,
            panes: [] // 用于存储子组件
        };
    },
    provide() {
        return {
            registerPane: this.registerPane, // 通过 provide/inject 让子组件注册自己
            currentName: () => this.currentName
        };
    },
    methods: {
        registerPane(pane) {
            this.panes.push(pane);
            if (!this.currentName) {
                this.currentName = pane.name;
                this.$emit('input', this.currentName);
            }
        },
        handleTabClick(name) {
            this.currentName = name;
            this.$emit('input', name);
        }
    },
    watch: {
        value(newVal) {
            this.currentName = newVal;
        }
    }
};
</script>

<style scoped>
.el-tabs {
    width: 100%;
}

.el-tabs__header {
    display: flex;
    border-bottom: 1px solid #ebeef5;
    background-color: #f5f7fa;
}

.el-tabs__item {
    flex: 1;
    text-align: center;
    cursor: pointer;
    color: #606266;
    transition: all 0.3s;
}

.el-tabs__item:hover {
    color: #409EFF;
}

.el-tabs__item.is-active {
    color: #409EFF;
    border-bottom: 2px solid #409EFF;
    font-weight: bold;
}

.el-tabs__content {
    padding: 20px;
    background-color: #fff;
}
</style>
