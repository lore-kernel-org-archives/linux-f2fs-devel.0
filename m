Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3915EC48297
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 12 Feb 2024 16:08:38 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rZYrD-0003wT-3y;
	Mon, 12 Feb 2024 16:08:35 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1rZYrB-0003wJ-Ez
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Feb 2024 16:08:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/2InhzdCdbdALy1oJYLX4A2t+MNMq246GQ8Jswg6qq4=; b=kT+wgwKFWETT26YXB4Gd5EjgAn
 NWl04QmK/oEg3ZdzUOqlPpudEXNxteXck+HaDDiJKb158nMLVagY5BZqBdt5OE1quG/7iAlAsa7d9
 h5hrdOouATw5IANt1loQm/G0Zn7Nipp2aZcParUr0ZilDKqZXRsbmJ7Q+4UCks2YfV7c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=/2InhzdCdbdALy1oJYLX4A2t+MNMq246GQ8Jswg6qq4=; b=N
 svQgVBMa/+ECMD2JneLZdhaLg54kcnlNs48I2oomDLUh95YZNthAyjb04l3VKGCkLEteI60J4HS03
 fWXxSVt10Vw8wnN1qVz+/kZ1cA2uJoMenFRgBiYKJE/DU0+b9fB9HDhjCCAeObbYsLXF5poS9FztV
 1Rzpakb1Huzs5iOY=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rZYrA-00050D-GJ for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Feb 2024 16:08:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 72B18CE12F9
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 12 Feb 2024 16:08:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FDACC433F1;
 Mon, 12 Feb 2024 16:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707754105;
 bh=Ms3jETJiDb4EcBDYV1Y+i+GWoHhcisMI0xE0j1gpI2U=;
 h=From:To:Cc:Subject:Date:From;
 b=Y2cu4EFD9qnbjoBlUafM0p11mG6L9waqaPUOVxb3yX9hTK5vzLE9F8XWhDI6IcLmg
 Tp4nhkaXMZnGfzGPa3ksH8oosIPoxTCPn9h0P1mQ38KhCX7faXRb+3ZGdm3ck0jmLN
 5+8rkiYhkXB4jgwbr0iq5ni1uful1cNP/MKAi8vZFSBGPs6kw8uY+BQhYWHQ2rt217
 RMs8GsQDU/BM2pcdXtCyJeBym5B/Zd60gUBjLWDLJayQD6E02/ahNkwrPnaS/W57fE
 4/wjDkVOivyTfojCafXj/cFOs2MfI4qIw69QFGMs6+Jn7t+xOp8ncAiQACXa+6laJK
 zhskNU2ffhURg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Tue, 13 Feb 2024 00:08:18 +0800
Message-Id: <20240212160818.1020903-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Headers-End: 1rZYrA-00050D-GJ
Subject: [f2fs-dev] [PATCH] f2fs: compress: fix to check zstd compress level
 correctly in mount option
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

f2fs only support to config zstd compress level w/ a positive number due
to layout design, but since commit e0c1b49f5b67 ("lib: zstd: Upgrade to
latest upstream zstd version 1.4.10"), zstd supports negative compress
level, so that zstd_min_clevel() may return a negative number, then w/
below mount option, .compress_level can be configed w/ a negative number,
which is not allowed to f2fs, let's add check condition to avoid it.

mount -o compress_algorithm=zstd:4294967295 /dev/sdx /mnt/f2fs

Fixes: 00e120b5e4b5 ("f2fs: assign default compression level")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/super.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1b718bebfaa1..a29b8e25a2ed 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -669,7 +669,7 @@ static int f2fs_set_lz4hc_level(struct f2fs_sb_info *sbi, const char *str)
 #ifdef CONFIG_F2FS_FS_ZSTD
 static int f2fs_set_zstd_level(struct f2fs_sb_info *sbi, const char *str)
 {
-	unsigned int level;
+	int level;
 	int len = 4;
 
 	if (strlen(str) == len) {
@@ -683,9 +683,15 @@ static int f2fs_set_zstd_level(struct f2fs_sb_info *sbi, const char *str)
 		f2fs_info(sbi, "wrong format, e.g. <alg_name>:<compr_level>");
 		return -EINVAL;
 	}
-	if (kstrtouint(str + 1, 10, &level))
+	if (kstrtoint(str + 1, 10, &level))
 		return -EINVAL;
 
+	/* f2fs does not support negative compress level now */
+	if (level < 0) {
+		f2fs_info(sbi, "do not support negative compress level: %d", level);
+		return -ERANGE;
+	}
+
 	if (!f2fs_is_compress_level_valid(COMPRESS_ZSTD, level)) {
 		f2fs_info(sbi, "invalid zstd compress level: %d", level);
 		return -EINVAL;
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
