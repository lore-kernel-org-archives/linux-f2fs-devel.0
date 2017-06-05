From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 4/4] f2fs: use bio_set_op_attrs
Date: Mon, 5 Jun 2017 18:29:09 +0800
Message-ID: <20170605102909.57625-4-yuchao0@huawei.com>
References: <20170605102909.57625-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1dHpGs-0004ma-Iz
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 05 Jun 2017 10:30:02 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1dHpGr-0001uB-FN
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 05 Jun 2017 10:30:02 +0000
In-Reply-To: <20170605102909.57625-1-yuchao0@huawei.com>
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

Init bio->bi_opf with bio_set_op_attrs instead of opened code.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 2ed90f5db832..204150cf6561 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1962,7 +1962,7 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
 			err = PTR_ERR(bio);
 			goto fail;
 		}
-		bio->bi_opf = REQ_OP_READ;
+		bio_set_op_attrs(bio, REQ_OP_READ, 0);
 		if (bio_add_page(bio, page, PAGE_SIZE, 0) < PAGE_SIZE) {
 			bio_put(bio);
 			err = -EFAULT;
-- 
2.13.0.67.g10c78a162fa8


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
