From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 1/2 v2] f2fs: check name_len of dir entry to
 prevent from deadloop
Date: Thu, 10 Jul 2014 12:37:46 +0800
Message-ID: <001d01cf9bf8$df92faa0$9eb8efe0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1X568Z-0004VN-9J
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 10 Jul 2014 04:39:15 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1X568X-00016o-D9
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 10 Jul 2014 04:39:15 +0000
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0N8H00I91BL5CA30@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 10 Jul 2014 13:39:05 +0900 (KST)
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
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

We assume that modification of some special application could result in zeroed
name_len, or it is consciously made by somebody. We will deadloop in
find_in_block when name_len of dir entry is zero.

This patch is added for preventing deadloop in above scenario.

change log from v1:
 o use f2fs_bug_on rather than break out from searching dir entry suggested by
Jaegeuk Kim.

Jaegeuk describe:
"Well, IMO, it would be good to add f2fs_bug_on() here with a specific comment.
In the current phase of f2fs, it is more important to investigate the file
system bugs, rather than workarounds for any corrupted images.
And, definitely it needs to stop the kernel if any corrupted image was mounted,
so that we can figure out where the bugs are occurred."

Suggested-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/dir.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index e84e880..bcf893c 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -121,6 +121,13 @@ static struct f2fs_dir_entry *find_in_block(struct page *dentry_page,
 			*max_slots = max_len;
 			max_len = 0;
 		}
+
+		/*
+		 * For the most part, it should be a bug when name_len is zero.
+		 * We stop here for figuring out where the bugs are occurred.
+		 */
+		f2fs_bug_on(!de->name_len);
+
 		bit_pos += GET_DENTRY_SLOTS(le16_to_cpu(de->name_len));
 	}
 
-- 
2.0.1.474.g72c7794



------------------------------------------------------------------------------
Open source business process management suite built on Java and Eclipse
Turn processes into business applications with Bonita BPM Community Edition
Quickly connect people, data, and systems into organized workflows
Winner of BOSSIE, CODIE, OW2 and Gartner awards
http://p.sf.net/sfu/Bonitasoft
