From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: don't need to submit bio on error case
Date: Wed, 21 Oct 2015 20:03:44 -0700
Message-ID: <1445483024-49724-2-git-send-email-jaegeuk@kernel.org>
References: <1445483024-49724-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Zp6Bc-0005cU-6Y
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 22 Oct 2015 03:05:04 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Zp6BR-00065P-8F for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 22 Oct 2015 03:05:04 +0000
In-Reply-To: <1445483024-49724-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

If commit_atomic_write is failed, we don't need to submit any bio.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 7835e41..7efd96ad 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -249,11 +249,11 @@ int commit_inmem_pages(struct inode *inode, bool abort)
 				trace_f2fs_commit_inmem_page(cur->page, INMEM);
 				fio.page = cur->page;
 				err = do_write_data_page(&fio);
-				submit_bio = true;
 				if (err) {
 					unlock_page(cur->page);
 					break;
 				}
+				submit_bio = true;
 			}
 		} else {
 			trace_f2fs_commit_inmem_page(cur->page, INMEM_DROP);
-- 
2.1.1


------------------------------------------------------------------------------
