From: Chao Yu <chao@kernel.org>
Subject: [PATCH 2/3] f2fs: schedule in between two continous
	batch discards
Date: Sun, 21 Aug 2016 23:21:30 +0800
Message-ID: <1471792891-2388-2-git-send-email-chao@kernel.org>
References: <1471792891-2388-1-git-send-email-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1bbUbE-0006YV-0e
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 21 Aug 2016 15:23:48 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bbUbD-00055q-6A
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 21 Aug 2016 15:23:47 +0000
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

In batch discard approach of fstrim will grab/release gc_mutex lock
repeatly, it makes contention of the lock becoming more intensive.

So after one batch discards were issued in checkpoint and the lock
was released, it's better to do schedule() to increase opportunity
of grabbing gc_mutex lock for other competitors.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 020767c..d0f74eb 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1305,6 +1305,8 @@ int f2fs_trim_fs(struct f2fs_sb_info *sbi, struct fstrim_range *range)
 		mutex_unlock(&sbi->gc_mutex);
 		if (err)
 			break;
+
+		schedule();
 	}
 out:
 	range->len = F2FS_BLK_TO_BYTES(cpc.trimmed);
-- 
2.7.2


------------------------------------------------------------------------------
