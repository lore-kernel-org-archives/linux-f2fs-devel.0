From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] f2fs: don't track volatile file in dirty
	inode list
Date: Wed, 22 Mar 2017 17:23:46 +0800
Message-ID: <20170322092346.115258-2-yuchao0@huawei.com>
References: <20170322092346.115258-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1cqcV6-0001L5-31
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 22 Mar 2017 09:24:16 +0000
Received: from [45.249.212.188] (helo=dggrg02-dlp.huawei.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cqcV4-0001Df-Gs
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 22 Mar 2017 09:24:16 +0000
In-Reply-To: <20170322092346.115258-1-yuchao0@huawei.com>
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

Don't track volatile file in dirty inode list, otherwise with data_flush
option, background thread will entry into endless loop for flushing
journal file's pages.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/checkpoint.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 85831a0af463..9aba0bb340a0 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -817,7 +817,9 @@ static void __add_dirty_inode(struct inode *inode, enum inode_type type)
 		return;
 
 	set_inode_flag(inode, flag);
-	list_add_tail(&F2FS_I(inode)->dirty_list, &sbi->inode_list[type]);
+	if (!f2fs_is_volatile_file(inode))
+		list_add_tail(&F2FS_I(inode)->dirty_list,
+						&sbi->inode_list[type]);
 	stat_inc_dirty_inode(sbi, type);
 }
 
-- 
2.8.2.295.g3f1c1d0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
