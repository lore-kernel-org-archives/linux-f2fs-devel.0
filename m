Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BDA2C4167B
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  1 Dec 2023 23:03:28 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1r9CXf-0003Ph-My;
	Fri, 01 Dec 2023 23:03:26 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1r9CXb-0003Pa-Dm
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 01 Dec 2023 23:03:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1nOqAWj20No7G8mrJyYk9Mxl2k+nJ8MA37MHTSjZwxk=; b=CC4BB58gw0OLSQlrNhonRkxG5G
 4/CijeY6YH36uYTAY/sGlYw8EkDaGdyOV+VmhDvSVqBkY4xZfqiMXRvi9H6j7PMrHZgGGmhsfXgjF
 Fdu6CmgNr5cimCkp1KqlsjAb2Vpo/rnhsPUO660q56dKlzhSD2qqhg2Qzwf1N0oG2Ucg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=1nOqAWj20No7G8mrJyYk9Mxl2k+nJ8MA37MHTSjZwxk=; b=h
 beiHYal4VQoXIDSKyRR7CV8hCbwOJb2ac04j0jY8ECBvvBt2LUkH9a1qudqdAE895s1ph/qvPfJPw
 ZE+eNOd7KFxXs/1WG3yyJe1DOYbhArgmgCkM/X2qmv8bU4U/gL/XnXlKk++e6L0wFNPKVkawl7UxB
 ot+LtLxgofapQFwI=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1r9CXY-0005B8-Rk for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 01 Dec 2023 23:03:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 62989CE22C9
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri,  1 Dec 2023 23:02:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93566C433C8;
 Fri,  1 Dec 2023 23:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1701471778;
 bh=62w1oB1pHopShKh9tMtaRg6KHPHhkdny8MubdbV91fQ=;
 h=From:To:Cc:Subject:Date:From;
 b=c2HCOXrnwzG/PgSp+pZZQxjdPmCpwKk49Hqhbo/Ro12tzYvu/nAGK4SXLEUorI70u
 EiN9jVDo+4/2wJ7rrCB1fCsletjR+fW18IqsR+Sq+JlEF82jXTj+jCSiLQ1NcgoC25
 HhXUARvjWEglu0kJZIsOY4ZVJGAa/k+6xp8Xwo1QB3aRagRBuy14GgtD8nkhbd/SHn
 3QHNk/2AnuZAWzlnocjletodpcc3MpV+GcQKLwh/lkU4nZGKXfnzAXBc+b0oM0w+Sl
 8HDJHqePbA88m+S6IYBuGXoGTxbd2G7XAZ9v4y7XX07kbTinTdOqB487uU0DwbbOnZ
 BjE8UUeYynNlg==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Date: Fri,  1 Dec 2023 15:02:56 -0800
Message-ID: <20231201230257.238513-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
MIME-Version: 1.0
X-Headers-End: 1r9CXY-0005B8-Rk
Subject: [f2fs-dev] [PATCH] f2fs: allow checkpoint=disable for zoned block
 device
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Let's allow checkpoint=disable back for zoned block device. It's very risky
as the feature relies on fsck or runtime recovery which matches the write
pointers again if the device rebooted while disabling the checkpoint.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 033af907c3b1..617340e9ea7f 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1422,11 +1422,6 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 		}
 	}
 
-	if (test_opt(sbi, DISABLE_CHECKPOINT) && f2fs_lfs_mode(sbi)) {
-		f2fs_err(sbi, "LFS is not compatible with checkpoint=disable");
-		return -EINVAL;
-	}
-
 	if (test_opt(sbi, ATGC) && f2fs_lfs_mode(sbi)) {
 		f2fs_err(sbi, "LFS is not compatible with ATGC");
 		return -EINVAL;
-- 
2.43.0.rc2.451.g8631bc7472-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
