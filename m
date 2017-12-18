From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH v2] fsck.f2fs: check nid range before use to
 avoid segmentation fault
Date: Mon, 18 Dec 2017 19:53:45 +0800
Message-ID: <1513598025-160615-1-git-send-email-yunlong.song@huawei.com>
References: <1513319174-114303-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yunlong.song@huawei.com>) id 1eQtzx-0002Qi-97
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 18 Dec 2017 11:54:21 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.89) id 1eQtzv-0008Hg-Gc
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 18 Dec 2017 11:54:21 +0000
In-Reply-To: <1513319174-114303-1-git-send-email-yunlong.song@huawei.com>
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

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fsck/fsck.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 11b8b0b..faf0663 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -740,7 +740,7 @@ void fsck_chk_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 	for (idx = 0; idx < 5; idx++) {
 		u32 nid = le32_to_cpu(node_blk->i.i_nid[idx]);
 
-		if (nid != 0) {
+		if (nid != 0 && IS_VALID_NID(sbi, nid)) {
 			struct node_info ni;
 
 			get_node_info(sbi, nid, &ni);
-- 
1.8.5.2


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
