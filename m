From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH 2/2] f2fs: remove unnecessary wait in write_begin
Date: Fri, 17 Feb 2017 17:16:39 +0800
Message-ID: <20170217091639.29433-2-heyunlei@huawei.com>
References: <20170217091639.29433-1-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1ceebN-0005n4-AF
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 17 Feb 2017 09:13:17 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ceebM-0007as-Az
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 17 Feb 2017 09:13:17 +0000
In-Reply-To: <20170217091639.29433-1-heyunlei@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net

It has already waited page stable in grab_cache_page_write_begin,
so we remove this unnecessary wait.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/data.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 8c61fa7..1201949 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1783,8 +1783,6 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
 		}
 	}
 
-	f2fs_wait_on_page_writeback(page, DATA, false);
-
 	/* wait for GCed encrypted page writeback */
 	if (f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode))
 		f2fs_wait_on_encrypted_page_writeback(sbi, blkaddr);
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
