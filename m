From: Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH] f2fs: avoid the global name 'fault_name'
Date: Sat, 30 Jun 2018 23:57:03 +0800
Message-ID: <1530374223-130895-1-git-send-email-gaoxiang25@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc: Gao Xiang <gaoxiang25@huawei.com>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Non-prefix global name 'fault_name' will pollute global
namespace, fix it.

Refer to:
https://lists.01.org/pipermail/kbuild-all/2018-June/049660.html

To: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/f2fs/f2fs.h  | 4 ++--
 fs/f2fs/super.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 4d8b1de..11a2e09 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -65,7 +65,7 @@ struct f2fs_fault_info {
 	unsigned int inject_type;
 };
 
-extern char *fault_name[FAULT_MAX];
+extern char *f2fs_fault_name[FAULT_MAX];
 #define IS_FAULT_SET(fi, type) ((fi)->inject_type & (1 << (type)))
 #endif
 
@@ -1279,7 +1279,7 @@ struct f2fs_sb_info {
 #ifdef CONFIG_F2FS_FAULT_INJECTION
 #define f2fs_show_injection_info(type)				\
 	printk("%sF2FS-fs : inject %s in %s of %pF\n",		\
-		KERN_INFO, fault_name[type],			\
+		KERN_INFO, f2fs_fault_name[type],		\
 		__func__, __builtin_return_address(0))
 static inline bool time_to_inject(struct f2fs_sb_info *sbi, int type)
 {
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 3995e92..df12dcd 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -41,7 +41,7 @@
 
 #ifdef CONFIG_F2FS_FAULT_INJECTION
 
-char *fault_name[FAULT_MAX] = {
+char *f2fs_fault_name[FAULT_MAX] = {
 	[FAULT_KMALLOC]		= "kmalloc",
 	[FAULT_KVMALLOC]	= "kvmalloc",
 	[FAULT_PAGE_ALLOC]	= "page alloc",
-- 
1.9.1
