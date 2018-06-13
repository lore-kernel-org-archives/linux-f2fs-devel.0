From: Sheng Yong <shengyong1@huawei.com>
Subject: [PATCH 1/2] sload.f2fs: update sit entries of cursegs
Date: Wed, 13 Jun 2018 09:51:49 +0800
Message-ID: <20180613015150.197854-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <shengyong1@huawei.com>) id 1fSuxV-0005ay-Pv
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 13 Jun 2018 01:52:25 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fSuxT-005fDk-U5
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 13 Jun 2018 01:52:25 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

move_curseg_info->reset_curseg changes cursegs, however, new segment
entries are not set as dirty. As a result, flush_sit_entries will not
update entries in SIT, especially when an empty segment is selected
as the new curseg, its seg_entry->type is lost.

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 fsck/mount.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fsck/mount.c b/fsck/mount.c
index 0a30adb..68278c5 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -1149,6 +1149,7 @@ void reset_curseg(struct f2fs_sb_info *sbi, int type)
 		SET_SUM_TYPE(sum_footer, SUM_TYPE_NODE);
 	se = get_seg_entry(sbi, curseg->segno);
 	se->type = type;
+	se->dirty = 1;
 }
 
 static void read_compacted_summaries(struct f2fs_sb_info *sbi)
-- 
2.17.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
