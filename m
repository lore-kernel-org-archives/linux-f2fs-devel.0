From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH] f2fs: return -EIO when node id is not matched
Date: Tue, 01 Apr 2014 18:53:28 +0900
Message-ID: <1396346008-12753-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1WUvPs-0000Rl-JX
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 01 Apr 2014 09:55:36 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1WUvPq-0008CF-Ms
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 01 Apr 2014 09:55:36 +0000
Received: from epcpsbgr4.samsung.com
	(u144.gpu120.samsung.co.kr [203.254.230.144])
	by mailout3.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0N3C009IYJKATS60@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 01 Apr 2014 18:55:22 +0900 (KST)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

During the cleaing of node segments, F2FS can get errored node blocks due to
data race between node page lock and its valid bitmap operations.
In that case, it needs to return an error to skip such the obsolete block copy.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/node.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index eced8d7..065cd99 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -958,7 +958,7 @@ repeat:
 		goto got_it;
 
 	lock_page(page);
-	if (unlikely(!PageUptodate(page))) {
+	if (unlikely(!PageUptodate(page) || nid != nid_of_node(page))) {
 		f2fs_put_page(page, 1);
 		return ERR_PTR(-EIO);
 	}
@@ -967,7 +967,6 @@ repeat:
 		goto repeat;
 	}
 got_it:
-	f2fs_bug_on(nid != nid_of_node(page));
 	mark_page_accessed(page);
 	return page;
 }
-- 
1.8.4.474.g128a96c


------------------------------------------------------------------------------
