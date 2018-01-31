From: Hyunchul Lee <hyc.lee@gmail.com>
Subject: [PATCH v2 3/3] f2fs: Add the 'whint_mode' mount option
 to f2fs documentation
Date: Wed, 31 Jan 2018 11:36:59 +0900
Message-ID: <1517366219-22166-4-git-send-email-hyc.lee@gmail.com>
References: <1517366219-22166-1-git-send-email-hyc.lee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.194]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <hyc.lee@gmail.com>) id 1egiGy-00033C-8p
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 31 Jan 2018 02:37:16 +0000
Received: from lgeamrelo12.lge.com ([156.147.23.52])
 by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.89)
 id 1egiGw-0004QU-3b
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 31 Jan 2018 02:37:16 +0000
In-Reply-To: <1517366219-22166-1-git-send-email-hyc.lee@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc: linux-fsdevel@vger.kernel.org, kernel-team@lge.com, Hyunchul Lee <cheol.lee@lge.com>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

From: Hyunchul Lee <cheol.lee@lge.com>

Signed-off-by: Hyunchul Lee <cheol.lee@lge.com>
---
 Documentation/filesystems/f2fs.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
index 13c2ff0..414a160 100644
--- a/Documentation/filesystems/f2fs.txt
+++ b/Documentation/filesystems/f2fs.txt
@@ -174,6 +174,12 @@ offgrpjquota           Turn off group journelled quota.
 offprjjquota           Turn off project journelled quota.
 quota                  Enable plain user disk quota accounting.
 noquota                Disable all plain disk quota option.
+whint_mode=%s          Control which write hints are passed down to block
+                       layer. This supports "off", "user-based", and
+                       "fs-based".  In "off" mode (default), f2fs does not pass
+                       down hints. In "user-based" mode, f2fs tries to pass
+                       down hints given by users. And in "fs-based" mode, f2fs
+                       passes down hints with its policy.
 
 ================================================================================
 DEBUGFS ENTRIES
-- 
1.9.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
