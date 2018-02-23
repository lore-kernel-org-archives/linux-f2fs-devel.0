From: Sheng Yong <shengyong1@huawei.com>
Subject: [RFC PATCH v2 6/7] fsck.f2fs: read nat block if nat
 entry is invalid
Date: Fri, 23 Feb 2018 11:18:00 +0800
Message-ID: <20180223031801.231805-7-shengyong1@huawei.com>
References: <20180223031801.231805-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <shengyong1@huawei.com>) id 1ep3sX-0003aG-74
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 23 Feb 2018 03:18:33 +0000
Received: from sfi-lb-mx.v20.lw.sourceforge.com ([172.30.20.201]
 helo=huawei.com) by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1ep3sU-0001J9-B8
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 23 Feb 2018 03:18:31 +0000
In-Reply-To: <20180223031801.231805-1-shengyong1@huawei.com>
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
Cc: hyojun@google.com, miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

fsck will cache all valid nat entries in memory. But when we try to
get a nat entry which is not cached, for example allocate a new nid
during reconnecting files, we need to read the uncached nat entry
from nat block again.

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 fsck/mount.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index 6482721..b8e7643 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -1600,7 +1600,9 @@ void get_node_info(struct f2fs_sb_info *sbi, nid_t nid, struct node_info *ni)
 	ni->nid = nid;
 	if (c.func == FSCK) {
 		node_info_from_raw_nat(ni, &(F2FS_FSCK(sbi)->entries[nid]));
-		return;
+		if (ni->blk_addr)
+			return;
+		/* nat entry is not cached, read it */
 	}
 
 	get_nat_entry(sbi, nid, &raw_nat);
-- 
2.14.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
