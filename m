From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] f2fs: use existing macro to clean up some codes
Date: Thu, 27 Feb 2014 19:52:21 +0800
Message-ID: <001301cf33b2$81e816a0$85b843e0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1WIzWr-0004XV-Jn
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 27 Feb 2014 11:53:29 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1WIzWp-0000U1-L0
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 27 Feb 2014 11:53:29 +0000
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0N1N006D4L0WE3B0@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 27 Feb 2014 20:53:20 +0900 (KST)
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

This patch use existing macro F2FS_INODE/NEXT_FREE_BLKADDR to clean up some
codes.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/f2fs.h     |    6 ++----
 fs/f2fs/recovery.c |    2 +-
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index cc0b27f..459078b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -996,8 +996,7 @@ static inline unsigned int addrs_per_inode(struct f2fs_inode_info *fi)
 
 static inline void *inline_xattr_addr(struct page *page)
 {
-	struct f2fs_inode *ri;
-	ri = (struct f2fs_inode *)page_address(page);
+	struct f2fs_inode *ri = F2FS_INODE(page);
 	return (void *)&(ri->i_addr[DEF_ADDRS_PER_INODE -
 					F2FS_INLINE_XATTR_ADDRS]);
 }
@@ -1017,8 +1016,7 @@ static inline int f2fs_has_inline_data(struct inode *inode)
 
 static inline void *inline_data_addr(struct page *page)
 {
-	struct f2fs_inode *ri;
-	ri = (struct f2fs_inode *)page_address(page);
+	struct f2fs_inode *ri = F2FS_INODE(page);
 	return (void *)&(ri->i_addr[1]);
 }
 
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 72adbbf..aef7768 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -136,7 +136,7 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head)
 
 	/* get node pages in the current segment */
 	curseg = CURSEG_I(sbi, CURSEG_WARM_NODE);
-	blkaddr = START_BLOCK(sbi, curseg->segno) + curseg->next_blkoff;
+	blkaddr = NEXT_FREE_BLKADDR(sbi, curseg);
 
 	/* read node page */
 	page = alloc_page(GFP_F2FS_ZERO);
-- 
1.7.9.5


------------------------------------------------------------------------------
Flow-based real-time traffic analytics software. Cisco certified tool.
Monitor traffic, SLAs, QoS, Medianet, WAAS etc. with NetFlow Analyzer
Customize your own dashboards, set traffic alerts and generate reports.
Network behavioral analysis & security monitoring. All-in-one tool.
http://pubads.g.doubleclick.net/gampad/clk?id=126839071&iu=/4140/ostg.clktrk
