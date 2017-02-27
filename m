From: Hou Pengyang <houpengyang@huawei.com>
Subject: [PATCH 3/3] f2fs: fix a plint compile warning
Date: Mon, 27 Feb 2017 13:02:59 +0000
Message-ID: <20170227130259.19987-3-houpengyang@huawei.com>
References: <20170227130259.19987-1-houpengyang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <houpengyang@huawei.com>) id 1ciKxj-00082B-E7
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 27 Feb 2017 13:03:35 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ciKxc-0004Z1-1Z
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 27 Feb 2017 13:03:35 +0000
In-Reply-To: <20170227130259.19987-1-houpengyang@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: linux-f2fs-devel@lists.sourceforge.net

fix such pclint warning:
...
Loss of precision (arg. no. 2) (unsigned long long to unsigned int))

Signed-off-by: Hou Pengyang <houpengyang@huawei.com>
---
 fs/f2fs/gc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 023f043..418fd98 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1009,6 +1009,6 @@ void build_gc_manager(struct f2fs_sb_info *sbi)
 	ovp_count = SM_I(sbi)->ovp_segments << sbi->log_blocks_per_seg;
 	blocks_per_sec = sbi->blocks_per_seg * sbi->segs_per_sec;
 
-	sbi->fggc_threshold = div_u64((main_count - ovp_count) * blocks_per_sec,
+	sbi->fggc_threshold = div64_u64((main_count - ovp_count) * blocks_per_sec,
 					(main_count - resv_count));
 }
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
