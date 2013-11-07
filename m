From: Chao Yu <chao2.yu@samsung.com>
Subject: [f2fs-dev] [PATCH] f2fs: fix memory leak after kobject init failed in
 fill_super
Date: Thu, 07 Nov 2013 10:14:51 +0800
Message-ID: <000001cedb5f$497b8190$dc7284b0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: ??? <jaegeuk.kim@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, =?gb2312?B?zLfmrQ==?= <shu.tan@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

If we failed to init&add kobject when fill_super, stats info and proc object of f2fs will not be released.
We should free them before we finish fill_super.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/super.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index e42351c..a754d14 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -974,12 +974,12 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		/* After POR, we can run background GC thread.*/
 		err = start_gc_thread(sbi);
 		if (err)
-			goto fail;
+			goto free_gc;
 	}
 
 	err = f2fs_build_stats(sbi);
 	if (err)
-		goto fail;
+		goto free_gc;
 
 	if (f2fs_proc_root)
 		sbi->s_proc = proc_mkdir(sb->s_id, f2fs_proc_root);
@@ -1005,6 +1005,12 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 
 	return 0;
 fail:
+	if (sbi->s_proc) {
+		remove_proc_entry("segment_info", sbi->s_proc);
+		remove_proc_entry(sb->s_id, f2fs_proc_root);
+	}
+	f2fs_destroy_stats(sbi);
+free_gc:
 	stop_gc_thread(sbi);
 free_root_inode:
 	dput(sb->s_root);
-- 
1.7.9.5
