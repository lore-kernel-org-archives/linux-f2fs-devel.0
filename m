Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF91C28B20
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Mar 2025 02:54:45 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tz5IQ-0008I0-Ti;
	Mon, 31 Mar 2025 02:54:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1tz5IP-0008Hu-CV
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Mar 2025 02:54:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jyJbrO5XX1C2/Zzemuj7uSBO9DbfBsL0f0lasSutosc=; b=PoDYEg0bFgJrErdcAEXprZdlUx
 LUzkrdksxJfZOlher7XLOCyxvD5L+pCuh+RqIF8MudZXu2RToJxvhAk6F5dDHtQoc1P9bUpD8lnl4
 ZJfU6tSmkRR+t95iJR/sv1V4pzzOWfAncV1prXyU2qBNEFtovCG+lGQRSvhguEurtcZQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=jyJbrO5XX1C2/Zzemuj7uSBO9DbfBsL0f0lasSutosc=; b=D
 YKuiaggB0HDV45dUs9kEEm4arDkt+dyx1vnECAjvSMBtHnQ7iPOkS/grul1+EtRpo8Xh/d7+dZxiN
 Br7mKKh+KpsTw02p2owV4FTE+x3tGLK2YylHFRtXCypsTYPeLCi1NbUMjE3r/goGNBeCY95+aBW67
 dLR09x8n5xgbCvaQ=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tz5IO-00038Q-PT for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Mar 2025 02:54:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 762C95C4807;
 Mon, 31 Mar 2025 02:52:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C25DDC4CEDD;
 Mon, 31 Mar 2025 02:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1743389670;
 bh=7Z2EIHF8x4PJH3op9sBJfYoA1Ntx+xrA64V25jPhWzo=;
 h=From:To:Cc:Subject:Date:From;
 b=FeVND4DiKJWTvEhvuWBhi2UbberU3753Yrpjn7hpD2Pi9+bWMuR3GOvUhheHpc/Yp
 Yu1i+oN7TEu/5tymgp8f0Lc+xu+5gebCmtmCT5GMc7R3m8OMNUYCWKsfNztZjhwb2k
 v3ZfS3nBEZPxbpXLQSzm251MfG4BXp2MVI1UYw7UEsV52OByb0PJD8lF9a72u1r8mS
 TtEipzpPSq2kfYXl55vkowu32pfDIHQ1eBJM39yEwsImTtmZp0hUf496F8eSs/jWNh
 qlJYVO3Z5AyK4MEpfh6LhV50+SgymcQ7abcwISMPAbuDfhLY+wwn/FHpHLqnvlaCNg
 Of1+HhezJ1mxQ==
To: jaegeuk@kernel.org
Date: Mon, 31 Mar 2025 10:54:16 +0800
Message-ID: <20250331025416.478380-1-chao@kernel.org>
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
MIME-Version: 1.0
X-Headers-End: 1tz5IO-00038Q-PT
Subject: [f2fs-dev] [PATCH] f2fs: support to disable linear lookup fallback
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: Gabriel Krisman Bertazi <krisman@suse.de>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

After commit 91b587ba79e1 ("f2fs: Introduce linear search for
dentries"), f2fs forced to use linear lookup whenever a hash-based
lookup fails on casefolded directory, it may affect performance
for scenarios: a) create a new file w/ filename it doesn't exist
in directory, b) lookup a file which may be removed.

This patch supports to disable linear lookup fallback, so, once there
is a solution for commit 5c26d2f1d3f5 ("unicode: Don't special case
ignorable code points") to fix red heart unicode issue, then we can
set an encodeing flag to disable the fallback for performance recovery.

The way is kept in line w/ ext4, refer to commit 9e28059d5664 ("ext4:
introduce linear search for dentries").

Cc: Daniel Lee <chullee@google.com>
Cc: Gabriel Krisman Bertazi <krisman@suse.de>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/dir.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 5a63ff0df03b..e12445afb95a 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -366,7 +366,8 @@ struct f2fs_dir_entry *__f2fs_find_entry(struct inode *dir,
 
 out:
 #if IS_ENABLED(CONFIG_UNICODE)
-	if (IS_CASEFOLDED(dir) && !de && use_hash) {
+	if (IS_CASEFOLDED(dir) && !de && use_hash &&
+		!sb_no_casefold_compat_fallback(dir->i_sb)) {
 		use_hash = false;
 		goto start_find_entry;
 	}
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
