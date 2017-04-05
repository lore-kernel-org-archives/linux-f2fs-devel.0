From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] f2fs: update max_orphans inode number
Date: Wed, 5 Apr 2017 18:01:27 +0800
Message-ID: <20170405100127.14233-1-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1cvhgy-0002iT-6p
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 05 Apr 2017 09:57:32 +0000
Received: from [45.249.212.189] (helo=dggrg03-dlp.huawei.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cvhgw-00053k-Ra
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 05 Apr 2017 09:57:32 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net

This patch update max_orphans inode number, remove nat bits blocks

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/checkpoint.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 9aba0bb..64dd429 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1357,8 +1357,8 @@ void init_ino_entry_info(struct f2fs_sb_info *sbi)
 	}
 
 	sbi->max_orphans = (sbi->blocks_per_seg - F2FS_CP_PACKS -
-			NR_CURSEG_TYPE - __cp_payload(sbi)) *
-				F2FS_ORPHANS_PER_BLOCK;
+			NR_CURSEG_TYPE - __cp_payload(sbi) -
+			NM_I(sbi)->nat_bits_blocks) * F2FS_ORPHANS_PER_BLOCK;
 }
 
 int __init create_checkpoint_caches(void)
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
