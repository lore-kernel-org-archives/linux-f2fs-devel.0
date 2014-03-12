From: Chao Yu <chao2.yu@samsung.com>
Subject: [f2fs-dev] [PATCH] f2fs: check upper bound of ino value in
 f2fs_nfs_get_inode
Date: Wed, 12 Mar 2014 17:08:36 +0800
Message-ID: <001601cf3dd2$c17795a0$4466c0e0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: ??? <jaegeuk.kim@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Upper bound checking of ino should be added to f2fs_nfs_get_inode, so unneeded
process before do_read_inode in f2fs_iget could be avoided when ino is invalid.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/super.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 6e4851c..3a51d7a 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -644,6 +644,8 @@ static struct inode *f2fs_nfs_get_inode(struct super_block *sb,
 
 	if (unlikely(ino < F2FS_ROOT_INO(sbi)))
 		return ERR_PTR(-ESTALE);
+	if (unlikely(ino >= NM_I(sbi)->max_nid))
+		return ERR_PTR(-ESTALE);
 
 	/*
 	 * f2fs_iget isn't quite right if the inode is currently unallocated!
-- 
1.7.9.5
