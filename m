From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/6] f2fs: fix to recover inode's project id
 during POR
Date: Tue, 25 Sep 2018 15:35:58 +0800
Message-ID: <20180925073603.102125-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1g4htQ-0001q8-17
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 25 Sep 2018 07:36:24 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1g4htO-00AMrG-0a
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 25 Sep 2018 07:36:23 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Testcase to reproduce this bug:
1. mkfs.f2fs -O extra_attr -O project_quota /dev/sdd
2. mount -t f2fs /dev/sdd /mnt/f2fs
3. touch /mnt/f2fs/file
4. sync
5. chattr -p 1 /mnt/f2fs/file
6. xfs_io -f /mnt/f2fs/file -c "fsync"
7. godown /mnt/f2fs
8. umount /mnt/f2fs
9. mount -t f2fs /dev/sdd /mnt/f2fs
10. lsattr -p /mnt/f2fs/file

    0 -----------------N- /mnt/f2fs/file

But actually, we expect the correct result is:

    1 -----------------N- /mnt/f2fs/file

The reason is we didn't recover inode.i_projid field during mount,
fix it.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/recovery.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 70f05650191e..c7e292f21b64 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -244,6 +244,19 @@ static int recover_inode(struct inode *inode, struct page *page)
 
 	i_uid_write(inode, le32_to_cpu(raw->i_uid));
 	i_gid_write(inode, le32_to_cpu(raw->i_gid));
+
+	if (raw->i_inline & F2FS_EXTRA_ATTR) {
+		if (f2fs_sb_has_project_quota(F2FS_I_SB(inode)->sb) &&
+			F2FS_FITS_IN_INODE(raw, le16_to_cpu(raw->i_extra_isize),
+								i_projid)) {
+			projid_t i_projid;
+
+			i_projid = (projid_t)le32_to_cpu(raw->i_projid);
+			F2FS_I(inode)->i_projid =
+				make_kprojid(&init_user_ns, i_projid);
+		}
+	}
+
 	f2fs_i_size_write(inode, le64_to_cpu(raw->i_size));
 	inode->i_atime.tv_sec = le64_to_cpu(raw->i_atime);
 	inode->i_ctime.tv_sec = le64_to_cpu(raw->i_ctime);
-- 
2.18.0.rc1
