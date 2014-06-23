From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 1/1] fs/f2fs/segment.c: replace count*size
	kzalloc by kcalloc
Date: Mon, 23 Jun 2014 18:39:15 +0200
Message-ID: <1403541555-10803-1-git-send-email-fabf@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <fabf@skynet.be>) id 1Wz7IX-0001RP-9c
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 23 Jun 2014 16:40:49 +0000
Received: from mailrelay011.isp.belgacom.be ([195.238.6.178])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Wz7IU-0005KS-29 for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 23 Jun 2014 16:40:49 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org
Cc: Fabian Frederick <fabf@skynet.be>, linux-f2fs-devel@lists.sourceforge.net

kcalloc manages count*sizeof overflow.

Cc: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net
Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 fs/f2fs/segment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index f25f0e0..96f51d4 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1702,7 +1702,7 @@ static int build_curseg(struct f2fs_sb_info *sbi)
 	struct curseg_info *array;
 	int i;
 
-	array = kzalloc(sizeof(*array) * NR_CURSEG_TYPE, GFP_KERNEL);
+	array = kcalloc(NR_CURSEG_TYPE, sizeof(*array), GFP_KERNEL);
 	if (!array)
 		return -ENOMEM;
 
-- 
1.8.4.5


------------------------------------------------------------------------------
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://p.sf.net/sfu/hpccsystems
