From: Chao Yu <chao@kernel.org>
Subject: [PATCH 3/3] f2fs: remove redundant judgement condition
	in available_free_memory
Date: Sun, 21 Aug 2016 23:21:31 +0800
Message-ID: <1471792891-2388-3-git-send-email-chao@kernel.org>
References: <1471792891-2388-1-git-send-email-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1bbUbG-0006rr-DR
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 21 Aug 2016 15:23:50 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bbUbF-0003hm-Nd
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 21 Aug 2016 15:23:50 +0000
In-Reply-To: <1471792891-2388-1-git-send-email-chao@kernel.org>
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

In available_free_memory, there are two same judgement conditions which
is used for checking NAT excess, remove one of them.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/node.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index f75d197..8a28800 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -54,8 +54,6 @@ bool available_free_memory(struct f2fs_sb_info *sbi, int type)
 		res = mem_size < ((avail_ram * nm_i->ram_thresh / 100) >> 2);
 		if (excess_cached_nats(sbi))
 			res = false;
-		if (nm_i->nat_cnt > DEF_NAT_CACHE_THRESHOLD)
-			res = false;
 	} else if (type == DIRTY_DENTS) {
 		if (sbi->sb->s_bdi->wb.dirty_exceeded)
 			return false;
-- 
2.7.2


------------------------------------------------------------------------------
