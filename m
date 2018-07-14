From: willow72 <willow72@willow72.org>
Subject: [PATCH] fs: f2fs: Insert a space around that ':'
Date: Sat, 14 Jul 2018 18:55:01 +0900
Message-ID: <20180714095501.GA27576@willow72.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <willow72@willow72.org>) id 1feHOB-0000Pz-HB
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 14 Jul 2018 10:02:55 +0000
Received: from [210.115.226.249] (helo=willow72)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtp (Exim 4.90_1)
 id 1feHOA-003AfS-1s
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 14 Jul 2018 10:02:55 +0000
Content-Disposition: inline
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

clean up checkpath error:
ERROR : space required around that :

Signed-off-by: youngjun yoo <youngjun.willow@gmail.com>
---
 fs/f2fs/debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
index 2d65e77..076b75b 100644
--- a/fs/f2fs/debug.c
+++ b/fs/f2fs/debug.c
@@ -269,8 +269,8 @@ static int stat_show(struct seq_file *s, void *v)
 
 		seq_printf(s, "\n=====[ partition info(%pg). #%d, %s, CP: %s]=====\n",
 			si->sbi->sb->s_bdev, i++,
-			f2fs_readonly(si->sbi->sb) ? "RO": "RW",
-			f2fs_cp_error(si->sbi) ? "Error": "Good");
+			f2fs_readonly(si->sbi->sb) ? "RO" : "RW",
+			f2fs_cp_error(si->sbi) ? "Error" : "Good");
 		seq_printf(s, "[SB: 1] [CP: 2] [SIT: %d] [NAT: %d] ",
 			   si->sit_area_segs, si->nat_area_segs);
 		seq_printf(s, "[SSA: %d] [MAIN: %d",
-- 
2.7.4


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
