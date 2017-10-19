From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] f2fs: avoid using timespec
Date: Thu, 19 Oct 2017 11:52:47 +0200
Message-ID: <20171019095252.688181-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <arnd@arndb.de>) id 1e57Vr-0006vI-JL
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 19 Oct 2017 09:53:15 +0000
Received: from mout.kundenserver.de ([212.227.17.24])
 by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
 (Exim 4.76) id 1e57Vq-00083M-30
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 19 Oct 2017 09:53:15 +0000
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
Cc: Arnd Bergmann <arnd@arndb.de>, Eric Biggers <ebiggers@google.com>, y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Deepa Dinamani <deepa.kernel@gmail.com>, linux-fsdevel@vger.kernel.org, DongOh Shin <doscode.kr@gmail.com>, Tomohiro Kusumi <tkusumi@tuxera.com>

All uses of timespec are deprecated, and this one is not particularly
useful, as the documented method for converting seconds to jiffies
is to multiply by 'HZ'.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/f2fs/f2fs.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 4b4a72f392be..b9a4a5db426c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1178,8 +1178,7 @@ static inline void f2fs_update_time(struct f2fs_sb_info *sbi, int type)
 
 static inline bool f2fs_time_over(struct f2fs_sb_info *sbi, int type)
 {
-	struct timespec ts = {sbi->interval_time[type], 0};
-	unsigned long interval = timespec_to_jiffies(&ts);
+	unsigned long interval = sbi->interval_time[type] * HZ;
 
 	return time_after(jiffies, sbi->last_time[type] + interval);
 }
-- 
2.9.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
