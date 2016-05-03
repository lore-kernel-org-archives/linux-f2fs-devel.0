From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 07/11] f2fs: inject page allocation failures
Date: Tue,  3 May 2016 11:21:44 -0700
Message-ID: <1462299708-67906-7-git-send-email-jaegeuk@kernel.org>
References: <1462299708-67906-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1axexV-0006Ht-CS
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 03 May 2016 18:22:09 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1axexU-0005JV-IW
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 03 May 2016 18:22:09 +0000
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

This patch adds page allocation failures.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h  | 9 +++++++++
 fs/f2fs/super.c | 1 +
 2 files changed, 10 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 60098df..02c2c96 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -40,6 +40,7 @@
 #ifdef CONFIG_F2FS_FAULT_INJECTION
 enum {
 	FAULT_KMALLOC,
+	FAULT_PAGE_ALLOC,
 	FAULT_MAX,
 };
 
@@ -1296,6 +1297,14 @@ static inline unsigned int valid_inode_count(struct f2fs_sb_info *sbi)
 static inline struct page *f2fs_grab_cache_page(struct address_space *mapping,
 						pgoff_t index, bool for_write)
 {
+#ifdef CONFIG_F2FS_FAULT_INJECTION
+	struct page *page = find_lock_page(mapping, index);
+	if (page)
+		return page;
+
+	if (time_to_inject(FAULT_PAGE_ALLOC))
+		return NULL;
+#endif
 	if (!for_write)
 		return grab_cache_page(mapping, index);
 	return grab_cache_page_write_begin(mapping, index, AOP_FLAG_NOFS);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 76f4d2c..1715794 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -45,6 +45,7 @@ atomic_t f2fs_ops;
 
 char *fault_name[FAULT_MAX] = {
 	[FAULT_KMALLOC]		= "kmalloc",
+	[FAULT_PAGE_ALLOC]	= "page alloc",
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
