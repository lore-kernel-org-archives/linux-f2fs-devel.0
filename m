Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD2F6C52D6F
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  8 Aug 2024 11:51:26 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sc1fv-0001M0-Sa;
	Thu, 08 Aug 2024 11:51:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <christophe.jaillet@wanadoo.fr>) id 1sc1fu-0001L5-2w
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 08 Aug 2024 11:51:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cYtU3cwJ0fwnXFeK+ZEulL64nxWji9jLh3ldKu9/Uc4=; b=F1b9peTisNq2Sf5BjV631DJa8p
 i7UPP+5FwRow5umLz77Ju5UlLX3I+iDoWAMMXoOF5rUZff1Wf4PMQvmPxsoo2OXmHoAhxLEc99pNG
 nM7ZnL5vRZSAlbIpZFb/ZAo9yDnaXveMEO2LlzhDGKgb14UgOSJpcOn4kefbftmrHNEA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=cYtU3cwJ0fwnXFeK+ZEulL64nxWji9jLh3ldKu9/Uc4=; b=K
 WDYbab9wkXH08RuBiH8TvLpORtVgIfUCpdFfZ5pTb44LPNd0AUJVQ8cLdL62xsOLVYZILohoid5dr
 tUkth2BLMU6w6KRq/rCDlzTxE/wbUzTvrM3TIR/G1B1FFlZt+nS5aG7Os/nGw6rEdM+AI3+v2Bg2k
 nxnFRMuspixeKyyQ=;
Received: from msa-215.smtpout.orange.fr ([193.252.23.215]
 helo=msa.smtpout.orange.fr)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1sc1ft-0004MZ-74 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 08 Aug 2024 11:51:22 +0000
Received: from fedora.home ([90.11.132.44]) by smtp.orange.fr with ESMTPA
 id c1flsSTvRnx6kc1fmsWZkp; Thu, 08 Aug 2024 13:51:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
 s=t20230301; t=1723117874;
 bh=cYtU3cwJ0fwnXFeK+ZEulL64nxWji9jLh3ldKu9/Uc4=;
 h=From:To:Subject:Date:Message-ID:MIME-Version;
 b=O7TKAKzXIBDtMMkFLkwEZLLyCekuVCRfY12OOmcEk0PpY37EmUBZyrytZCnxvK6sn
 jRT/FP2C5d8ihpEF42E0DvldObBocaaS08MjSQtOkEDqQ61N6MUE/AW0QI+F9hkrtR
 iahjEFsjC5PH5aBuXBZ+Rgh5psxy660RYLRC+w2F6mlPbPohS+UgOwMEhmDmYzutNx
 jsBx5D3XEx+s7Z3TRlL4Qe1OXvWoaXuzbeAHvwYcFbsO9O7UxGfZ0Bt6PzIbt3wZc1
 1lF8NqaH4KySj2oMnVNGnUje1kuHYqXAYpaj9B+LkQ1KgXerfL2spG7/xikerI/zMa
 2CZ4JfJ6OxFPw==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 08 Aug 2024 13:51:14 +0200
X-ME-IP: 90.11.132.44
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Thu,  8 Aug 2024 13:50:46 +0200
Message-ID: <0afb817e75a84859e1a86e1a7ba2041a9b852b6e.1723117820.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
X-Headers-End: 1sc1ft-0004MZ-74
Subject: [f2fs-dev] [PATCH] f2fs: Use sysfs_emit_at() to simplify code
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Christophe JAILLET via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This file already uses sysfs_emit(). So be consistent and also use
sysfs_emit_at().

This slightly simplifies the code and makes it more readable.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only
---
 fs/f2fs/sysfs.c | 45 +++++++++++++++++++++------------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index ed4bf434207a..654a541dcc45 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -188,50 +188,50 @@ static ssize_t features_show(struct f2fs_attr *a,
 	int len = 0;
 
 	if (f2fs_sb_has_encrypt(sbi))
-		len += scnprintf(buf, PAGE_SIZE - len, "%s",
+		len += sysfs_emit_at(buf, len, "%s",
 						"encryption");
 	if (f2fs_sb_has_blkzoned(sbi))
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
+		len += sysfs_emit_at(buf, len, "%s%s",
 				len ? ", " : "", "blkzoned");
 	if (f2fs_sb_has_extra_attr(sbi))
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
+		len += sysfs_emit_at(buf, len, "%s%s",
 				len ? ", " : "", "extra_attr");
 	if (f2fs_sb_has_project_quota(sbi))
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
+		len += sysfs_emit_at(buf, len, "%s%s",
 				len ? ", " : "", "projquota");
 	if (f2fs_sb_has_inode_chksum(sbi))
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
+		len += sysfs_emit_at(buf, len, "%s%s",
 				len ? ", " : "", "inode_checksum");
 	if (f2fs_sb_has_flexible_inline_xattr(sbi))
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
+		len += sysfs_emit_at(buf, len, "%s%s",
 				len ? ", " : "", "flexible_inline_xattr");
 	if (f2fs_sb_has_quota_ino(sbi))
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
+		len += sysfs_emit_at(buf, len, "%s%s",
 				len ? ", " : "", "quota_ino");
 	if (f2fs_sb_has_inode_crtime(sbi))
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
+		len += sysfs_emit_at(buf, len, "%s%s",
 				len ? ", " : "", "inode_crtime");
 	if (f2fs_sb_has_lost_found(sbi))
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
+		len += sysfs_emit_at(buf, len, "%s%s",
 				len ? ", " : "", "lost_found");
 	if (f2fs_sb_has_verity(sbi))
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
+		len += sysfs_emit_at(buf, len, "%s%s",
 				len ? ", " : "", "verity");
 	if (f2fs_sb_has_sb_chksum(sbi))
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
+		len += sysfs_emit_at(buf, len, "%s%s",
 				len ? ", " : "", "sb_checksum");
 	if (f2fs_sb_has_casefold(sbi))
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
+		len += sysfs_emit_at(buf, len, "%s%s",
 				len ? ", " : "", "casefold");
 	if (f2fs_sb_has_readonly(sbi))
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
+		len += sysfs_emit_at(buf, len, "%s%s",
 				len ? ", " : "", "readonly");
 	if (f2fs_sb_has_compression(sbi))
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
+		len += sysfs_emit_at(buf, len, "%s%s",
 				len ? ", " : "", "compression");
-	len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
+	len += sysfs_emit_at(buf, len, "%s%s",
 				len ? ", " : "", "pin_file");
-	len += scnprintf(buf + len, PAGE_SIZE - len, "\n");
+	len += sysfs_emit_at(buf, len, "\n");
 	return len;
 }
 
@@ -329,17 +329,14 @@ static ssize_t f2fs_sbi_show(struct f2fs_attr *a,
 		int hot_count = sbi->raw_super->hot_ext_count;
 		int len = 0, i;
 
-		len += scnprintf(buf + len, PAGE_SIZE - len,
-						"cold file extension:\n");
+		len += sysfs_emit_at(buf, len, "cold file extension:\n");
 		for (i = 0; i < cold_count; i++)
-			len += scnprintf(buf + len, PAGE_SIZE - len, "%s\n",
-								extlist[i]);
+			len += sysfs_emit_at(buf, len, "%s\n", extlist[i]);
 
-		len += scnprintf(buf + len, PAGE_SIZE - len,
-						"hot file extension:\n");
+		len += sysfs_emit_at(buf, len, "hot file extension:\n");
 		for (i = cold_count; i < cold_count + hot_count; i++)
-			len += scnprintf(buf + len, PAGE_SIZE - len, "%s\n",
-								extlist[i]);
+			len += sysfs_emit_at(buf, len, "%s\n", extlist[i]);
+
 		return len;
 	}
 
-- 
2.46.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
