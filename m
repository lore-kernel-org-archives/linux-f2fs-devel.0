From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH] fsck.f2fs: free node_blk to avoid memory leak
Date: Wed, 21 Sep 2016 21:01:55 +0800
Message-ID: <1474462915-20999-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yunlong.song@huawei.com>) id 1bmh0R-0008Gj-Me
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 21 Sep 2016 12:52:07 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1bmh0I-0007nk-F6
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 21 Sep 2016 12:52:07 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com, yunlong.song@huawei.com
Cc: linux-f2fs-devel@lists.sourceforge.net

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fsck/fsck.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index e2081c8..2a4df7b 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -1696,6 +1696,7 @@ static void fix_hard_links(struct f2fs_sb_info *sbi)
 		node = node->next;
 		free(tmp);
 	}
+	free(node_blk);
 }
 
 static void fix_nat_entries(struct f2fs_sb_info *sbi)
-- 
1.8.5.2


------------------------------------------------------------------------------
