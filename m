From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 2/3] f2fs crypto: check dir entry just for
	directory
Date: Mon, 25 May 2015 18:08:08 +0800
Message-ID: <00d501d096d2$cdd373f0$697a5bd0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1YwpJj-0006iM-Az
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 25 May 2015 10:09:07 +0000
Received: from [203.254.224.33] (helo=mailout3.samsung.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1YwpJf-0006Fx-FV
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 25 May 2015 10:09:07 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout3.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NOW00IU9HIU5M50@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 25 May 2015 19:08:54 +0900 (KST)
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch fixes to add a judgement condition to verify type of the
target inode before empty directory verification.

So wrong verification could be avoided for non-directory inode.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/crypto_policy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/crypto_policy.c b/fs/f2fs/crypto_policy.c
index bef254b..56b2ac0 100644
--- a/fs/f2fs/crypto_policy.c
+++ b/fs/f2fs/crypto_policy.c
@@ -93,7 +93,7 @@ int f2fs_process_policy(const struct f2fs_encryption_policy *policy,
 		return -EINVAL;
 
 	if (!f2fs_inode_has_encryption_context(inode)) {
-		if (!f2fs_empty_dir(inode))
+		if (S_ISDIR(inode->i_mode) && !f2fs_empty_dir(inode))
 			return -ENOTEMPTY;
 		return f2fs_create_encryption_context_from_policy(inode,
 								  policy);
-- 
2.3.0



------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
