From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 4/6] f2fs: fix to recover inode's crtime during POR
Date: Tue, 25 Sep 2018 15:36:01 +0800
Message-ID: <20180925073603.102125-4-yuchao0@huawei.com>
References: <20180925073603.102125-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180925073603.102125-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Testcase to reproduce this bug:
1. mkfs.f2fs -O extra_attr -O inode_crtime /dev/sdd
2. mount -t f2fs /dev/sdd /mnt/f2fs
3. touch /mnt/f2fs/file
4. xfs_io -f /mnt/f2fs/file -c "fsync"
5. godown /mnt/f2fs
6. umount /mnt/f2fs
7. mount -t f2fs /dev/sdd /mnt/f2fs
8. xfs_io -f /mnt/f2fs/file -c "statx -r"

stat.btime.tv_sec = 0
stat.btime.tv_nsec = 0

This patch fixes to recover inode creation time fields during
mount.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/node.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 5717fb6e7d7d..ea151e07790f 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2565,6 +2565,13 @@ int f2fs_recover_inode_page(struct f2fs_sb_info *sbi, struct page *page)
 			F2FS_FITS_IN_INODE(src, le16_to_cpu(src->i_extra_isize),
 								i_projid))
 			dst->i_projid = src->i_projid;
+
+		if (f2fs_sb_has_inode_crtime(sbi->sb) &&
+			F2FS_FITS_IN_INODE(src, le16_to_cpu(src->i_extra_isize),
+							i_crtime_nsec)) {
+			dst->i_crtime = src->i_crtime;
+			dst->i_crtime_nsec = src->i_crtime_nsec;
+		}
 	}
 
 	new_ni = old_ni;
-- 
2.18.0.rc1
