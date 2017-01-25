From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs: fix to avoid overflow when left
	shifting page offset
Date: Wed, 25 Jan 2017 10:52:39 +0800
Message-ID: <20170125025240.13622-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1cWDiA-0000pf-TW
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 25 Jan 2017 02:53:26 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cWDi6-0003O6-3I
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 25 Jan 2017 02:53:26 +0000
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
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

We use following method to calculate size with current page index:
size = index << PAGE_SHIFT
If type of index has only 32-bits size, left shifting will incur overflow,
which makes result incorrect.

So let's cast index with 64-bits type to avoid such issue.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/recovery.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 4fb4471a3206..e93316ea8d1b 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -428,8 +428,9 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 		}
 
 		if (!file_keep_isize(inode) &&
-				(i_size_read(inode) <= (start << PAGE_SHIFT)))
-			f2fs_i_size_write(inode, (start + 1) << PAGE_SHIFT);
+			(i_size_read(inode) <= ((loff_t)start << PAGE_SHIFT)))
+			f2fs_i_size_write(inode,
+				(loff_t)(start + 1) << PAGE_SHIFT);
 
 		/*
 		 * dest is reserved block, invalidate src block
-- 
2.8.2.295.g3f1c1d0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
