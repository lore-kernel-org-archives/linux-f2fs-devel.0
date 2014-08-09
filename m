From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 5/5] f2fs: update f2fs documentation for inline
 dir support
Date: Sat, 09 Aug 2014 10:51:55 +0800
Message-ID: <00c301cfb37c$fc1efe80$f45cfb80$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1XFwm1-0000BP-Gd
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 09 Aug 2014 02:52:49 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1XFwm0-0007iq-0c
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 09 Aug 2014 02:52:49 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0NA000ABXQNSOG40@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Sat, 09 Aug 2014 11:52:40 +0900 (KST)
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
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch adds descriptions for the inline dir support in f2fs document.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 Documentation/filesystems/f2fs.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
index a2046a7..08c9493 100644
--- a/Documentation/filesystems/f2fs.txt
+++ b/Documentation/filesystems/f2fs.txt
@@ -120,8 +120,9 @@ active_logs=%u         Support configuring the number of active logs. In the
 disable_ext_identify   Disable the extension list configured by mkfs, so f2fs
                        does not aware of cold files such as media files.
 inline_xattr           Enable the inline xattrs feature.
-inline_data            Enable the inline data feature: New created small(<~3.4k)
-                       files can be written into inode block.
+inline_data            Enable the inline data feature: data(<~3.4k) in new
+                       created small file and limited directory entries can be
+                       written into to inode block.
 flush_merge	       Merge concurrent cache_flush commands as much as possible
                        to eliminate redundant command issues. If the underlying
 		       device handles the cache_flush command relatively slowly,
-- 
2.0.1.474.g72c7794



------------------------------------------------------------------------------
