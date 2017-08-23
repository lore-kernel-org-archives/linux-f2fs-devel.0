From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] f2fs: trigger fdatasync for non-atomic_write
 file
Date: Wed, 23 Aug 2017 18:23:25 +0800
Message-ID: <20170823102325.26219-2-yuchao0@huawei.com>
References: <20170823102325.26219-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yuchao0@huawei.com>) id 1dkSpS-0002Na-AJ
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 23 Aug 2017 10:24:06 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1dkSpR-00009x-Dr
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 23 Aug 2017 10:24:06 +0000
In-Reply-To: <20170823102325.26219-1-yuchao0@huawei.com>
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

Sqlite only cares about synchronization of file data instead of other data
unrelated attribute of inode, so in commit flow, call fdatasync is enough.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 5b180177570c..b9c4930fc74b 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1700,7 +1700,7 @@ static int f2fs_ioc_commit_atomic_write(struct file *filp)
 			stat_dec_atomic_write(inode);
 		}
 	} else {
-		ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 0, false);
+		ret = f2fs_do_sync_file(filp, 0, LLONG_MAX, 1, false);
 	}
 err_out:
 	inode_unlock(inode);
-- 
2.13.1.388.g69e6b9b4f4a9


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
