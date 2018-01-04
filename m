From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH v3] f2fs: check segment type in
 __f2fs_replace_block
Date: Thu, 4 Jan 2018 14:24:36 +0800
Message-ID: <1515047076-27582-1-git-send-email-yunlong.song@huawei.com>
References: <1514619768-134531-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yunlong.song@huawei.com>) id 1eWyxj-0000ZI-1P
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 04 Jan 2018 06:25:11 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eWyxh-0002DW-BZ
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 04 Jan 2018 06:25:10 +0000
In-Reply-To: <1514619768-134531-1-git-send-email-yunlong.song@huawei.com>
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
Cc: shengyong1@huawei.com, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, heyunlei@huawei.com, linux-fsdevel@vger.kernel.org, miaoxie@huawei.com

In some case, the node blocks has wrong blkaddr whose segment type is
NODE, e.g., recover inode has missing xattr flag and the blkaddr is in
the xattr range. Since fsck.f2fs does not check the recovery nodes, this
will cause __f2fs_replace_block change the curseg of node and do the
update_sit_entry(sbi, new_blkaddr, 1) with no next_blkoff refresh, as a
result, when recovery process write checkpoint and sync nodes, the
next_blkoff of curseg is used in the segment bit map, then it will
cause f2fs_bug_on. So let's check segment type in __f2fs_replace_block.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fs/f2fs/segment.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 890d483..6c6d2dd 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2719,6 +2719,8 @@ void __f2fs_replace_block(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 	se = get_seg_entry(sbi, segno);
 	type = se->type;
 
+	f2fs_bug_on(sbi, se->valid_blocks && !IS_DATASEG(type));
+
 	down_write(&SM_I(sbi)->curseg_lock);
 
 	if (!recover_curseg) {
-- 
1.8.5.2


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
