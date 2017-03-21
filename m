From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] f2fs: fix recording invalid last_victim
Date: Tue, 21 Mar 2017 20:09:45 +0800
Message-ID: <20170321120945.76050-2-yuchao0@huawei.com>
References: <20170321120945.76050-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1cqIc5-00043j-DO
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 21 Mar 2017 12:10:09 +0000
Received: from [45.249.212.189] (helo=dggrg03-dlp.huawei.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cqIc4-0002QI-4v
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 21 Mar 2017 12:10:09 +0000
In-Reply-To: <20170321120945.76050-1-yuchao0@huawei.com>
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
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

When doing garbage collection, we try to record segment offset which
locates at next one of last victim, using it as the start offset in
next searching.

But in some corner cases, recorded offset may cross the end of main
segment area, it will cause incorrectly searching in dirty_segmap
bitmap. This patch adds modular operation to avoid this issue.

Reported-by: Yunlei He <heyunlei@huawei.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/gc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 418fd9881646..939be88a8833 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -361,6 +361,7 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
 				sbi->last_victim[p.gc_mode] = last_victim + 1;
 			else
 				sbi->last_victim[p.gc_mode] = segno + 1;
+			sbi->last_victim[p.gc_mode] %= MAIN_SEGS(sbi);
 			break;
 		}
 	}
-- 
2.8.2.295.g3f1c1d0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
