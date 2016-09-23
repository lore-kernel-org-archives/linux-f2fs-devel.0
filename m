From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/3] f2fs: support checkpoint error injection
Date: Fri, 23 Sep 2016 13:24:57 +0800
Message-ID: <20160923052458.83849-2-yuchao0@huawei.com>
References: <20160923052458.83849-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1bnIzI-0004iF-PS
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 23 Sep 2016 05:25:28 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1bnIzF-0003Zi-5E
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 23 Sep 2016 05:25:28 +0000
In-Reply-To: <20160923052458.83849-1-yuchao0@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch adds to support checkpoint error injection in f2fs for testing
fatal error tolerance.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h  | 7 +++++++
 fs/f2fs/super.c | 1 +
 2 files changed, 8 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e216bc0..3c513fe 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -47,6 +47,7 @@ enum {
 	FAULT_DIR_DEPTH,
 	FAULT_EVICT_INODE,
 	FAULT_IO,
+	FAULT_CHECKPOINT,
 	FAULT_MAX,
 };
 
@@ -80,6 +81,8 @@ static inline bool time_to_inject(int type)
 		return false;
 	else if (type == FAULT_IO && !IS_FAULT_SET(type))
 		return false;
+	else if (type == FAULT_CHECKPOINT && !IS_FAULT_SET(type))
+		return false;
 
 	atomic_inc(&f2fs_fault.inject_ops);
 	if (atomic_read(&f2fs_fault.inject_ops) >= f2fs_fault.inject_rate) {
@@ -1873,6 +1876,10 @@ static inline int f2fs_readonly(struct super_block *sb)
 
 static inline bool f2fs_cp_error(struct f2fs_sb_info *sbi)
 {
+#ifdef CONFIG_F2FS_FAULT_INJECTION
+	if (time_to_inject(FAULT_CHECKPOINT))
+		return true;
+#endif
 	return is_set_ckpt_flags(sbi, CP_ERROR_FLAG);
 }
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 6426855..3c49419 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -51,6 +51,7 @@ char *fault_name[FAULT_MAX] = {
 	[FAULT_DIR_DEPTH]	= "too big dir depth",
 	[FAULT_EVICT_INODE]	= "evict_inode fail",
 	[FAULT_IO]		= "IO error",
+	[FAULT_CHECKPOINT]	= "checkpoint error",
 };
 
 static void f2fs_build_fault_attr(unsigned int rate)
-- 
2.8.2.311.gee88674


------------------------------------------------------------------------------
