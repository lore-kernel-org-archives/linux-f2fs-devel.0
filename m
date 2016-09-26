From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2] f2fs: support checkpoint error injection
Date: Mon, 26 Sep 2016 19:45:55 +0800
Message-ID: <20160926114555.21195-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1boUMd-0000D0-VT
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 26 Sep 2016 11:46:27 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1boUMY-0000xd-N8
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 26 Sep 2016 11:46:27 +0000
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
fatal error tolerance, it will be useful that it can simulate abnormal
power off by f2fs itself instead of calling godown ioctl by running apps.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h    | 1 +
 fs/f2fs/gc.c      | 5 +++++
 fs/f2fs/segment.c | 5 +++++
 fs/f2fs/super.c   | 1 +
 4 files changed, 12 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 2545b04..59c97ad 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -47,6 +47,7 @@ enum {
 	FAULT_DIR_DEPTH,
 	FAULT_EVICT_INODE,
 	FAULT_IO,
+	FAULT_CHECKPOINT,
 	FAULT_MAX,
 };
 
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index a5c4175..c9b8a67 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -47,6 +47,11 @@ static int gc_thread_func(void *data)
 			continue;
 		}
 
+#ifdef CONFIG_F2FS_FAULT_INJECTION
+		if (time_to_inject(sbi, FAULT_CHECKPOINT))
+			f2fs_stop_checkpoint(sbi, false);
+#endif
+
 		/*
 		 * [GC triggering condition]
 		 * 0. GC is not conducted currently.
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index fbcc172..fc886f0 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -345,6 +345,11 @@ int commit_inmem_pages(struct inode *inode)
  */
 void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
 {
+#ifdef CONFIG_F2FS_FAULT_INJECTION
+	if (time_to_inject(sbi, FAULT_CHECKPOINT))
+		f2fs_stop_checkpoint(sbi, false);
+#endif
+
 	if (!need)
 		return;
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index a06eee4..4d5911b 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -50,6 +50,7 @@ char *fault_name[FAULT_MAX] = {
 	[FAULT_DIR_DEPTH]	= "too big dir depth",
 	[FAULT_EVICT_INODE]	= "evict_inode fail",
 	[FAULT_IO]		= "IO error",
+	[FAULT_CHECKPOINT]	= "checkpoint error",
 };
 
 static void f2fs_build_fault_attr(struct f2fs_sb_info *sbi,
-- 
2.8.2.311.gee88674


------------------------------------------------------------------------------
