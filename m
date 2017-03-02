From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs-tools: calculate cp_ver correctly
Date: Thu, 2 Mar 2017 11:39:09 +0800
Message-ID: <20170302033909.92109-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1cjHbB-00012B-Dd
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 02 Mar 2017 03:40:13 +0000
Received: from [45.249.212.187] (helo=dggrg01-dlp.huawei.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cjHb8-0002Ep-Ig
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 02 Mar 2017 03:40:13 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

It needs to check CP_CRC_RECOVERY_FLAG during cp_ver calculation.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 include/f2fs_fs.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 057adf39f6a9..a92011b83ff5 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -1089,10 +1089,13 @@ static inline __le64 get_cp_crc(struct f2fs_checkpoint *cp)
 {
 	u_int64_t cp_ver = get_cp(checkpoint_ver);
 	size_t crc_offset = get_cp(checksum_offset);
+	unsigned int ckpt_flags = le32_to_cpu(cp->ckpt_flags);
+
 	u_int32_t crc = le32_to_cpu(*(__le32 *)((unsigned char *)cp +
 							crc_offset));
 
-	cp_ver |= ((u_int64_t)crc << 32);
+	if (ckpt_flags & CP_CRC_RECOVERY_FLAG)
+		cp_ver |= ((u_int64_t)crc << 32);
 	return cpu_to_le64(cp_ver);
 }
 
-- 
2.8.2.295.g3f1c1d0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
