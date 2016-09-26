From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] f2fs: fix to recover old fault injection
	config in ->remount_fs
Date: Mon, 26 Sep 2016 19:45:06 +0800
Message-ID: <20160926114506.20974-2-yuchao0@huawei.com>
References: <20160926114506.20974-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1boULt-00022D-OK
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 26 Sep 2016 11:45:41 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1boULn-0006jK-FK
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 26 Sep 2016 11:45:41 +0000
In-Reply-To: <20160926114506.20974-1-yuchao0@huawei.com>
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

In ->remount_fs, we didn't recover original fault injection config if
we encounter error, fix it.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/super.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index aa35e60..6132b4c 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1001,6 +1001,9 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	bool need_restart_gc = false;
 	bool need_stop_gc = false;
 	bool no_extent_cache = !test_opt(sbi, EXTENT_CACHE);
+#ifdef CONFIG_F2FS_FAULT_INJECTION
+	struct f2fs_fault_info ffi = sbi->fault_info;
+#endif
 
 	/*
 	 * Save the old mount options in case we
@@ -1096,6 +1099,9 @@ restore_gc:
 restore_opts:
 	sbi->mount_opt = org_mount_opt;
 	sbi->active_logs = active_logs;
+#ifdef CONFIG_F2FS_FAULT_INJECTION
+	sbi->fault_info = ffi;
+#endif
 	return err;
 }
 
-- 
2.8.2.311.gee88674


------------------------------------------------------------------------------
