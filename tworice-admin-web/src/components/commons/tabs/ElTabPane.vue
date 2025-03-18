<template>
    <div v-if="isActive" class="el-tab-pane">
        <slot></slot>
    </div>
</template>

<script>
export default {
    name: 'ElTabPane',
    props: {
        name: {
            type: String,
            required: true
        },
        label: {
            type: String,
            required: true
        }
    },
    inject: ['registerPane', 'currentName'],
    computed: {
        isActive() {
            return this.currentName() === this.name;
        }
    },
    created() {
        this.registerPane(this);
    }
};
</script>

<style scoped>
.el-tab-pane {
    background-color: white;
}
</style>
