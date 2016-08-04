From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs: allow copying file range only in
	between regular files
Date: Thu, 4 Aug 2016 20:13:02 +0800
Message-ID: <20160804121303.62766-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1bVHX8-0003cz-HX
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 04 Aug 2016 12:13:54 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1bVHX3-0002Yk-Cc
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 04 Aug 2016 12:13:54 +0000
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

Only if two input files are regular files, we allow copying data in
range of them, otherwise, deny it.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index be81722..409f0ec 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2162,8 +2162,8 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
 	if (unlikely(f2fs_readonly(src->i_sb)))
 		return -EROFS;
 
-	if (S_ISDIR(src->i_mode) || S_ISDIR(dst->i_mode))
-		return -EISDIR;
+	if (!S_ISREG(src->i_mode) || !S_ISREG(dst->i_mode))
+		return -EINVAL;
 
 	if (f2fs_encrypted_inode(src) || f2fs_encrypted_inode(dst))
 		return -EOPNOTSUPP;
-- 
2.8.2.311.gee88674


------------------------------------------------------------------------------
