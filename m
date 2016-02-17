From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] f2fs: move sanity checking of cp into
	get_valid_checkpoint
Date: Wed, 17 Feb 2016 11:26:32 +0800
Message-ID: <1455679592-5607-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shawn.lin@rock-chips.com>) id 1aVspn-0002y2-OO
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 17 Feb 2016 03:31:23 +0000
Received: from lucky1.263xmail.com ([211.157.147.132])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1aVspi-0005ju-Si
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 17 Feb 2016 03:31:23 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: Shawn Lin <shawn.lin@kernel-upstream.org>, Shawn Lin <shawn.lin@rock-chips.com>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

>From the function name of get_valid_checkpoint, it seems to return
the valid cp or NULL for caller to check. If no valid one is found,
f2fs_fill_super will print the err log. But if get_valid_checkpoint
get one valid(the return value indicate that it's valid, however actually
it is invalid after sanity checking), then print another similar err
log. That seems strange. Let's keep sanity checking inside the procedure
of geting valid cp. Another improvement we gained from this move is
that even the large volume is supported, we check the cp in advanced
to skip the following procedure if failing the sanity checking.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 fs/f2fs/checkpoint.c |  4 ++++
 fs/f2fs/f2fs.h       |  1 +
 fs/f2fs/super.c      | 10 +---------
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 536bec9..c374cc1 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -704,6 +704,10 @@ int get_valid_checkpoint(struct f2fs_sb_info *sbi)
 	cp_block = (struct f2fs_checkpoint *)page_address(cur_page);
 	memcpy(sbi->ckpt, cp_block, blk_size);
 
+	/* Sanity checking of checkpoint */
+	if (sanity_check_ckpt(sbi))
+		goto fail_no_cp;
+
 	if (cp_blks <= 1)
 		goto done;
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 66a87cb..7520c3f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1781,6 +1781,7 @@ int f2fs_commit_super(struct f2fs_sb_info *, bool);
 int f2fs_sync_fs(struct super_block *, int);
 extern __printf(3, 4)
 void f2fs_msg(struct super_block *, const char *, const char *, ...);
+int sanity_check_ckpt(struct f2fs_sb_info *sbi);
 
 /*
  * hash.c
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 73847fa..545e909 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1106,7 +1106,7 @@ static int sanity_check_raw_super(struct super_block *sb,
 	return 0;
 }
 
-static int sanity_check_ckpt(struct f2fs_sb_info *sbi)
+int sanity_check_ckpt(struct f2fs_sb_info *sbi)
 {
 	unsigned int total, fsmeta;
 	struct f2fs_super_block *raw_super = F2FS_RAW_SUPER(sbi);
@@ -1365,13 +1365,6 @@ try_onemore:
 		goto free_meta_inode;
 	}
 
-	/* sanity checking of checkpoint */
-	err = -EINVAL;
-	if (sanity_check_ckpt(sbi)) {
-		f2fs_msg(sb, KERN_ERR, "Invalid F2FS checkpoint");
-		goto free_cp;
-	}
-
 	sbi->total_valid_node_count =
 				le32_to_cpu(sbi->ckpt->valid_node_count);
 	sbi->total_valid_inode_count =
@@ -1539,7 +1532,6 @@ free_nm:
 	destroy_node_manager(sbi);
 free_sm:
 	destroy_segment_manager(sbi);
-free_cp:
 	kfree(sbi->ckpt);
 free_meta_inode:
 	make_bad_inode(sbi->meta_inode);
-- 
2.3.7



------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140
