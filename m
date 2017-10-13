From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 5/5] f2fs: update ctx->pos correctly when hitting
 hole in directory
Date: Fri, 13 Oct 2017 18:01:36 +0800
Message-ID: <20171013100136.35212-5-yuchao0@huawei.com>
References: <20171013100136.35212-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yuchao0@huawei.com>) id 1e2wnF-00029f-VN
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 13 Oct 2017 10:02:13 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1e2wnA-0007tp-2x
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 13 Oct 2017 10:02:13 +0000
In-Reply-To: <20171013100136.35212-1-yuchao0@huawei.com>
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

This patch fixes to update ctx->pos correctly when hitting hole in
directory.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/dir.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 14646440b662..2d98d877c09d 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -870,7 +870,7 @@ static int f2fs_readdir(struct file *file, struct dir_context *ctx)
 		goto out_free;
 	}
 
-	for (; n < npages; n++) {
+	for (; n < npages; n++, ctx->pos = n * NR_DENTRY_IN_BLOCK) {
 
 		/* allow readdir() to be interrupted */
 		if (fatal_signal_pending(current)) {
@@ -907,7 +907,6 @@ static int f2fs_readdir(struct file *file, struct dir_context *ctx)
 			break;
 		}
 
-		ctx->pos = (n + 1) * NR_DENTRY_IN_BLOCK;
 		kunmap(dentry_page);
 		f2fs_put_page(dentry_page, 1);
 	}
-- 
2.13.1.388.g69e6b9b4f4a9


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
