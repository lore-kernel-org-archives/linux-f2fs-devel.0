From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs: avoid deadlock caused by lock order of
 page and lock_op
Date: Sat, 24 Jun 2017 09:25:21 -0700
Message-ID: <20170624162522.48931-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1dOnsO-0001Ys-6W
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 24 Jun 2017 16:25:36 +0000
Received: from mail.kernel.org ([198.145.29.99])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1dOnsM-0000ay-3d
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 24 Jun 2017 16:25:36 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

- punch_hole
 - fill_zero
  - f2fs_lock_op
  - get_new_data_page
   - lock_page

- f2fs_write_data_pages
 - lock_page
 - do_write_data_page
  - f2fs_lock_op

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 7d3af48d34a9..9141bd19a902 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1404,8 +1404,9 @@ int do_write_data_page(struct f2fs_io_info *fio)
 		}
 	}
 
-	if (fio->need_lock == LOCK_REQ)
-		f2fs_lock_op(fio->sbi);
+	/* Deadlock due to between page->lock and f2fs_lock_op */
+	if (fio->need_lock == LOCK_REQ && !f2fs_trylock_op(fio->sbi))
+		return -EAGAIN;
 
 	err = get_dnode_of_data(&dn, page->index, LOOKUP_NODE);
 	if (err)
-- 
2.13.0.rc1.294.g07d810a77f-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
