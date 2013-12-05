From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 1/3] f2fs: use inner macro GFP_F2FS_ZERO for
 simplification
Date: Thu, 05 Dec 2013 09:54:00 +0800
Message-ID: <001601cef15c$fd1a7d60$f74f7820$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1VoO9h-00086n-9t
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 05 Dec 2013 01:55:05 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1VoO9f-0002qh-Ah
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 05 Dec 2013 01:55:05 +0000
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout3.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0MXB00EQC9BJ2E40@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 05 Dec 2013 10:54:55 +0900 (KST)
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: ??? <jaegeuk.kim@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Use inner macro GFP_F2FS_ZERO to instead of GFP_NOFS | __GFP_ZERO for
simplification of code.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/node.c     |    2 +-
 fs/f2fs/recovery.c |    2 +-
 fs/f2fs/super.c    |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 0855168..099f06f 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1577,7 +1577,7 @@ static int ra_sum_pages(struct f2fs_sb_info *sbi, struct list_head *pages,
 
 	for (; page_idx < start + nrpages; page_idx++) {
 		/* alloc temporal page for read node summary info*/
-		page = alloc_page(GFP_NOFS | __GFP_ZERO);
+		page = alloc_page(GFP_F2FS_ZERO);
 		if (!page) {
 			struct page *tmp;
 			list_for_each_entry_safe(page, tmp, pages, lru) {
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index c209b86..7dda1f28 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -377,7 +377,7 @@ static int recover_data(struct f2fs_sb_info *sbi,
 	blkaddr = NEXT_FREE_BLKADDR(sbi, curseg);
 
 	/* read node page */
-	page = alloc_page(GFP_NOFS | __GFP_ZERO);
+	page = alloc_page(GFP_F2FS_ZERO);
 	if (!page)
 		return -ENOMEM;
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index dd55074..22b07c3 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -332,7 +332,7 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 {
 	struct f2fs_inode_info *fi;
 
-	fi = kmem_cache_alloc(f2fs_inode_cachep, GFP_NOFS | __GFP_ZERO);
+	fi = kmem_cache_alloc(f2fs_inode_cachep, GFP_F2FS_ZERO);
 	if (!fi)
 		return NULL;
 
-- 
1.7.9.5


------------------------------------------------------------------------------
Sponsored by Intel(R) XDK 
Develop, test and display web and hybrid apps with a single code base.
Download it for free now!
http://pubads.g.doubleclick.net/gampad/clk?id=111408631&iu=/4140/ostg.clktrk
