From: Namjae Jeon <linkinjeon@gmail.com>
Subject: [f2fs-dev] [PATCH 2/4] f2fs: remove unneeded initializations in
	f2fs_parent_dir
Date: Thu, 23 May 2013 22:58:07 +0900
Message-ID: <1369317488-14346-1-git-send-email-linkinjeon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <linkinjeon@gmail.com>) id 1UfW2A-0004LN-Cq
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 23 May 2013 13:58:22 +0000
Received: from mail-pb0-f52.google.com ([209.85.160.52])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UfW29-00073r-K1
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 23 May 2013 13:58:22 +0000
Received: by mail-pb0-f52.google.com with SMTP id um15so2933269pbc.11
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Thu, 23 May 2013 06:58:15 -0700 (PDT)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk.kim@samsung.com
Cc: Namjae Jeon <linkinjeon@gmail.com>, Amit Sahrawat <a.sahrawat@samsung.com>, Namjae Jeon <namjae.jeon@samsung.com>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org

From: Namjae Jeon <namjae.jeon@samsung.com>

There is no need to initialize few pointers in f2fs_parent_dir
as the values are not checked and instead directly initialized
values are used.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Amit Sahrawat <a.sahrawat@samsung.com>
---
 fs/f2fs/dir.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index fc1dacf..b278bfb 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -215,9 +215,9 @@ struct f2fs_dir_entry *f2fs_find_entry(struct inode *dir,
 
 struct f2fs_dir_entry *f2fs_parent_dir(struct inode *dir, struct page **p)
 {
-	struct page *page = NULL;
-	struct f2fs_dir_entry *de = NULL;
-	struct f2fs_dentry_block *dentry_blk = NULL;
+	struct page *page;
+	struct f2fs_dir_entry *de;
+	struct f2fs_dentry_block *dentry_blk;
 
 	page = get_lock_data_page(dir, 0);
 	if (IS_ERR(page))
-- 
1.7.9.5


------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_may
