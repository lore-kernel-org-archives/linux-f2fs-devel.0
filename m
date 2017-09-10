From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH] f2fs-tools: move_curseg_info only if
 check_curseg_offset fails
Date: Mon, 11 Sep 2017 00:20:36 +0800
Message-ID: <1505060436-45299-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yunlong.song@huawei.com>)
 id 1dr4yi-0006Gx-DO
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 10 Sep 2017 16:21:00 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1dr4yg-0003vS-Ca
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 10 Sep 2017 16:21:00 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com, yunlong.song@huawei.com
Cc: linux-fsdevel@vger.kernel.org, miaoxie@huawei.com, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Current design will lose recovery process when check_curseg_offset is OK.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fsck/fsck.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index cb341ba..56a47be 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -2026,9 +2026,11 @@ int fsck_verify(struct f2fs_sb_info *sbi)
 			fix_hard_links(sbi);
 			fix_nat_entries(sbi);
 			rewrite_sit_area_bitmap(sbi);
-			move_curseg_info(sbi, SM_I(sbi)->main_blkaddr);
-			write_curseg_info(sbi);
-			flush_curseg_sit_entries(sbi);
+			if (check_curseg_offset(sbi)) {
+				move_curseg_info(sbi, SM_I(sbi)->main_blkaddr);
+				write_curseg_info(sbi);
+				flush_curseg_sit_entries(sbi);
+			}
 			fix_checkpoint(sbi);
 		} else if (is_set_ckpt_flags(cp, CP_FSCK_FLAG)) {
 			write_checkpoint(sbi);
-- 
1.8.5.2


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
