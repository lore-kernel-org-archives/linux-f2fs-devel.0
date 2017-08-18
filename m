From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: trigger normal fsync for non-atomic_write
 file
Date: Fri, 18 Aug 2017 16:20:33 +0800
Message-ID: <20170818082033.96162-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yuchao0@huawei.com>) id 1dicWd-0002Dp-0P
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 18 Aug 2017 08:21:03 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1dicWa-0006yI-UH
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 18 Aug 2017 08:21:02 +0000
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
Cc: Chao Yu <yuchao0@huawei.com>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

If file was not opened with atomic write mode, but user uses atomic write
ioctl to fsync datas, in the flow, we should not fsync that file with
atomic write mode.

Fixes: 608514deba38 ("f2fs: set fsync mark only for the last dnode")
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 3fe8f2ab0222..c93cf2a00395 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1698,7 +1698,7 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
 			stat_dec_atomic_write(inode);
 		}
 	} else {
-		ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 0, true);
+		ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 0, false);
 	}
 err_out:
 	inode_unlock(inode);
-- 
2.13.1.388.g69e6b9b4f4a9


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
