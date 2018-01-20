From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs: allow to recover node blocks given
 updated checkpoint
Date: Fri, 19 Jan 2018 20:26:42 -0800
Message-ID: <20180120042643.20717-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.192]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <jaegeuk@kernel.org>) id 1eckk0-0006QZ-1W
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 20 Jan 2018 04:26:52 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eckjz-0000Gc-89
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 20 Jan 2018 04:26:51 +0000
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

If fsck.f2fs changes crc, we have no way to recover some inode blocks by roll-
forward recovery. Let's relax the condition to recover them.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index 0ee3e5ff49a3..15280eeb24ea 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -305,10 +305,11 @@ static inline bool is_recoverable_dnode(struct page *page)
 	struct f2fs_checkpoint *ckpt = F2FS_CKPT(F2FS_P_SB(page));
 	__u64 cp_ver = cur_cp_version(ckpt);
 
-	if (__is_set_ckpt_flags(ckpt, CP_CRC_RECOVERY_FLAG))
+	if (__is_set_ckpt_flags(ckpt, CP_CRC_RECOVERY_FLAG)) {
 		cp_ver |= (cur_cp_crc(ckpt) << 32);
-
-	return cp_ver == cpver_of_node(page);
+		return cp_ver == cpver_of_node(page);
+	}
+	return (cp_ver << 32) == (cpver_of_node(page) << 32);
 }
 
 /*
-- 
2.15.0.531.g2ccb3012c9-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
