From: Chao Yu <chao@kernel.org>
Subject: [PATCH v3 2/3] f2fs: trace checkpoint reason in fsync()
Date: Mon,  6 Nov 2017 22:51:45 +0800
Message-ID: <20171106145145.5153-1-chao@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

This patch slightly changes need_do_checkpoint to return the detail
info that indicates why we need do checkpoint, then caller could print
it with trace message.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v3: rebase the codes to dev-test branch.
 fs/f2fs/f2fs.h              | 12 ++++++++++++
 fs/f2fs/file.c              | 34 ++++++++++++++++++----------------
 include/trace/events/f2fs.h | 24 ++++++++++++++++++------
 3 files changed, 48 insertions(+), 22 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index cc46c22192ee..5c379a8ea075 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -913,6 +913,18 @@ enum need_lock_type {
 	LOCK_RETRY,
 };
 
+enum cp_reason_type {
+	CP_NO_NEEDED,
+	CP_NON_REGULAR,
+	CP_HARDLINK,
+	CP_SB_NEED_CP,
+	CP_WRONG_PINO,
+	CP_NO_SPC_ROLL,
+	CP_NODE_NEED_CP,
+	CP_FASTBOOT_MODE,
+	CP_SPEC_LOG_NUM,
+};
+
 enum iostat_type {
 	APP_DIRECT_IO,			/* app direct IOs */
 	APP_BUFFERED_IO,		/* app buffered IOs */
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 847e933e4a84..8742c028acc6 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -144,27 +144,29 @@ static int get_parent_ino(struct inode *inode, nid_t *pino)
 	return 1;
 }
 
-static inline bool need_do_checkpoint(struct inode *inode)
+static inline enum cp_reason_type need_do_checkpoint(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	bool need_cp = false;
+	enum cp_reason_type cp_reason = CP_NO_NEEDED;
 
-	if (!S_ISREG(inode->i_mode) || inode->i_nlink != 1)
-		need_cp = true;
+	if (!S_ISREG(inode->i_mode))
+		cp_reason = CP_NON_REGULAR;
+	else if (inode->i_nlink != 1)
+		cp_reason = CP_HARDLINK;
 	else if (is_sbi_flag_set(sbi, SBI_NEED_CP))
-		need_cp = true;
+		cp_reason = CP_SB_NEED_CP;
 	else if (file_wrong_pino(inode))
-		need_cp = true;
+		cp_reason = CP_WRONG_PINO;
 	else if (!space_for_roll_forward(sbi))
-		need_cp = true;
+		cp_reason = CP_NO_SPC_ROLL;
 	else if (!is_checkpointed_node(sbi, F2FS_I(inode)->i_pino))
-		need_cp = true;
+		cp_reason = CP_NODE_NEED_CP;
 	else if (test_opt(sbi, FASTBOOT))
-		need_cp = true;
+		cp_reason = CP_FASTBOOT_MODE;
 	else if (sbi->active_logs == 2)
-		need_cp = true;
+		cp_reason = CP_SPEC_LOG_NUM;
 
-	return need_cp;
+	return cp_reason;
 }
 
 static bool need_inode_page_update(struct f2fs_sb_info *sbi, nid_t ino)
@@ -199,7 +201,7 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	nid_t ino = inode->i_ino;
 	int ret = 0;
-	bool need_cp = false;
+	enum cp_reason_type cp_reason = 0;
 	struct writeback_control wbc = {
 		.sync_mode = WB_SYNC_ALL,
 		.nr_to_write = LONG_MAX,
@@ -218,7 +220,7 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 	clear_inode_flag(inode, FI_NEED_IPU);
 
 	if (ret) {
-		trace_f2fs_sync_file_exit(inode, need_cp, datasync, ret);
+		trace_f2fs_sync_file_exit(inode, cp_reason, datasync, ret);
 		return ret;
 	}
 
@@ -249,10 +251,10 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 	 * sudden-power-off.
 	 */
 	down_read(&F2FS_I(inode)->i_sem);
-	need_cp = need_do_checkpoint(inode);
+	cp_reason = need_do_checkpoint(inode);
 	up_read(&F2FS_I(inode)->i_sem);
 
-	if (need_cp) {
+	if (cp_reason) {
 		/* all the dirty node pages should be flushed for POR */
 		ret = f2fs_sync_fs(inode->i_sb, 1);
 
@@ -309,7 +311,7 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 	}
 	f2fs_update_time(sbi, REQ_TIME);
 out:
-	trace_f2fs_sync_file_exit(inode, need_cp, datasync, ret);
+	trace_f2fs_sync_file_exit(inode, cp_reason, datasync, ret);
 	f2fs_trace_ios(NULL, 1);
 	return ret;
 }
diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
index 009745564214..30d30399db02 100644
--- a/include/trace/events/f2fs.h
+++ b/include/trace/events/f2fs.h
@@ -136,6 +136,18 @@ TRACE_DEFINE_ENUM(CP_TRIMMED);
 		{ CP_UMOUNT,	"Umount" },				\
 		{ CP_TRIMMED,	"Trimmed" })
 
+#define show_fsync_cpreason(type)					\
+	__print_symbolic(type,						\
+		{ CP_NO_NEEDED,		"no needed" },			\
+		{ CP_NON_REGULAR,	"non regular" },		\
+		{ CP_HARDLINK,		"hardlink" },			\
+		{ CP_SB_NEED_CP,	"sb needs cp" },		\
+		{ CP_WRONG_PINO,	"wrong pino" },			\
+		{ CP_NO_SPC_ROLL,	"no space roll forward" },	\
+		{ CP_NODE_NEED_CP,	"node needs cp" },		\
+		{ CP_FASTBOOT_MODE,	"fastboot mode" },		\
+		{ CP_SPEC_LOG_NUM,	"log type is 2" })
+
 struct victim_sel_policy;
 struct f2fs_map_blocks;
 
@@ -210,14 +222,14 @@ DEFINE_EVENT(f2fs__inode, f2fs_sync_file_enter,
 
 TRACE_EVENT(f2fs_sync_file_exit,
 
-	TP_PROTO(struct inode *inode, int need_cp, int datasync, int ret),
+	TP_PROTO(struct inode *inode, int cp_reason, int datasync, int ret),
 
-	TP_ARGS(inode, need_cp, datasync, ret),
+	TP_ARGS(inode, cp_reason, datasync, ret),
 
 	TP_STRUCT__entry(
 		__field(dev_t,	dev)
 		__field(ino_t,	ino)
-		__field(int,	need_cp)
+		__field(int,	cp_reason)
 		__field(int,	datasync)
 		__field(int,	ret)
 	),
@@ -225,15 +237,15 @@ TRACE_EVENT(f2fs_sync_file_exit,
 	TP_fast_assign(
 		__entry->dev		= inode->i_sb->s_dev;
 		__entry->ino		= inode->i_ino;
-		__entry->need_cp	= need_cp;
+		__entry->cp_reason	= cp_reason;
 		__entry->datasync	= datasync;
 		__entry->ret		= ret;
 	),
 
-	TP_printk("dev = (%d,%d), ino = %lu, checkpoint is %s, "
+	TP_printk("dev = (%d,%d), ino = %lu, cp_reason: %s, "
 		"datasync = %d, ret = %d",
 		show_dev_ino(__entry),
-		__entry->need_cp ? "needed" : "not needed",
+		show_fsync_cpreason(__entry->cp_reason),
 		__entry->datasync,
 		__entry->ret)
 );
-- 
2.14.1.145.gb3622a4ee
