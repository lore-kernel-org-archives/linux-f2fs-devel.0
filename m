From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH] f2fs: fix a last_victim overflow problem
Date: Wed, 22 Mar 2017 10:54:00 +0800
Message-ID: <20170322025400.14274-1-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1cqWM0-0000zX-MT
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 22 Mar 2017 02:50:28 +0000
Received: from [45.249.212.188] (helo=dggrg02-dlp.huawei.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cqWLz-0005se-HQ
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 22 Mar 2017 02:50:28 +0000
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

This patch fix a last_victim overflow problem

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/gc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 418fd98..3b5e799a 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -361,6 +361,8 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
 				sbi->last_victim[p.gc_mode] = last_victim + 1;
 			else
 				sbi->last_victim[p.gc_mode] = segno + 1;
+
+			sbi->last_victim[p.gc_mode] %= MAIN_SEGS(sbi);
 			break;
 		}
 	}
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
