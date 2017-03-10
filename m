From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v2] f2fs: add fault injection on f2fs_truncate
Date: Thu, 9 Mar 2017 17:54:08 -0800
Message-ID: <20170310015408.GA14868@jaegeuk.local>
References: <20170309232827.9304-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170309232827.9304-1-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Change log from v1:
 - add missing fault name

>From be7652ae901bfda478a2915abcec5dd1e2f4b823 Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Thu, 9 Mar 2017 15:24:24 -0800
Subject: [PATCH] f2fs: add fault injection on f2fs_truncate

Inject a fault during f2fs_truncate().

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h  | 1 +
 fs/f2fs/file.c  | 6 ++++++
 fs/f2fs/super.c | 1 +
 3 files changed, 8 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 870bb4d9bc65..7edb3bea15a4 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -50,6 +50,7 @@ enum {
 	FAULT_BLOCK,
 	FAULT_DIR_DEPTH,
 	FAULT_EVICT_INODE,
+	FAULT_TRUNCATE,
 	FAULT_IO,
 	FAULT_CHECKPOINT,
 	FAULT_MAX,
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 0110c263a705..4ec764ea89bd 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -620,6 +620,12 @@ int f2fs_truncate(struct inode *inode)
 
 	trace_f2fs_truncate(inode);
 
+#ifdef CONFIG_F2FS_FAULT_INJECTION
+	if (time_to_inject(F2FS_I_SB(inode), FAULT_TRUNCATE)) {
+		f2fs_show_injection_info(FAULT_TRUNCATE);
+		return -EIO;
+	}
+#endif
 	/* we should check inline_data size */
 	if (!f2fs_may_inline_data(inode)) {
 		err = f2fs_convert_inline_inode(inode);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index cfb40d3fd875..17126a2897ad 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -49,6 +49,7 @@ char *fault_name[FAULT_MAX] = {
 	[FAULT_BLOCK]		= "no more block",
 	[FAULT_DIR_DEPTH]	= "too big dir depth",
 	[FAULT_EVICT_INODE]	= "evict_inode fail",
+	[FAULT_TRUNCATE]	= "truncate fail",
 	[FAULT_IO]		= "IO error",
 	[FAULT_CHECKPOINT]	= "checkpoint error",
 };
-- 
2.11.0
