From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH 2/2] f2fs: skip new checkpoint when doing fstrim
	without fs change
Date: Thu, 18 Aug 2016 21:01:19 +0800
Message-ID: <1471525279-12354-2-git-send-email-heyunlei@huawei.com>
References: <1471525279-12354-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1baMsJ-0006hm-Sw
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 18 Aug 2016 12:56:47 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1baMsD-0008R6-QU for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 18 Aug 2016 12:56:47 +0000
In-Reply-To: <1471525279-12354-1-git-send-email-heyunlei@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, yuchao0@huawei.com
Cc: heyunlei@huwei.com

This patch enables to do fstrim without checkpoint, if there is no fs
change.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/checkpoint.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index be1c54b..1207b91 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -1188,6 +1188,17 @@ int write_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 
 	f2fs_flush_merged_bios(sbi);
 
+	/* this is the case of multiple fstrims without any changes */
+	if (cpc->reason == CP_DISCARD && !is_sbi_flag_set(sbi, SBI_IS_DIRTY)) {
+		f2fs_bug_on(sbi, NM_I(sbi)->dirty_nat_cnt);
+		f2fs_bug_on(sbi, SIT_I(sbi)->dirty_sentries);
+		f2fs_bug_on(sbi, prefree_segments(sbi));
+		flush_sit_entries(sbi, cpc);
+		clear_prefree_segments(sbi, cpc);
+		unblock_operations(sbi);
+		goto out;
+	}
+
 	/*
 	 * update checkpoint pack index
 	 * Increase the version number so that
-- 
1.9.1


------------------------------------------------------------------------------
