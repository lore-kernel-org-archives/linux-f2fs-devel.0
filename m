From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] Revert "f2fs: reuse nids more aggressively"
Date: Mon, 25 Sep 2017 14:17:51 +0800
Message-ID: <20170925061751.71567-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yuchao0@huawei.com>) id 1dwMie-0000w9-Qx
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 25 Sep 2017 06:18:16 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1dwMid-0005MA-1A
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 25 Sep 2017 06:18:16 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Commit 268344664603 ("f2fs: reuse nids more aggressively") tries to
reuse nids as many as possilbe, in order to mitigate producing obsolete
node pages in page cache.

But acutally, before we reuse the nids and related node page cache,
we will always invalidate that node page, so there will be not any
obsolete node pages in cache.

Let's just revert previous commit, so that nm_i::next_scan_nid can be
increased ascendingly, making __build_free_nids traverses all NAT pages
more easily, finally, free nid bitmap cache can be enabled as soon as
possible.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/node.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index fc9f141eed9b..bfeaa0124670 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -327,10 +327,6 @@ static void set_node_addr(struct f2fs_sb_info *sbi, struct node_info *ni,
 	if (nat_get_blkaddr(e) != NEW_ADDR && new_blkaddr == NULL_ADDR) {
 		unsigned char version = nat_get_version(e);
 		nat_set_version(e, inc_node_version(version));
-
-		/* in order to reuse the nid */
-		if (nm_i->next_scan_nid > ni->nid)
-			nm_i->next_scan_nid = ni->nid;
 	}
 
 	/* change address */
-- 
2.13.1.388.g69e6b9b4f4a9


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
