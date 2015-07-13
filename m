From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 3/4] f2fs: cleanup write_orphan_inodes
Date: Mon, 13 Jul 2015 17:44:25 +0800
Message-ID: <008001d0bd50$98996f10$c9cc4d30$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1ZEaIU-0001ie-Do
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 13 Jul 2015 09:45:14 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZEaIS-0006qK-QW
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 13 Jul 2015 09:45:14 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout3.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NRF02O4V735RA80@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 13 Jul 2015 18:45:05 +0900 (KST)
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
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Previously, since 'commit 4531929e3922 ("f2fs: move grabing orphan
pages out of protection region")' was committed, in write_orphan_inodes(),
we will grab all meta page in a batch before we use them under spinlock,
so that we can avoid large time delay of grabbing meta pages under
spinlock.

Now, 'commit d6c67a4fee86 ("f2fs: revmove spin_lock for
write_orphan_inodes")' remove the spinlock in write_orphan_inodes,
so there is no issue we describe above, we'd better recover to move
the grab operation to original place for readability.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/checkpoint.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index de7a0d6..6032702 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -504,7 +504,7 @@ static void write_orphan_inodes(struct f2fs_sb_info *sbi, block_t start_blk)
 	struct list_head *head;
 	struct f2fs_orphan_block *orphan_blk = NULL;
 	unsigned int nentries = 0;
-	unsigned short index;
+	unsigned short index = 1;
 	unsigned short orphan_blocks;
 	struct page *page = NULL;
 	struct ino_entry *orphan = NULL;
@@ -512,11 +512,6 @@ static void write_orphan_inodes(struct f2fs_sb_info *sbi, block_t start_blk)
 
 	orphan_blocks = GET_ORPHAN_BLOCKS(im->ino_num);
 
-	for (index = 0; index < orphan_blocks; index++)
-		grab_meta_page(sbi, start_blk + index);
-
-	index = 1;
-
 	/*
 	 * we don't need to do spin_lock(&im->ino_lock) here, since all the
 	 * orphan inode operations are covered under f2fs_lock_op().
@@ -527,12 +522,10 @@ static void write_orphan_inodes(struct f2fs_sb_info *sbi, block_t start_blk)
 	/* loop for each orphan inode entry and write them in Jornal block */
 	list_for_each_entry(orphan, head, list) {
 		if (!page) {
-			page = find_get_page(META_MAPPING(sbi), start_blk++);
-			f2fs_bug_on(sbi, !page);
+			page = grab_meta_page(sbi, start_blk++);
 			orphan_blk =
 				(struct f2fs_orphan_block *)page_address(page);
 			memset(orphan_blk, 0, sizeof(*orphan_blk));
-			f2fs_put_page(page, 0);
 		}
 
 		orphan_blk->ino[nentries++] = cpu_to_le32(orphan->ino);
-- 
2.4.2



------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
