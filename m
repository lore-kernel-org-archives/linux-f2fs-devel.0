From: Taehee Yoo <ap420073@gmail.com>
Subject: [PATCH] f2fs: change 0 to false for bool type
Date: Mon, 13 Apr 2015 21:48:06 +0900
Message-ID: <1428929286-16632-1-git-send-email-ap420073@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <ap420073@gmail.com>) id 1Yhdne-0003rc-KE
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 13 Apr 2015 12:49:14 +0000
Received: from mail-pa0-f52.google.com ([209.85.220.52])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Yhdna-0003Bj-SM
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 13 Apr 2015 12:49:14 +0000
Received: by pacyx8 with SMTP id yx8so101243035pac.1
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Mon, 13 Apr 2015 05:49:05 -0700 (PDT)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, cm224.lee@samsung.com, ap420073@gmail.com
Cc: linux-f2fs-devel@lists.sourceforge.net

in the f2fs_fill_super function, variable "retry" is bool type
i think that it should be set as false.

Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---
 fs/f2fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index f2fe666..d524be0 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1212,7 +1212,7 @@ free_sbi:
 
 	/* give only one another chance */
 	if (retry) {
-		retry = 0;
+		retry = false;
 		shrink_dcache_sb(sb);
 		goto try_onemore;
 	}
-- 
1.9.1


------------------------------------------------------------------------------
BPM Camp - Free Virtual Workshop May 6th at 10am PDT/1PM EDT
Develop your own process in accordance with the BPMN 2 standard
Learn Process modeling best practices with Bonita BPM through live exercises
http://www.bonitasoft.com/be-part-of-it/events/bpm-camp-virtual- event?utm_
source=Sourceforge_BPM_Camp_5_6_15&utm_medium=email&utm_campaign=VA_SF
