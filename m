From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 072/258] f2fs: move dir data flush to write checkpoint process
Date: Mon, 28 Jan 2019 10:56:18 -0500
Message-ID: <20190128155924.51521-72-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Yunlei He <heyunlei@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>, Sasha Levin <sashal@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

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
index 5474aaa274b9..fd36aa6569dc 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -220,6 +220,9 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
 
 	trace_f2fs_sync_file_enter(inode);
 
+	if (S_ISDIR(inode->i_mode))
+		goto go_write;
+
 	/* if fdatasync is triggered, let's do in-place-update */
 	if (datasync || get_dirty_pages(inode) <= SM_I(sbi)->min_fsync_blocks)
 		set_inode_flag(inode, FI_NEED_IPU);
-- 
2.19.1
