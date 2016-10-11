From: Chao Yu <chao@kernel.org>
Subject: [PATCH 4/8] f2fs: add missing f2fs_balance_fs in
	f2fs_zero_range
Date: Tue, 11 Oct 2016 22:57:02 +0800
Message-ID: <20161011145706.5028-4-chao@kernel.org>
References: <20161011145706.5028-1-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1btyWd-00038N-Hs
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 11 Oct 2016 14:59:27 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1btyWc-0005wZ-Si
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 11 Oct 2016 14:59:27 +0000
In-Reply-To: <20161011145706.5028-1-chao@kernel.org>
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

f2fs_balance_fs should be called in between node page updating, otherwise
node page count will exceeded far beyond watermark of triggering
foreground garbage collection, result in facing high risk of hitting LFS
allocation failure.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 8f48fdd..0081c79 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1260,6 +1260,9 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
 			ret = f2fs_do_zero_range(&dn, index, end);
 			f2fs_put_dnode(&dn);
 			f2fs_unlock_op(sbi);
+
+			f2fs_balance_fs(sbi, dn.node_changed);
+
 			if (ret)
 				goto out;
 
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
