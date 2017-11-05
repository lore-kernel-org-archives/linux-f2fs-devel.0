From: Chao Yu <chao@kernel.org>
Subject: [PATCH 3/3] f2fs: keep isize once block is reserved
 cross EOF
Date: Sun,  5 Nov 2017 21:53:30 +0800
Message-ID: <20171105135330.15070-3-chao@kernel.org>
References: <20171105135330.15070-1-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <chao@kernel.org>) id 1eBM5U-0000bt-0O
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 05 Nov 2017 14:39:48 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1eBM5T-0002dV-6D
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 05 Nov 2017 14:39:47 +0000
In-Reply-To: <20171105135330.15070-1-chao@kernel.org>
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

From: Chao Yu <yuchao0@huawei.com>

Without FADVISE_KEEP_SIZE_BIT, we will try to recover file size
according to last non-hole block, so in fallocate(), we must set
FADVISE_KEEP_SIZE_BIT flag once we have preallocated block cross
EOF, instead of when all preallocation is success. Otherwise, file
size will be incorrect due to lack of this flag.

Simple testcase to reproduce this:

1. echo 2 > /sys/fs/f2fs/<device>/inject_type
2. echo 10 > /sys/fs/f2fs/<device>/inject_rate
3. run tests/generic/392
4. disable fault injection
5. do remount

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index d9d8b1c372f8..e67f03546391 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1472,8 +1472,12 @@ static int expand_inode_data(struct inode *inode, loff_t offset,
 		new_size = ((loff_t)pg_end << PAGE_SHIFT) + off_end;
 	}
 
-	if (!(mode & FALLOC_FL_KEEP_SIZE) && i_size_read(inode) < new_size)
-		f2fs_i_size_write(inode, new_size);
+	if (new_size > i_size_read(inode)) {
+		if (mode & FALLOC_FL_KEEP_SIZE)
+			file_set_keep_isize(inode);
+		else
+			f2fs_i_size_write(inode, new_size);
+	}
 
 	return err;
 }
@@ -1520,8 +1524,6 @@ static long f2fs_fallocate(struct file *file, int mode,
 	if (!ret) {
 		inode->i_mtime = inode->i_ctime = current_time(inode);
 		f2fs_mark_inode_dirty_sync(inode, false);
-		if (mode & FALLOC_FL_KEEP_SIZE)
-			file_set_keep_isize(inode);
 		f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
 	}
 
-- 
2.14.1.145.gb3622a4ee


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
