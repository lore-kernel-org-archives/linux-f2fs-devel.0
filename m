From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 045/170] f2fs: move dir data flush
 to write checkpoint process
Date: Mon, 28 Jan 2019 11:09:55 -0500
Message-ID: <20190128161200.55107-45-sashal@kernel.org>
References: <20190128161200.55107-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <sashal@kernel.org>) id 1go9Xs-0001oM-Ci
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 28 Jan 2019 16:14:00 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1go9Xq-008jhE-Pa
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 28 Jan 2019 16:14:00 +0000
In-Reply-To: <20190128161200.55107-1-sashal@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

From: Yunlei He <heyunlei@huawei.com>

[ Upstream commit b61ac5b720146c619c7cdf17eff2551b934399e5 ]

This patch move dir data flush to write checkpoint process, by
doing this, it may reduce some time for dir fsync.

pre:
	-f2fs_do_sync_file enter
		-file_write_and_wait_range  <- flush & wait
		-write_checkpoint
			-do_checkpoint	    <- wait all
	-f2fs_do_sync_file exit

now:
	-f2fs_do_sync_file enter
		-write_checkpoint
			-block_operations   <- flush dir & no wait
			-do_checkpoint	    <- wait all
	-f2fs_do_sync_file exit

Signed-off-by: Yunlei He <heyunlei@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 7d3189f1941c..5f549bc4e097 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -205,6 +205,9 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 
 	trace_f2fs_sync_file_enter(inode);
 
+	if (S_ISDIR(inode->i_mode))
+		goto go_write;
+
 	/* if fdatasync is triggered, let's do in-place-update */
 	if (datasync || get_dirty_pages(inode) <= SM_I(sbi)->min_fsync_blocks)
 		set_inode_flag(inode, FI_NEED_IPU);
-- 
2.19.1
