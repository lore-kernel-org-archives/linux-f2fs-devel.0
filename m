From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] f2fs: shrink size of struct discard_cmd
Date: Wed, 26 Apr 2017 17:39:55 +0800
Message-ID: <20170426093955.48144-2-yuchao0@huawei.com>
References: <20170426093955.48144-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1d3JR5-0007ll-G4
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 26 Apr 2017 09:40:35 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188]
	helo=dggrg02-dlp.huawei.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1d3JR1-0001hC-3m
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 26 Apr 2017 09:40:35 +0000
In-Reply-To: <20170426093955.48144-1-yuchao0@huawei.com>
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
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

In order to shrink size of struct discard_cmd, change variable type of
@state in struct discard_cmd from int to unsigned char.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e0c8e0074224..914b5c64cfae 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -220,7 +220,7 @@ struct discard_cmd {
 	struct completion wait;		/* compleation */
 	struct block_device *bdev;	/* bdev */
 	unsigned short ref;		/* reference count */
-	int state;			/* state */
+	unsigned char state;		/* state */
 	int error;			/* bio error */
 };
 
-- 
2.12.2.510.ge1104a5ee539


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
