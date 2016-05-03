From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 08/11] f2fs: inject ENOSPC failures
Date: Tue,  3 May 2016 11:21:45 -0700
Message-ID: <1462299708-67906-8-git-send-email-jaegeuk@kernel.org>
References: <1462299708-67906-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1axexW-0008Ut-Sj
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 03 May 2016 18:22:10 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1axexW-0005JY-2x
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 03 May 2016 18:22:10 +0000
In-Reply-To: <1462299708-67906-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch injects ENOSPC failures.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c |  7 +++++++
 fs/f2fs/dir.c        |  4 ++++
 fs/f2fs/f2fs.h       | 10 ++++++++++
 fs/f2fs/node.c       |  4 ++++
 fs/f2fs/super.c      |  4 ++++
 5 files changed, 29 insertions(+)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index ac87cd9..9169dab 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -474,6 +474,13 @@ int acquire_orphan_inode(struct f2fs_sb_info *sbi)
 	int err = 0;
 
 	spin_lock(&im->ino_lock);
+
+#ifdef CONFIG_F2FS_FAULT_INJECTION
+	if (time_to_inject(FAULT_ORPHAN)) {
+		spin_unlock(&im->ino_lock);
+		return -ENOSPC;
+	}
+#endif
 	if (unlikely(im->ino_num >= sbi->max_orphans))
 		err = -ENOSPC;
 	else
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 6bd0595..50f42be 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -537,6 +537,10 @@ int f2fs_add_regular_entry(struct inode *dir, const struct qstr *new_name,
 	}
 
 start:
+#ifdef CONFIG_F2FS_FAULT_INJECTION
+	if (time_to_inject(FAULT_DIR_DEPTH))
+		return -ENOSPC;
+#endif
 	if (unlikely(current_depth == MAX_DIR_HASH_DEPTH))
 		return -ENOSPC;
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 02c2c96..659fdea 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -41,6 +41,10 @@
 enum {
 	FAULT_KMALLOC,
 	FAULT_PAGE_ALLOC,
+	FAULT_ALLOC_NID,
+	FAULT_ORPHAN,
+	FAULT_BLOCK,
+	FAULT_DIR_DEPTH,
 	FAULT_MAX,
 };
 
@@ -1087,6 +1091,12 @@ static inline bool inc_valid_block_count(struct f2fs_sb_info *sbi,
 	block_t	valid_block_count;
 
 	spin_lock(&sbi->stat_lock);
+#ifdef CONFIG_F2FS_FAULT_INJECTION
+	if (time_to_inject(FAULT_BLOCK)) {
+		spin_unlock(&sbi->stat_lock);
+		return false;
+	}
+#endif
 	valid_block_count =
 		sbi->total_valid_block_count + (block_t)count;
 	if (unlikely(valid_block_count > sbi->user_block_count)) {
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index af010f5..78b98db 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1838,6 +1838,10 @@ bool alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid)
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct free_nid *i = NULL;
 retry:
+#ifdef CONFIG_F2FS_FAULT_INJECTION
+	if (time_to_inject(FAULT_ALLOC_NID))
+		return false;
+#endif
 	if (unlikely(sbi->total_valid_node_count + 1 > nm_i->available_nids))
 		return false;
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1715794..55e8eb0 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -46,6 +46,10 @@ atomic_t f2fs_ops;
 char *fault_name[FAULT_MAX] = {
 	[FAULT_KMALLOC]		= "kmalloc",
 	[FAULT_PAGE_ALLOC]	= "page alloc",
+	[FAULT_ALLOC_NID]	= "alloc nid",
+	[FAULT_ORPHAN]		= "orphan",
+	[FAULT_BLOCK]		= "no more block",
+	[FAULT_DIR_DEPTH]	= "too big dir depth",
 };
 #endif
 
-- 
2.6.3


------------------------------------------------------------------------------
Find and fix application performance issues faster with Applications Manager
Applications Manager provides deep performance insights into multiple tiers of
your business applications. It resolves application problems quickly and
reduces your MTTR. Get your free trial!
https://ad.doubleclick.net/ddm/clk/302982198;130105516;z
