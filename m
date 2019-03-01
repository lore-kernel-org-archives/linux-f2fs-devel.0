From: Wang Shilong <wangshilong1991@gmail.com>
Subject: [PATCH 1/2] fchownat.2: add project support updates
Date: Fri,  1 Mar 2019 23:06:22 +0900
Message-ID: <1551449184-7942-1-git-send-email-wshilong1991@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <wangshilong1991@gmail.com>) id 1gzioB-0002P1-BU
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 01 Mar 2019 14:06:39 +0000
Received: from mail-pl1-f196.google.com ([209.85.214.196])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1gzio9-00GmpJ-MN
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 01 Mar 2019 14:06:38 +0000
Received: by mail-pl1-f196.google.com with SMTP id k2so11551068plt.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 01 Mar 2019 06:06:37 -0800 (PST)
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

From: Wang Shilong <wshilong@ddn.com>

Cc: linux-man@vger.kernel.org
Signed-off-by: Wang Shilong <wshilong@ddn.com>
---
 man2/chown.2 | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/man2/chown.2 b/man2/chown.2
index 50db789ac..fad74df20 100644
--- a/man2/chown.2
+++ b/man2/chown.2
@@ -217,6 +217,11 @@ instead operate on the link itself, like
 .BR fchownat ()
 dereferences symbolic links, like
 .BR chown ().)
+.TP
+.B AT_FCHOWN_PROJID
+Use
+.I group
+to change file's project ID instead of its group ID.
 .PP
 See
 .BR openat (2)
-- 
2.19.1
