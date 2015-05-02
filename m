From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 02/19] f2fs: add missing version info in
	superblock
Date: Fri,  1 May 2015 17:48:29 -0700
Message-ID: <1430527726-68547-2-git-send-email-jaegeuk@kernel.org>
References: <1430527726-68547-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YoLcF-0008Dk-Qb
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 02 May 2015 00:49:11 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YoLcF-0000oi-4m for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 02 May 2015 00:49:11 +0000
In-Reply-To: <1430527726-68547-1-git-send-email-jaegeuk@kernel.org>
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

The mkfs.f2fs remains kernel version in superblock, but f2fs module has not
added that so far.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 include/linux/f2fs_fs.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index 591f8c3..8d345c2 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -50,6 +50,8 @@
 #define MAX_ACTIVE_NODE_LOGS	8
 #define MAX_ACTIVE_DATA_LOGS	8
 
+#define VERSION_LEN	256
+
 /*
  * For superblock
  */
@@ -86,6 +88,9 @@ struct f2fs_super_block {
 	__le32 extension_count;		/* # of extensions below */
 	__u8 extension_list[F2FS_MAX_EXTENSION][8];	/* extension array */
 	__le32 cp_payload;
+	__u8 version[VERSION_LEN];	/* the kernel version */
+	__u8 init_version[VERSION_LEN];	/* the initial kernel version */
+	__u8 reserved[892];		/* valid reserved region */
 } __packed;
 
 /*
-- 
2.1.1


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
