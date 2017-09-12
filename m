From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to show correct discard_granularity in
 sysfs
Date: Tue, 12 Sep 2017 14:25:35 +0800
Message-ID: <20170912062535.3858-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yuchao0@huawei.com>) id 1dree2-0000Iy-HG
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 12 Sep 2017 06:26:02 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1dree0-0006Dm-VQ
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 12 Sep 2017 06:26:02 +0000
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

Fix below incorrect display when reading discard_granularity sysfs node.

$ cat /sys/fs/f2fs/<device>/discard_granularity
$ 16
$ echo 32 > /sys/fs/f2fs/<device>/discard_granularity
$ cat /sys/fs/f2fs/<device>/discard_granularity
$ 16

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/sysfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 962735dc9c63..e2c258f717cd 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -170,6 +170,8 @@ static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
 				dcc->pend_list_tag[i] &= (~P_ACTIVE);
 		}
 		mutex_unlock(&dcc->cmd_lock);
+
+		*ui = t;
 		return count;
 	}
 
-- 
2.13.1.388.g69e6b9b4f4a9


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
