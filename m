From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: avoid selinux denial on CAP_SYS_RESOURCE
Date: Thu,  8 Mar 2018 20:49:00 -0800
Message-ID: <20180309044900.39677-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1eu9xt-0005Ge-CY
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 09 Mar 2018 04:49:09 +0000
Received: from sfi-lb-mx.v20.lw.sourceforge.com ([172.30.20.201]
 helo=mail.kernel.org) by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1eu9xo-0088gt-Qr
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 09 Mar 2018 04:49:06 +0000
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

This fixes CAP_SYS_RESOURCE denial of selinux when using resgid.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/f2fs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f6dc70666ebb..3d12277fbe9e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1607,13 +1607,13 @@ static inline bool __allow_reserved_blocks(struct f2fs_sb_info *sbi,
 		return false;
 	if (IS_NOQUOTA(inode))
 		return true;
-	if (capable(CAP_SYS_RESOURCE))
-		return true;
 	if (uid_eq(sbi->s_resuid, current_fsuid()))
 		return true;
 	if (!gid_eq(sbi->s_resgid, GLOBAL_ROOT_GID) &&
 					in_group_p(sbi->s_resgid))
 		return true;
+	if (capable(CAP_SYS_RESOURCE))
+		return true;
 	return false;
 }
 
-- 
2.15.0.531.g2ccb3012c9-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
