From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs: fix i_current_depth during inline
	dentry conversion
Date: Sat, 14 May 2016 19:03:52 +0800
Message-ID: <20160514110353.31981-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1b1XN6-0006BD-OY
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 14 May 2016 11:04:36 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1b1XN0-0001HK-7j
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 14 May 2016 11:04:36 +0000
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

With below steps, we will see that dentry page becoming unaccessable later.
This is because we forget updating i_current_depth in inode during inline
dentry conversion, after that, once we failed at somewhere, it will leave
i_current_depth as 0 in non-inline directory. Then, during ->lookup, the
current_depth value makes all dentry pages in first level invisible. Fix
it.

1) mount f2fs with inline_dentry option
2) mkdir dir
3) touch 180 files named [0-179] in dir
4) touch 180 in dir (fail after inline dir conversion)
5) ll dir

ls: cannot access /mnt/f2fs/dir/0: No such file or directory
ls: cannot access /mnt/f2fs/dir/1: No such file or directory
ls: cannot access /mnt/f2fs/dir/2: No such file or directory
ls: cannot access /mnt/f2fs/dir/3: No such file or directory
ls: cannot access /mnt/f2fs/dir/4: No such file or directory

drwxr-xr-x 2 root root 4096  may 13 21:47 ./
drwxr-xr-x 3 root root 4096  may 13 21:46 ../
-????????? ? ?    ?       ?             ? 0
-????????? ? ?    ?       ?             ? 1
-????????? ? ?    ?       ?             ? 10
-????????? ? ?    ?       ?             ? 100
-????????? ? ?    ?       ?             ? 101
-????????? ? ?    ?       ?             ? 102

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/inline.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 8a51955..60ba7ac 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -400,6 +400,7 @@ static int f2fs_move_inline_dirents(struct inode *dir, struct page *ipage,
 	stat_dec_inline_dir(dir);
 	clear_inode_flag(F2FS_I(dir), FI_INLINE_DENTRY);
 
+	F2FS_I(dir)->i_current_depth = 1;
 	if (i_size_read(dir) < PAGE_SIZE) {
 		i_size_write(dir, PAGE_SIZE);
 		set_inode_flag(F2FS_I(dir), FI_UPDATE_DIR);
-- 
2.8.2.311.gee88674


------------------------------------------------------------------------------
Mobile security can be enabling, not merely restricting. Employees who
bring their own devices (BYOD) to work are irked by the imposition of MDM
restrictions. Mobile Device Manager Plus allows you to control only the
apps on BYO-devices by containerizing them, leaving personal data untouched!
https://ad.doubleclick.net/ddm/clk/304595813;131938128;j
