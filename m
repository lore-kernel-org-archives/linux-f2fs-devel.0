From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: fix coding style
Date: Wed, 30 Jul 2014 23:28:04 -0700
Message-ID: <1406788084-11274-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XCjq7-0006he-9b
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 31 Jul 2014 06:27:47 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XCjq6-0006st-7l for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 31 Jul 2014 06:27:47 +0000
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

This patch fixes wrong coding style.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h | 2 +-
 fs/f2fs/file.c | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 14b9f74..80c7869 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -781,7 +781,7 @@ static inline void *__bitmap_ptr(struct f2fs_sb_info *sbi, int flag)
 		if (flag == NAT_BITMAP)
 			return &ckpt->sit_nat_version_bitmap;
 		else
-			return ((unsigned char *)ckpt + F2FS_BLKSIZE);
+			return (unsigned char *)ckpt + F2FS_BLKSIZE;
 	} else {
 		offset = (flag == NAT_BITMAP) ?
 			le32_to_cpu(ckpt->sit_ver_bitmap_bytesize) : 0;
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 9550135..2a91a7d 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -231,8 +231,9 @@ static pgoff_t __get_first_dirty_index(struct address_space *mapping,
 
 	/* find first dirty page index */
 	pagevec_init(&pvec, 0);
-	nr_pages = pagevec_lookup_tag(&pvec, mapping, &pgofs, PAGECACHE_TAG_DIRTY, 1);
-	pgofs = nr_pages ? pvec.pages[0]->index: LONG_MAX;
+	nr_pages = pagevec_lookup_tag(&pvec, mapping, &pgofs,
+					PAGECACHE_TAG_DIRTY, 1);
+	pgofs = nr_pages ? pvec.pages[0]->index : LONG_MAX;
 	pagevec_release(&pvec);
 	return pgofs;
 }
-- 
1.8.5.2 (Apple Git-48)


------------------------------------------------------------------------------
Infragistics Professional
Build stunning WinForms apps today!
Reboot your WinForms applications with our WinForms controls. 
Build a bridge from your legacy apps to the future.
http://pubads.g.doubleclick.net/gampad/clk?id=153845071&iu=/4140/ostg.clktrk
