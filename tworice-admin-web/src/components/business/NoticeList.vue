<template>
    <div class="announcement-container">
        <h2 class="title">公告列表</h2>
        <div class="search-wrapper">
            <el-input v-model="search.title" placeholder="输入标题进行搜索" class="custom-search" clearable @keydown.enter.native="submitSearch">
                <template #prefix>
                    <i class="el-icon-search" />
                </template>
            </el-input>
        </div>
        <el-table
            :data="tableData"
            style="width: 100%"
            class="custom-table"
            :header-cell-style="headerStyle"
            :row-style="rowStyle"
        >
            <el-table-column prop="title" label="公告标题" width="400" class-name="title-column" >
                <template #default="{ row }">
                    <span class="title-text">{{ row.title }}</span>
                </template>
            </el-table-column>
            <el-table-column prop="nickName" label="发布人" width="180" align="center" />
            <el-table-column prop="createTime" label="发布时间" width="220" align="center" :formatter="(row)=>$utils.formatDate(row.createTime)" />
            <el-table-column label="操作" align="center">
                <template #default="{ row }">
                    <el-button type="text" class="detail-btn" @click="showNotice(row)">查看详情</el-button>
                </template>
            </el-table-column>
        </el-table>
        <div class="pagination-wrapper">
            <el-pagination @current-change="changePage" background layout="total,prev, pager, next" :total="total"
                           :page-size="pageSize"></el-pagination>
        </div>
    </div>
</template>

<script>
import paginationMixin from "@/mixins/paginationMixin";

export default {
    mixins: [paginationMixin],
    name: 'NoticeList',
    data() {
        return {
            pageUrlPath:'/admin/notice',
            search: {
                title: ''
            }
        }
    },
    methods: {
        showNotice(row) {
            this.$router.push('/admin/showNotice?id=' + row.id)
        },
        headerStyle() {
            return {
                backgroundColor: 'var(--themeColor)',
                color: '#ffffff',
                fontSize: '16px',
                fontWeight: 'bold'
            }
        },
        rowStyle() {
            return {
                backgroundColor: 'var(--themeColor)',
                color: '#ffffff',
                fontSize: '14px',
                transition: 'all 0.3s'
            }
        }
    }
}
</script>

<style lang="less" scoped>
.search-wrapper {
    max-width: 1200px;
    margin: 0 auto 30px;
    padding: 0 20px;
    
    .custom-search {
        /deep/ .el-input__inner {
            background-color: var(--themeColor);
            border: 1px solid var(--themeColor);
            border-radius: 20px;
            color: #fff;
            height: 40px;
            padding-left: 40px;
            transition: all 0.3s;
            
            &:focus {
                border-color: #409eff;
                box-shadow: 0 0 8px rgba(64, 158, 255, 0.3);
            }
            
            &::placeholder {
                color: #666;
            }
        }
        
        /deep/ .el-input__prefix {
            height: 40px;
            line-height: 40px;
            left: 12px;
            color: #666;
            .el-icon-search {
                font-size: 18px;
            }
        }
        
        /deep/ .el-input__clear {
            color: #e3e3e3;
            &:hover {
                color: #d8d8d8;
            }
        }
    }
}

.announcement-container {
    min-height: 100vh;
    padding: 40px 5%;
    
    .title {
        color:var(--themeColor);
        text-align: center;
        font-size: 28px;
        margin-bottom: 40px;
        letter-spacing: 2px;
    }
    
    .custom-table {
        max-width: 1200px;
        margin: 0 auto;
        background-color: transparent;
        
        /deep/ .el-table__body tr:hover > td {
            background-color: var(--themeColor) !important;
        }
        
        .title-text {
            font-weight: 500;
            transition: color 0.3s;
            
            &:hover {
                color: #000;
                cursor: pointer;
            }
        }
    }
    
    .pagination-wrapper {
        margin-top: 30px;
        display: flex;
        justify-content: center;
        
        /deep/ .custom-pagination {
            .el-pager {
                li {
                    background-color: var(--themeColor);
                    color: #ffffff;
                    
                    &.active {
                        background-color: #409eff !important;
                    }
                    
                    &:hover {
                        color: #000;
                    }
                }
            }
            
            button {
                background-color: var(--themeColor) !important;
                color: #ffffff !important;
                
                &:disabled {
                    opacity: 0.5;
                }
                
                &:hover:not(:disabled) {
                    color: #409eff !important;
                }
            }
        }
    }
    
    .detail-btn {
        color: #ffffff !important;
        
        &:hover {
            color: #000 !important;
        }
    }
}
</style>