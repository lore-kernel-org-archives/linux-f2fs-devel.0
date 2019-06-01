From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 051/173] f2fs: fix to retrieve inline
 xattr space
Date: Sat,  1 Jun 2019 09:17:23 -0400
Message-ID: <20190601131934.25053-51-sashal@kernel.org>
References: <20190601131934.25053-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <sashal@kernel.org>) id 1hX3x3-0003c5-Q6
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 01 Jun 2019 13:21:37 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hX3wz-0058JH-OU
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 01 Jun 2019 13:21:34 +0000
In-Reply-To: <20190601131934.25053-1-sashal@kernel.org>
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

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit 45a746881576977f85504c21a75547f10c5c0a8e ]

With below mkfs and mount option, generic/339 of fstest will report that
scratch image becomes corrupted.

MKFS_OPTIONS  -- -O extra_attr -O project_quota -O inode_checksum -O flexible_inline_xattr -O inode_crtime -f /dev/zram1
MOUNT_OPTIONS -- -o acl,user_xattr -o discard,noinline_xattr /dev/zram1 /mnt/scratch_f2fs

[ASSERT] (f2fs_check_dirent_position:1315)  --> Wrong position of dirent pino:1970, name: (...)
level:8, dir_level:0, pgofs:951, correct range:[900, 901]

In old kernel, inline data and directory always reserved 200 bytes in
inode layout, even if inline_xattr is disabled, then new kernel tries
to retrieve that space for non-inline xattr inode, but for inline dentry,
its layout size should be fixed, so we just keep that reserved space.

But the problem here is that, after inline dentry conversion, inline
dentry layout no longer exists, if we still reserve inline xattr space,
after dents updates, there will be a hole in inline xattr space, which
can break hierarchy hash directory structure.

This patch fixes this issue by retrieving inline xattr space after
inline dentry conversion.

Fixes: 6afc662e68b5 ("f2fs: support flexible inline xattr size")
Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/inline.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index aacbb864ec1ed..0c2251d595ec8 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -420,6 +420,14 @@ static int f2fs_move_inline_dirents(struct inode *dir, struct page *ipage,
 	stat_dec_inline_dir(dir);
 	clear_inode_flag(dir, FI_INLINE_DENTRY);
 
+	/*
+	 * should retrieve reserved space which was used to keep
+	 * inline_dentry's structure for backward compatibility.
+	 */
+	if (!f2fs_sb_has_flexible_inline_xattr(F2FS_I_SB(dir)) &&
+			!f2fs_has_inline_xattr(dir))
+		F2FS_I(dir)->i_inline_xattr_size = 0;
+
 	f2fs_i_depth_write(dir, 1);
 	if (i_size_read(dir) < PAGE_SIZE)
 		f2fs_i_size_write(dir, PAGE_SIZE);
@@ -501,6 +509,15 @@ static int f2fs_move_rehashed_dirents(struct inode *dir, struct page *ipage,
 
 	stat_dec_inline_dir(dir);
 	clear_inode_flag(dir, FI_INLINE_DENTRY);
+
+	/*
+	 * should retrieve reserved space which was used to keep
+	 * inline_dentry's structure for backward compatibility.
+	 */
+	if (!f2fs_sb_has_flexible_inline_xattr(F2FS_I_SB(dir)) &&
+			!f2fs_has_inline_xattr(dir))
+		F2FS_I(dir)->i_inline_xattr_size = 0;
+
 	kvfree(backup_dentry);
 	return 0;
 recover:
-- 
2.20.1
