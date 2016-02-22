From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 5/5] f2fs crypto: fix incorrect positioning for
 GCing encrypted data page
Date: Mon, 22 Feb 2016 18:38:05 +0800
Message-ID: <004b01d16d5d$34e95cb0$9ebc1610$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1aXntG-00078P-Pr
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 22 Feb 2016 10:38:54 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aXntF-0004lM-9h
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 22 Feb 2016 10:38:54 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0O2Y005BJ2WI1690@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 22 Feb 2016 19:38:46 +0900 (KST)
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

For now, flow of GCing an encrypted data page will be:
1) try to grab meta page in meta inode's mapping with index of old block
address of that data page
2) load data of ciphertext into meta page
3) allocate new block address
4) write the meta page into new block address
5) update block address pointer in direct node page.

Other reader/writer will use f2fs_wait_on_encrypted_page_writeback to
check and wait on GCed encrypted data cached in meta page writebacked
in order to avoid inconsistence among data page cache, meta page cache
and data on-disk when updating.

However, we will use new block address updated in step 5) as an index to
lookup meta page in inner bio buffer. That would be wrong, and we will
never find the GCing meta page, since we use the old block address as
index of that page in step 1).

This patch fixes the issue by adjust the order of step 1) and step 3),
and in step 1) grab page with index generated in step 3).

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/gc.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 4af3d80..428159b 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -549,6 +549,7 @@ static void move_encrypted_block(struct inode *inode, block_t bidx)
 	struct f2fs_summary sum;
 	struct node_info ni;
 	struct page *page;
+	block_t newaddr;
 	int err;
 
 	/* do not read out */
@@ -579,12 +580,13 @@ static void move_encrypted_block(struct inode *inode, block_t bidx)
 	fio.page = page;
 	fio.new_blkaddr = fio.old_blkaddr = dn.data_blkaddr;
 
-	fio.encrypted_page = pagecache_get_page(META_MAPPING(fio.sbi),
-					fio.new_blkaddr,
-					FGP_LOCK|FGP_CREAT,
-					GFP_NOFS);
+	allocate_data_block(fio.sbi, NULL, fio.old_blkaddr, &newaddr,
+							&sum, CURSEG_COLD_DATA);
+
+	fio.encrypted_page = pagecache_get_page(META_MAPPING(fio.sbi), newaddr,
+					FGP_LOCK | FGP_CREAT, GFP_NOFS);
 	if (!fio.encrypted_page)
-		goto put_out;
+		goto invalid_block;
 
 	err = f2fs_submit_page_bio(&fio);
 	if (err)
@@ -607,9 +609,9 @@ static void move_encrypted_block(struct inode *inode, block_t bidx)
 
 	/* allocate block address */
 	f2fs_wait_on_page_writeback(dn.node_page, NODE, true);
-	allocate_data_block(fio.sbi, NULL, fio.old_blkaddr, &fio.new_blkaddr,
-							&sum, CURSEG_COLD_DATA);
+
 	fio.rw = WRITE_SYNC;
+	fio.new_blkaddr = newaddr;
 	f2fs_submit_page_mbio(&fio);
 
 	dn.data_blkaddr = fio.new_blkaddr;
@@ -620,6 +622,8 @@ static void move_encrypted_block(struct inode *inode, block_t bidx)
 		set_inode_flag(F2FS_I(inode), FI_FIRST_BLOCK_WRITTEN);
 put_page_out:
 	f2fs_put_page(fio.encrypted_page, 1);
+invalid_block:
+	invalidate_blocks(fio.sbi, newaddr);
 put_out:
 	f2fs_put_dnode(&dn);
 out:
-- 
2.7.0



------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140
