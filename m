From: Chao Yu <chao@kernel.org>
Subject: [PATCH 3/4] f2fs: reuse get_extent_info
Date: Wed,  4 May 2016 23:19:47 +0800
Message-ID: <1462375188-6493-2-git-send-email-chao@kernel.org>
References: <1462375188-6493-1-git-send-email-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1axycn-0000Af-Mt
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 04 May 2016 15:22:05 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1axycl-0005hX-Ui
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 04 May 2016 15:22:05 +0000
In-Reply-To: <1462375188-6493-1-git-send-email-chao@kernel.org>
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

Reuse get_extent_info for readability.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/extent_cache.c | 3 +--
 fs/f2fs/f2fs.h         | 8 ++++----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index c859bb0..5bfcdb9 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -196,8 +196,7 @@ bool f2fs_init_extent_tree(struct inode *inode, struct f2fs_extent *i_ext)
 	if (!i_ext || !i_ext->len)
 		return false;
 
-	set_extent_info(&ei, le32_to_cpu(i_ext->fofs),
-		le32_to_cpu(i_ext->blk), le32_to_cpu(i_ext->len));
+	get_extent_info(&ei, i_ext);
 
 	write_lock(&et->lock);
 	if (atomic_read(&et->node_cnt))
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index a87625f..99c593f 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -417,11 +417,11 @@ struct f2fs_inode_info {
 };
 
 static inline void get_extent_info(struct extent_info *ext,
-					struct f2fs_extent i_ext)
+					struct f2fs_extent *i_ext)
 {
-	ext->fofs = le32_to_cpu(i_ext.fofs);
-	ext->blk = le32_to_cpu(i_ext.blk);
-	ext->len = le32_to_cpu(i_ext.len);
+	ext->fofs = le32_to_cpu(i_ext->fofs);
+	ext->blk = le32_to_cpu(i_ext->blk);
+	ext->len = le32_to_cpu(i_ext->len);
 }
 
 static inline void set_raw_extent(struct extent_info *ext,
-- 
2.7.2


------------------------------------------------------------------------------
Find and fix application performance issues faster with Applications Manager
Applications Manager provides deep performance insights into multiple tiers of
your business applications. It resolves application problems quickly and
reduces your MTTR. Get your free trial!
https://ad.doubleclick.net/ddm/clk/302982198;130105516;z
