From: Nicholas Krause <xerofoify@gmail.com>
Subject: [PATCH] f2fs:Fix error handling for calls to the
	function add_free_nid in the file node.c
Date: Sat,  8 Aug 2015 18:22:20 -0400
Message-ID: <1439072540-25569-1-git-send-email-xerofoify@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xerofoify@gmail.com>) id 1ZOCVa-0001UZ-SV
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 08 Aug 2015 22:22:30 +0000
Received: from mail-io0-f175.google.com ([209.85.223.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZOCVZ-00043m-2a
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 08 Aug 2015 22:22:30 +0000
Received: by iodb91 with SMTP id b91so80573891iod.1
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Sat, 08 Aug 2015 15:22:23 -0700 (PDT)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This fixes error handling for calls to the function add_free_nid
in the functions __flush_nat_entry_set and build_free_nids to
properly check if their call to this particular function return
a error code and if so break out these function's for loops as
we cannot continue these loops if these function calls fail in

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 fs/f2fs/node.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 7dd63b7..1a3fb57 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1545,8 +1545,10 @@ static void build_free_nids(struct f2fs_sb_info *sbi)
 	for (i = 0; i < nats_in_cursum(sum); i++) {
 		block_t addr = le32_to_cpu(nat_in_journal(sum, i).block_addr);
 		nid = le32_to_cpu(nid_in_journal(sum, i));
-		if (addr == NULL_ADDR)
-			add_free_nid(sbi, nid, true);
+		if (addr == NULL_ADDR) {
+			if (add_free_nid(sbi, nid, true) < 0)
+				break;
+		}
 		else
 			remove_free_nid(nm_i, nid);
 	}
@@ -1879,8 +1881,10 @@ static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
 		__clear_nat_cache_dirty(NM_I(sbi), ne);
 		up_write(&NM_I(sbi)->nat_tree_lock);
 
-		if (nat_get_blkaddr(ne) == NULL_ADDR)
-			add_free_nid(sbi, nid, false);
+		if (nat_get_blkaddr(ne) == NULL_ADDR) {
+			if (add_free_nid(sbi, nid, false) < 0)
+				break;
+		}
 	}
 
 	if (to_journal)
-- 
2.1.4


------------------------------------------------------------------------------
