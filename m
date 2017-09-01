From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fs: don't need to update inode checksum
 for recovery
Date: Fri,  1 Sep 2017 10:25:10 -0700
Message-ID: <20170901172511.7045-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <jaegeuk@kernel.org>) id 1dnph4-0004hb-V9
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 01 Sep 2017 17:25:22 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1dnph2-0005zY-PY
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 01 Sep 2017 17:25:22 +0000
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

This patch fixes "f2fs: support inode checksum".
The recovered inode page will be rewritten with valid checksum.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/node.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 2654c9166fba..388a00262a5f 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2287,8 +2287,6 @@ int recover_inode_page(struct f2fs_sb_info *sbi, struct page *page)
 			F2FS_FITS_IN_INODE(src, le16_to_cpu(src->i_extra_isize),
 								i_projid))
 			dst->i_projid = src->i_projid;
-
-		f2fs_inode_chksum_set(sbi, ipage);
 	}
 
 	new_ni = old_ni;
-- 
2.14.0.rc1.383.gd1ce394fe2-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
