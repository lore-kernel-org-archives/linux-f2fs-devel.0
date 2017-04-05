From: kusumi.tomohiro@gmail.com
Subject: [PATCH] f2fs: fix comment on f2fs_flush_merged_bios()
	after 86531d6b
Date: Wed,  5 Apr 2017 22:49:44 +0300
Message-ID: <20170405194944.1858-1-tkusumi@tuxera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <kusumi.tomohiro@gmail.com>) id 1cvqwR-0008ML-14
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 05 Apr 2017 19:50:07 +0000
Received: from mail-lf0-f66.google.com ([209.85.215.66])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1cvqwP-0005Hn-Kx
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 05 Apr 2017 19:50:07 +0000
Received: by mail-lf0-f66.google.com with SMTP id r36so2020152lfi.0
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Wed, 05 Apr 2017 12:50:05 -0700 (PDT)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, yuchao0@huawei.com
Cc: Tomohiro Kusumi <tkusumi@tuxera.com>

From: Tomohiro Kusumi <tkusumi@tuxera.com>

Callers are to unlock the page on failure after 86531d6b.

Signed-off-by: Tomohiro Kusumi <tkusumi@tuxera.com>
---
 fs/f2fs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 1602b4b..bfd0b02 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -341,7 +341,7 @@ void f2fs_flush_merged_bios(struct f2fs_sb_info *sbi)
 
 /*
  * Fill the locked page with data located in the block address.
- * Return unlocked page.
+ * A caller needs to unlock the page on failure.
  */
 int f2fs_submit_page_bio(struct f2fs_io_info *fio)
 {
-- 
2.9.3


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
