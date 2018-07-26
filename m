From: Sotirios-Efstathios Maneas <smaneas@cs.toronto.edu>
Subject: [PATCH 3/3] mkfs.f2fs: Fix the checkpoint version
 written to the footer of the root's inode
Date: Thu, 26 Jul 2018 18:02:07 -0400
Message-ID: <9F004D7E-1745-4AF2-A395-35437F2055FA@cs.toronto.edu>
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <smaneas@cs.toronto.edu>) id 1fj75W-0007mV-Ca
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 27 Jul 2018 18:03:38 +0000
Received: from aviary.cs.toronto.edu ([128.100.3.90])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:DHE-RSA-AES128-SHA:128) (Exim 4.90_1) id 1fj75U-0006gx-RB
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 27 Jul 2018 18:03:38 +0000
Received: from public-124-74.nat.utoronto.ca ([138.51.124.74]
 helo=[100.64.222.179])
 by aviary.cs.toronto.edu (as smtp.cs.toronto.edu) with esmtpsa
 (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256) (Exim 4.82)
 (envelope-from <smaneas@cs.toronto.edu>) id 1fioKl-0004Wo-I1
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 26 Jul 2018 18:02:07 -0400
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net

Fix the checkpoint version written to the footer of the root's inode.

---
 mkfs/f2fs_format.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index d844563..fe3112e 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -28,6 +28,7 @@ extern struct f2fs_configuration c;
 struct f2fs_super_block raw_sb;
 struct f2fs_super_block *sb = &raw_sb;
 struct f2fs_checkpoint *cp;
+int f2fs_checkpoint_version;
 
 /* Return first segment number of each area */
 #define prev_zone(cur)		(c.cur_seg[cur] - c.segs_per_zone)
@@ -619,8 +620,7 @@ static int f2fs_write_check_point_pack(void)
 	}
 
 	/* 1. cp page 1 of checkpoint pack 1 */
-	srand(time(NULL));
-	cp->checkpoint_ver = cpu_to_le64(rand() | 0x1);
+	cp->checkpoint_ver = cpu_to_le64(f2fs_checkpoint_version);
 	set_cp(cur_node_segno[0], c.cur_seg[CURSEG_HOT_NODE]);
 	set_cp(cur_node_segno[1], c.cur_seg[CURSEG_WARM_NODE]);
 	set_cp(cur_node_segno[2], c.cur_seg[CURSEG_COLD_NODE]);
@@ -1061,9 +1061,12 @@ static int f2fs_write_root_inode(void)
 		return -1;
 	}
 
+	srand(time(NULL));
+	f2fs_checkpoint_version = rand() | 0x1;
+
 	raw_node->footer.nid = sb->root_ino;
 	raw_node->footer.ino = sb->root_ino;
-	raw_node->footer.cp_ver = cpu_to_le64(1);
+	raw_node->footer.cp_ver = cpu_to_le64(f2fs_checkpoint_version);
 	raw_node->footer.next_blkaddr = cpu_to_le32(
 			get_sb(main_blkaddr) +
 			c.cur_seg[CURSEG_HOT_NODE] *
-- 
2.7.4

Kind regards,
Stathis Maneas


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
