From: Kinglong Mee <kinglongmee@gmail.com>
Subject: [PATCH] f2fs: use MAX_FREE_NIDS for the free nids target
Date: Sun, 26 Feb 2017 20:47:16 +0800
Message-ID: <8facba63-3a92-85a0-4257-9122fcb19fcd@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kinglongmee@gmail.com>) id 1chyEf-0000Kz-Df
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 26 Feb 2017 12:47:33 +0000
Received: from mail-io0-f193.google.com ([209.85.223.193])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1chyEe-0003zV-NE
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 26 Feb 2017 12:47:33 +0000
Received: by mail-io0-f193.google.com with SMTP id w10so3204882iod.3
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Sun, 26 Feb 2017 04:47:32 -0800 (PST)
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
Cc: linux-f2fs-devel@lists.sourceforge.net

F2FS has define MAX_FREE_NIDS for maximum of cached free nids target.

#define MAX_FREE_NIDS   (NAT_ENTRY_PER_BLOCK * FREE_NID_PAGES)

Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>
---
 fs/f2fs/node.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 6d43095..9284f65 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1870,7 +1870,6 @@ static void scan_free_nid_bits(struct f2fs_sb_info *sbi)
 	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
 	struct f2fs_journal *journal = curseg->journal;
 	unsigned int i, idx;
-	unsigned int target = FREE_NID_PAGES * NAT_ENTRY_PER_BLOCK;
 
 	down_read(&nm_i->nat_tree_lock);
 
@@ -1886,7 +1885,7 @@ static void scan_free_nid_bits(struct f2fs_sb_info *sbi)
 			nid = i * NAT_ENTRY_PER_BLOCK + idx;
 			add_free_nid(sbi, nid, true);
 
-			if (nm_i->nid_cnt[FREE_NID_LIST] >= target)
+			if (nm_i->nid_cnt[FREE_NID_LIST] >= MAX_FREE_NIDS)
 				goto out;
 		}
 	}
@@ -1912,7 +1911,6 @@ static int scan_nat_bits(struct f2fs_sb_info *sbi)
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 	struct page *page;
 	unsigned int i = 0;
-	nid_t target = FREE_NID_PAGES * NAT_ENTRY_PER_BLOCK;
 	nid_t nid;
 
 	if (!enabled_nat_bits(sbi, NULL))
@@ -1933,7 +1931,7 @@ static int scan_nat_bits(struct f2fs_sb_info *sbi)
 		add_free_nid(sbi, nid, true);
 	}
 
-	if (nm_i->nid_cnt[FREE_NID_LIST] >= target)
+	if (nm_i->nid_cnt[FREE_NID_LIST] >= MAX_FREE_NIDS)
 		goto out;
 	i++;
 	goto check_empty;
@@ -1951,7 +1949,7 @@ static int scan_nat_bits(struct f2fs_sb_info *sbi)
 	scan_nat_page(sbi, page, nid);
 	f2fs_put_page(page, 1);
 
-	if (nm_i->nid_cnt[FREE_NID_LIST] < target) {
+	if (nm_i->nid_cnt[FREE_NID_LIST] < MAX_FREE_NIDS) {
 		i++;
 		goto check_partial;
 	}
-- 
2.9.3


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
