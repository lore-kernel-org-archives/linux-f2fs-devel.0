From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: record quota during dot{,dot} recovery
Date: Mon, 24 Jul 2017 17:12:06 +0800
Message-ID: <20170724091206.3197-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yuchao0@huawei.com>) id 1dZZPr-0001k0-CK
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 24 Jul 2017 09:12:39 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189])
 by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1dZZPn-00019X-Ow
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 24 Jul 2017 09:12:39 +0000
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
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

In ->lookup(), we will have a try to recover dot or dotdot for
corrupted directory, once disk quota is on, if it allocates new
block during dotdot recovery, we need to record disk quota info
for the allocation, so this patch fixes this issue by adding
missing dquot_initialize() in __recover_dot_dentries.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/namei.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index 2e3552d9d6ee..08c1d3767f22 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -289,6 +289,10 @@ static int __recover_dot_dentries(struct inode *dir, nid_t pino)
 		return 0;
 	}
 
+	err = dquot_initialize(dir);
+	if (err)
+		return err;
+
 	f2fs_balance_fs(sbi, true);
 
 	f2fs_lock_op(sbi);
-- 
2.13.1.388.g69e6b9b4f4a9


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
