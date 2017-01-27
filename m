From: DongOh Shin <doscode.kr@gmail.com>
Subject: [PATCH 1/5] Fix coding style errors in f2fs.h
Date: Fri, 27 Jan 2017 10:29:36 -0800
Message-ID: <20170127182940.11389-2-doscode.kr@gmail.com>
References: <20170127182940.11389-1-doscode.kr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <doscode.kr@gmail.com>) id 1cXBHs-0004OZ-6I
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 27 Jan 2017 18:30:16 +0000
Received: from mail-pg0-f65.google.com ([74.125.83.65])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1cXBHr-0007z7-FZ
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 27 Jan 2017 18:30:16 +0000
Received: by mail-pg0-f65.google.com with SMTP id 204so25572597pge.2
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Fri, 27 Jan 2017 10:30:15 -0800 (PST)
In-Reply-To: <20170127182940.11389-1-doscode.kr@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: doscode.kr@gmail.com, linux-f2fs-devel@lists.sourceforge.net

Two coding style errors below have been resolved:
"Macros with complex values should be enclosed in parentheses"

Signed-off-by: DongOh Shin <doscode.kr@gmail.com>
---
 fs/f2fs/f2fs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 4cce13d..5d257a9 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -108,9 +108,9 @@ struct f2fs_mount_info {
 #define F2FS_HAS_FEATURE(sb, mask)					\
 	((F2FS_SB(sb)->raw_super->feature & cpu_to_le32(mask)) != 0)
 #define F2FS_SET_FEATURE(sb, mask)					\
-	F2FS_SB(sb)->raw_super->feature |= cpu_to_le32(mask)
+	(F2FS_SB(sb)->raw_super->feature |= cpu_to_le32(mask))
 #define F2FS_CLEAR_FEATURE(sb, mask)					\
-	F2FS_SB(sb)->raw_super->feature &= ~cpu_to_le32(mask)
+	(F2FS_SB(sb)->raw_super->feature &= ~cpu_to_le32(mask))
 
 /*
  * For checkpoint manager
-- 
1.8.3.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
