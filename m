From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 05/18] f2fs crypto: add encryption xattr support
Date: Fri,  8 May 2015 21:20:40 -0700
Message-ID: <1431145253-2019-5-git-send-email-jaegeuk@kernel.org>
References: <1431145253-2019-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YqwGM-0003uL-O5
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 09 May 2015 04:21:18 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YqwGM-0007iD-2q for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 09 May 2015 04:21:18 +0000
In-Reply-To: <1431145253-2019-1-git-send-email-jaegeuk@kernel.org>
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

This patch add some definition for enrcyption xattr.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/xattr.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/xattr.h b/fs/f2fs/xattr.h
index 969d792..71a7100 100644
--- a/fs/f2fs/xattr.h
+++ b/fs/f2fs/xattr.h
@@ -35,6 +35,10 @@
 #define F2FS_XATTR_INDEX_LUSTRE			5
 #define F2FS_XATTR_INDEX_SECURITY		6
 #define F2FS_XATTR_INDEX_ADVISE			7
+/* Should be same as EXT4_XATTR_INDEX_ENCRYPTION */
+#define F2FS_XATTR_INDEX_ENCRYPTION		9
+
+#define F2FS_XATTR_NAME_ENCRYPTION_CONTEXT	"c"
 
 struct f2fs_xattr_header {
 	__le32  h_magic;        /* magic number for identification */
-- 
2.1.1


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
