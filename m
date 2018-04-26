From: kbuild test robot <lkp@intel.com>
Subject: [RFC PATCH f2fs] f2fs: release_discard_addr() can be
 static
Date: Fri, 27 Apr 2018 03:57:31 +0800
Message-ID: <20180426195731.GA71397@xian>
References: <201804270303.VPJ9nTL4%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <fengguang.wu@intel.com>) id 1fBn2H-0004Bm-SE
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 26 Apr 2018 19:58:33 +0000
Received: from mga12.intel.com ([192.55.52.136])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fBn29-00DC9q-UY
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 26 Apr 2018 19:58:33 +0000
Content-Disposition: inline
In-Reply-To: <201804270303.VPJ9nTL4%fengguang.wu@intel.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>, Chao Yu <chao@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, kbuild-all@01.org, linux-f2fs-devel@lists.sourceforge.net


Fixes: 6f89409e87ce ("f2fs: introduce release_discard_addr() for cleanup")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 segment.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 8652cfd..a0fce5e 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1598,7 +1598,7 @@ static bool add_discard_addrs(struct f2fs_sb_info *sbi, struct cp_control *cpc,
 	return false;
 }
 
-void release_discard_addr(struct discard_entry *entry)
+static void release_discard_addr(struct discard_entry *entry)
 {
 	list_del(&entry->list);
 	kmem_cache_free(discard_entry_slab, entry);

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
