From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: add fi->commit_lock to protect commit
 GCed pages
Date: Wed, 7 Feb 2018 20:16:09 +0800
Message-ID: <4493cbf2-6f37-6c04-a012-4b2516b3b4e7@kernel.org>
References: <1517626068-49739-1-git-send-email-yunlong.song@huawei.com>
 <1517888990-96478-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.192]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <chao@kernel.org>) id 1ejOeN-0001X9-Hx
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 07 Feb 2018 12:16:31 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1ejOeM-0007j6-OD
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 07 Feb 2018 12:16:31 +0000
In-Reply-To: <1517888990-96478-1-git-send-email-yunlong.song@huawei.com>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Yunlong Song <yunlong.song@huawei.com>, jaegeuk@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, heyunlei@huawei.com, miaoxie@huawei.com

On 2018/2/6 11:49, Yunlong Song wrote:
> This patch adds fi->commit_lock to avoid the case that GCed node pages
> are committed but GCed data pages are not committed. This can avoid the
> db file run into inconsistent state when sudden-power-off happens if
> data pages of atomic file is allowed to be GCed before.

do_fsync:				GC:
- mutex_lock(&fi->commit_lock);
					- lock_page()
					 - mutex_lock(&fi->commit_lock);
 - lock_page()


Well, please consider lock dependency & code complexity, IMO, reuse
fi->dio_rwsem[WRITE] will be enough as below:

---
 fs/f2fs/file.c | 3 +++
 fs/f2fs/gc.c   | 5 -----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 672a542e5464..1bdc11feb8d0 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1711,6 +1711,8 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)

 	inode_lock(inode);

+	down_write(&F2FS_I(inode)->dio_rwsem[WRITE]);
+
 	if (f2fs_is_volatile_file(inode))
 		goto err_out;

@@ -1729,6 +1731,7 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
 		ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 1, false);
 	}
 err_out:
+	up_write(&F2FS_I(inode)->dio_rwsem[WRITE]);
 	inode_unlock(inode);
 	mnt_drop_write_file(filp);
 	return ret;
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index b9d93fd532a9..e49416283563 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -622,9 +622,6 @@ static void move_data_block(struct inode *inode, block_t bidx,
 	if (!check_valid_map(F2FS_I_SB(inode), segno, off))
 		goto out;

-	if (f2fs_is_atomic_file(inode))
-		goto out;
-
 	if (f2fs_is_pinned_file(inode)) {
 		f2fs_pin_file_control(inode, true);
 		goto out;
@@ -729,8 +726,6 @@ static void move_data_page(struct inode *inode, block_t bidx, int gc_type,
 	if (!check_valid_map(F2FS_I_SB(inode), segno, off))
 		goto out;

-	if (f2fs_is_atomic_file(inode))
-		goto out;
 	if (f2fs_is_pinned_file(inode)) {
 		if (gc_type == FG_GC)
 			f2fs_pin_file_control(inode, true);
-- 
2.14.1.145.gb3622a4ee

Thanks,

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
