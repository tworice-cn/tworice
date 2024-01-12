<script>
export { default } from './userCenter';
</script>

<template>
	<div class="user-center">
		<BackBox :name="'用户中心'"></BackBox>
		<el-col :span="24" class="user-center-box">
			<el-col :span="6" class="left-box">
				<el-col :span="24" class="avatar-box">
					<el-avatar src="/favicon.ico"></el-avatar>
					<el-col :span="24" class="user-name">{{ adminInfo.nickName }}</el-col>
					<el-col :span="24" class="user-info">
						<div class="info-item el-icon-male">
							{{ adminInfo.adminSex == 1 ? '男' : adminInfo.adminSex == 2 ? '女' : '未知' }}
						</div>
						<div class="info-item el-icon-suitcase"> {{ adminInfo.roleName }}</div>
						<div class="info-item el-icon-location">
							{{ adminInfo.homePlace ? adminInfo.homePlace : '未知' }}
						</div>
					</el-col>
				</el-col>
				<el-col :span="24">
					<div class="menu-item-box" v-for="item in userMenu" @click="checkMenu(item.key)" v-if="(!item.me) || (isMe && item.me)">{{ item.name }}</div>
				</el-col>
			</el-col>
			<el-col :span="18" class="right-box">
				<el-col :span="24" class="info-box" v-if="activeName=='feedback'">
					<feedback></feedback>
				</el-col>
				<el-col :span="24" class="info-box" v-if="activeName=='userInfo'">
					<el-col :span="24" class="info-title">
						<el-col :span="12" class="title-left">用户信息</el-col>
						<el-col :span="12" class="title-right"><i class="el-icon-edit"
																  @click="formVisible=true" v-if="isMe">
							编辑</i></el-col>
					</el-col>
					<el-col :span="24" class="myinfo-box">
						<el-descriptions class="margin-top" :column="1" border>
							<el-descriptions-item>
								<template slot="label">
									<i class="el-icon-user"></i>
									用户名
								</template>
								{{ adminInfo.nickName }}
							</el-descriptions-item>
							<el-descriptions-item>
								<template slot="label">
									<i class="el-icon-coordinate"></i>
									角色
								</template>
								{{ adminInfo.roleName }}
							</el-descriptions-item>
							<el-descriptions-item>
								<template slot="label">
									<i class="el-icon-male"></i>
									性别
								</template>
								{{
									adminInfo.adminSex == 1 ? '男' : adminInfo.adminSex == 2 ? '女' : '未知'
								}}
							</el-descriptions-item>
							<el-descriptions-item>
								<template slot="label">
									<i class="el-icon-mobile-phone"></i>
									手机号
								</template>
								{{ adminInfo.adminPhone }}
							</el-descriptions-item>
							<el-descriptions-item>
								<template slot="label">
									<i class="el-icon-message"></i>
									邮箱
								</template>
								{{ adminInfo.adminEmail }}
							</el-descriptions-item>
							<el-descriptions-item>
								<template slot="label">
									<i class="el-icon-location-outline"></i>
									居住地
								</template>
								{{ adminInfo.homePlace }}
							</el-descriptions-item>
							<el-descriptions-item>
								<template slot="label">
									<i class="el-icon-office-building"></i>
									联系地址
								</template>
								{{ adminInfo.contactAddress }}
							</el-descriptions-item>
							<el-descriptions-item>
								<template slot="label">
									<i class="el-icon-tickets"></i>
									备注
								</template>
								{{ adminInfo.adminNote }}
							</el-descriptions-item>
						</el-descriptions>
					</el-col>
				</el-col>


				<el-col :span="24" class="info-box" v-if="activeName=='userLog'">
					<el-col :span="24" class="info-title">
						操作记录
					</el-col>
					<el-col :span="24" class="info-item" v-for="(item,index) in logList" :key="index">
						{{ index + 1 }}. {{ item.nickName }}于 {{ $utils.formatDate(item.time) }}
						{{ item.info }}
					</el-col>
					<el-col :span="24" class="none-more">- 没有更多了 -</el-col>
				</el-col>

				<el-col :span="24" class="info-box" v-if="activeName=='systemNotice'">
					<el-col :span="24" class="info-title">
						系统公告
					</el-col>
					<el-col :span="24" class="info-item" v-for="(item,index) in notice.list" :key="index">
						<el-col :span="16" class="notice-left" @click.native="showNotice(item)">
							{{ index + 1 }}. {{ item.title }}
						</el-col>
						<el-col :span="8" class="notice-right">
							{{ $utils.formatDate(item.createTime) }}
						</el-col>
					</el-col>
					<el-col :span="24" class="none-more">- 没有更多了 -</el-col>
				</el-col>
			</el-col>
		</el-col>
		<el-dialog title="编辑个人信息" :visible.sync="formVisible" width="40%" :before-close="$utils.handleClose">
			<el-form :model="adminInfo">
				<el-form-item label='用户名' :label-width='$setting.formLabelWidth'>
					<el-input placeholder='请输入用户名' v-model='adminInfo.nickName' size="small"></el-input>
				</el-form-item>
				<el-form-item label='性别' :label-width='$setting.formLabelWidth'>
					<el-select v-model="adminInfo.adminSex" placeholder="请选择性别" size="small"
							   @change='isChange = true'>
						<el-option label="未知" :value="3"></el-option>
						<el-option label="男" :value="1"></el-option>
						<el-option label="女" :value="2"></el-option>
					</el-select>
				</el-form-item>
				<el-form-item label='邮箱' :label-width='$setting.formLabelWidth'>
					<el-input placeholder='请输入邮箱' v-model='adminInfo.adminEmail'
							  @change='isChange = true'
							  size="small"></el-input>
				</el-form-item>
				<el-form-item label='手机号' :label-width='$setting.formLabelWidth'>
					<el-input placeholder='请输入手机号' v-model='adminInfo.adminPhone'
							  @change='isChange = true'
							  size="small"></el-input>
				</el-form-item>
				<el-form-item label='居住地' :label-width='$setting.formLabelWidth'>
					<el-input placeholder='请输入居住地' v-model='adminInfo.homePlace'
							  @change='isChange = true'
							  size="small"></el-input>
				</el-form-item>
				<el-form-item label='联系地址' :label-width='$setting.formLabelWidth'>
					<el-input placeholder='请输入联系地址' v-model='adminInfo.contactAddress'
							  @change='isChange = true'
							  size="small"></el-input>
				</el-form-item>
				<el-form-item label='备注' :label-width='$setting.formLabelWidth'>
					<el-input type="textarea" :rows="2" placeholder='请输入备注' v-model='adminInfo.adminNote'
							  @change='isChange = true' size="small"></el-input>
				</el-form-item>
			</el-form>
			<div slot="footer" class="dialog-footer">
				<el-button size="mini" @click="formVisible=false">取 消</el-button>
				<el-button size="mini" type="primary" @click="submit">确 定</el-button>
			</div>
		</el-dialog>
	</div>
</template>

<style lang="less" scoped>
.user-center {
	padding: 0 10px;
	cursor: default;

	.left-box {
		background-color: #cee9f7;
		border-radius: 4px;
		margin-bottom: 16px;
		// background-image: url('~@/assets/img/');
		.avatar-box {
			height: 150px;
			width: 280px;
			display: flex;
			justify-content: center;
			align-items: center;
			flex-direction: column;
			font-size: 14px;

			.el-avatar {
				width: 64px;
				height: 64px;
				background-color: #ecf5ff;
				margin-bottom: 12px;
				padding: 15px;
			}

			.user-name {
				text-align: center;
				margin-bottom: 16px;
				font-size: 16px;
			}

			.user-info {
				text-align: center;
				margin-bottom: 16px;
				display: flex;
				justify-content: center;
				align-items: center;

				.info-item {
					margin-right: 18px;
				}
			}
		}

		.menu-item-box{
			height: 60px;
			text-align: center;
		}
	}

	.right-box {
		padding-bottom: 20px;

		.info-box {
			//height: 500px;
			background-color: #fff;
			border-radius: 4px;
			overflow: auto;
			padding: 20px;

			.info-title {
				height: 60px;
				line-height: 60px;
				padding: 0 30px;
				font-size: 16px;

				.title-right {
					text-align: right;

					.el-icon-edit {
						cursor: pointer;
					}
				}
			}

			.info-item {
				font-size: 14px;
				padding: 10px 30px;
				color: #1b1b1b;

				&:hover {
					background-color: #cee9f780;
				}

				.notice-left {
					cursor: pointer;
				}

				.notice-right {
					text-align: right;
					padding-right: 20px;
				}
			}
		}

		.myinfo-box {
			padding: 0 30px;
			font-size: 14px;
		}
	}
}

</style>