From: Colin King <colin.king@canonical.com>
Subject: [PATCH] f2fs: remove redundant initialization of pointer
 'p'
Date: Wed, 21 Feb 2018 18:13:40 +0000
Message-ID: <20180221181340.7596-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <colin.king@canonical.com>) id 1eoYtl-0003EW-CL
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 21 Feb 2018 18:13:45 +0000
Received: from sfi-lb-mx.v20.lw.sourceforge.com ([172.30.20.201]
 helo=youngberry.canonical.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtp (Exim 4.89)
 id 1eoYtl-0008I1-4p
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 21 Feb 2018 18:13:45 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, linux-f2fs-devel@lists.sourceforge.net
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer p is initialized with a value that is never read and is later
re-assigned a new value, hence the initialization is redundant and can
be removed.

Cleans up clang warning:
fs/f2fs/extent_cache.c:463:19: warning: Value stored to 'p' during
its initialization is never read

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/f2fs/extent_cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
index ff2352a0ed15..956b2744386b 100644
--- a/fs/f2fs/extent_cache.c
+++ b/fs/f2fs/extent_cache.c
@@ -460,7 +460,7 @@ static struct extent_node *__insert_extent_tree(struct inode *inode,
 				struct rb_node *insert_parent)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	struct rb_node **p = &et->root.rb_node;
+	struct rb_node **p;
 	struct rb_node *parent = NULL;
 	struct extent_node *en = NULL;
 
-- 
2.15.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
