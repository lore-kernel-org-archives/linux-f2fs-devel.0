From: Wang Shilong <wangshilong1991@gmail.com>
Subject: [PATCH 2/2] statx.2: add project support update
Date: Fri,  1 Mar 2019 23:06:24 +0900
Message-ID: <1551449184-7942-3-git-send-email-wshilong1991@gmail.com>
References: <1551449184-7942-1-git-send-email-wshilong1991@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <wangshilong1991@gmail.com>) id 1gzioG-0004Pg-FB
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 01 Mar 2019 14:06:44 +0000
Received: from mail-pl1-f195.google.com ([209.85.214.195])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1gzioE-006oPv-V1
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 01 Mar 2019 14:06:44 +0000
Received: by mail-pl1-f195.google.com with SMTP id c17so8369470plz.13
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 01 Mar 2019 06:06:42 -0800 (PST)
In-Reply-To: <1551449184-7942-1-git-send-email-wshilong1991@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: adilger@dilger.ca, linux-man@vger.kernel.org, lixi@ddn.com, Wang Shilong <wshilong@ddn.com>

From: Wang Shilong <wshilong@ddn.com>

Cc: linux-man@vger.kernel.org
Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 man2/statx.2 | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/man2/statx.2 b/man2/statx.2
index 7265d8ace..6a9dede8b 100644
--- a/man2/statx.2
+++ b/man2/statx.2
@@ -82,6 +82,7 @@ struct statx {
        containing the filesystem where the file resides */
     __u32 stx_dev_major;   /* Major ID */
     __u32 stx_dev_minor;   /* Minor ID */
+    __u32 stx_projid;      /* Project ID of file */
 };
 .EE
 .in
@@ -261,6 +262,7 @@ STATX_SIZE	Want stx_size
 STATX_BLOCKS	Want stx_blocks
 STATX_BASIC_STATS	[All of the above]
 STATX_BTIME	Want stx_btime
+STATX_PROJID	Want stx_projid
 STATX_ALL	[All currently available fields]
 .TE
 .in
@@ -412,6 +414,9 @@ The device on which this file (inode) resides.
 .IR stx_rdev_major " and "  stx_rdev_minor
 The device that this file (inode) represents if the file is of block or
 character device type.
+.TP
+.I stx_projid
+The file's project ID.
 .PP
 For further information on the above fields, see
 .BR inode (7).
@@ -458,6 +463,9 @@ See
 .TP
 .B STATX_ATTR_ENCRYPTED
 A key is required for the file to be encrypted by the filesystem.
+.TP
+.B STATX_ATTR_PROJINHERIT
+Sub directories or files will inherit parent's project ID automatically.
 .SH RETURN VALUE
 On success, zero is returned.
 On error, \-1 is returned, and
-- 
2.19.1
