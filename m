From: Fan Li <fanofcode.li@samsung.com>
Subject: [PATCH] f2fs: exclude special cases for
	f2fs_move_file_range
Date: Tue, 13 Sep 2016 11:35:42 +0800
Message-ID: <001601d20d70$070015b0$15004110$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <fanofcode.li@samsung.com>) id 1bjeV6-00053r-J3
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 13 Sep 2016 03:35:12 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1bjeV4-0000FS-CQ
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 13 Sep 2016 03:35:12 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0ODF01R4EBACYU30@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 13 Sep 2016 12:35:02 +0900 (KST)
Content-language: en-us
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

When src and dst is the same file, and the latter part of source region
overlaps with the former part of destination region, current implement
will overwrite data which hasn't been moved yet and truncate data in
overlapped region.
This patch return -EINVAL when such cases occur and return 0 when
source region and destination region is actually the same part of
the same file.

Signed-off-by: Fan li <fanofcode.li@samsung.com>
---
 fs/f2fs/file.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index d5f60ad..116946b 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2168,6 +2168,13 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
 	if (f2fs_encrypted_inode(src) || f2fs_encrypted_inode(dst))
 		return -EOPNOTSUPP;
 
+	if (src == dst) {
+		if (pos_in == pos_out)
+			return 0;
+		if (pos_out > pos_in && pos_out < pos_in + len)
+			return -EINVAL;
+	}
+
 	inode_lock(src);
 	if (src != dst) {
 		if (!inode_trylock(dst)) {
-- 
1.7.9.5


------------------------------------------------------------------------------
