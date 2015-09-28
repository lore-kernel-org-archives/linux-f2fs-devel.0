From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] f2fs: fix to update {m,
	c}time correctly when truncating larger
Date: Mon, 28 Sep 2015 17:46:01 +0800
Message-ID: <006f01d0f9d2$94c9dcd0$be5d9670$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1ZgV1H-0004wQ-Vt
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 28 Sep 2015 09:46:51 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZgV1G-0000Nk-Ia
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 28 Sep 2015 09:46:51 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NVD02VFESHM0Y90@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 28 Sep 2015 18:46:43 +0900 (KST)
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch fixes to update ctime and atime correctly when truncating
larger in ->setattr.

The bug is reported by xfstest generic/313 as below:

generic/313 2s ... - output mismatch (see ./results/generic/313.out.bad)
    --- tests/generic/313.out   2015-08-04 15:28:53.430798882 +0800
    +++ results/generic/313.out.bad   2015-09-28 17:04:27.294278016 +0800
    @@ -1,2 +1,4 @@
     QA output created by 313
     Silence is golden
    +ctime not updated after truncate up
    +mtime not updated after truncate up
    ...
    (Run 'diff -u tests/generic/313.out tests/generic/313.out.bad'  to see the entire diff)
Ran: generic/313
Failures: generic/313
Failed 1 of 1 tests

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index c365f66..06898f1 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -681,6 +681,7 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 			 * larger than i_size.
 			 */
 			truncate_setsize(inode, attr->ia_size);
+			inode->i_mtime = inode->i_ctime = CURRENT_TIME;
 		}
 	}
 
-- 
2.5.2



------------------------------------------------------------------------------
