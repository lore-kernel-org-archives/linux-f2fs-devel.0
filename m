From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 1/2 v2] f2fs: allow to recover node blocks
 given updated checkpoint
Date: Sat, 20 Jan 2018 14:05:28 -0800
Message-ID: <20180120220528.GB28167@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180120042643.20717-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <jaegeuk@kernel.org>) id 1ed1Ga-0001UV-6C
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 20 Jan 2018 22:05:36 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1ed1GY-0006nB-DK
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 20 Jan 2018 22:05:36 +0000
Content-Disposition: inline
In-Reply-To: <20180120042643.20717-1-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

If fsck.f2fs changes crc, we have no way to recover some inode blocks by roll-
forward recovery. Let's relax the condition to recover them.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---

Change log from v1:
 - add a new checkpoint flag to handle this

 fs/f2fs/checkpoint.c    | 1 +
 fs/f2fs/node.h          | 4 ++++
 include/linux/f2fs_fs.h | 1 +
 3 files changed, 6 insertions(+)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 9c7596f7daae..512dca8abc7d 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1157,6 +1157,7 @@ static void update_ckpt_flags(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 
 	/* set this flag to activate crc|cp_ver for recovery */
 	__set_ckpt_flags(ckpt, CP_CRC_RECOVERY_FLAG);
+	__clear_ckpt_flags(ckpt, CP_NOCRC_RECOVERY_FLAG);
 
 	spin_unlock_irqrestore(&sbi->cp_lock, flags);
 }
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index 0ee3e5ff49a3..081ef0d672bf 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -305,6 +305,10 @@ static inline bool is_recoverable_dnode(struct page *page)
 	struct f2fs_checkpoint *ckpt = F2FS_CKPT(F2FS_P_SB(page));
 	__u64 cp_ver = cur_cp_version(ckpt);
 
+	/* Don't care crc part, if fsck.f2fs sets it. */
+	if (__is_set_ckpt_flags(ckpt, CP_NOCRC_RECOVERY_FLAG))
+		return (cp_ver << 32) == (cpver_of_node(page) << 32);
+
 	if (__is_set_ckpt_flags(ckpt, CP_CRC_RECOVERY_FLAG))
 		cp_ver |= (cur_cp_crc(ckpt) << 32);
 
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index cfb522e6affc..6eed677b6d9a 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -117,6 +117,7 @@ struct f2fs_super_block {
 /*
  * For checkpoint
  */
+#define CP_NOCRC_RECOVERY_FLAG	0x00000200
 #define CP_TRIMMED_FLAG		0x00000100
 #define CP_NAT_BITS_FLAG	0x00000080
 #define CP_CRC_RECOVERY_FLAG	0x00000040
-- 
2.15.0.531.g2ccb3012c9-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
