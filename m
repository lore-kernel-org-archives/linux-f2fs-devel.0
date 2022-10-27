Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB403ECAAA1
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 27 Oct 2022 18:04:37 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oo7F6-0003pa-9j;
	Thu, 27 Oct 2022 18:04:36 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1oo7F4-0003pT-BV
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Oct 2022 18:04:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=m20hTtdUThw/zYfR0fqpTwjLETyCpqaFhpxjItmFmh0=; b=fG8kSOWa5Lm8iC+VPKZ6A/VDTV
 WFf/ngeWnz8xVUTaWSm8yG9mMMmwAiWgyuj+3v+DVe+5dQpzDx4fSCWBPF0qMX7dBWTsbVld1oF6i
 xzfig6zIRR7dXXIpU7nepmP1yV4CdEc3xahPSPKdffg/jPzY/P20DqMPpCOMXQhuBByg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=m20hTtdUThw/zYfR0fqpTwjLETyCpqaFhpxjItmFmh0=; b=g
 zHF5cY5yIQw5xzcidgGUZRyEYT+xrmVLZxQvo58PfLFokZGKqIn2c30pGdy1ppKTZKKudips/q8ks
 EVdZ7cUqSK0Z9V2n02msbRaJ0k+ji/pYB5oERq7Oi97OiHFcaT8kLDIl6u8+LvoXiG4qc327PuNki
 nB/NvwWxwxap5ha4=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1oo7F3-002Flp-RB for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Oct 2022 18:04:34 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 6A9B7623ED
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 27 Oct 2022 18:04:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B8EC433C1;
 Thu, 27 Oct 2022 18:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1666893859;
 bh=Re061QOM1zSa4SDCeCrNjsAINlsDxks5xlguK2smzZM=;
 h=From:To:Cc:Subject:Date:From;
 b=MAnB/3Kscb3IH5sMmjEndAtFL5eaFb6jyqsw4Chj4n52vle3fXSVrnPIjuT/KFpq9
 1tDMeF7EXE6QVvQ9/Lr6c78DUwwS/pJXpYBGqxI3Ody5kr0+btddiyB8YyYSbR/4Kc
 khArmFkwnpoi8QSdZlJRm/4GhiEqBrZdX8QpkVprrCpmNn8YZ9+rcFHKSE6l96X4kT
 ITLxNn5bZfEy5DtSbwAI0t/MT5N5g979aXhAgZqPZ0MMKqAv2q3/ojimU9bKM6yu+a
 VS6+D6pYs9kSlC8hWUCBk83xfcs4I/CtH1sju0ekXEYnOhIwI+KKo3A3rbRhm8nfYJ
 /eQ9uFQik5Oig==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Date: Thu, 27 Oct 2022 11:04:16 -0700
Message-Id: <20221027180416.3786792-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
MIME-Version: 1.0
X-Headers-End: 1oo7F3-002Flp-RB
Subject: [f2fs-dev] [PATCH] f2fs: do not stop threads in irq context
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

Let's stop threads first to avoid irq context.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index a241e4073f1d..14b4bb0f8ce6 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3905,6 +3905,9 @@ static void f2fs_record_stop_reason(struct f2fs_sb_info *sbi)
 	struct f2fs_super_block *raw_super = F2FS_RAW_SUPER(sbi);
 	int err;
 
+	f2fs_stop_gc_thread(sbi);
+	f2fs_stop_discard_thread(sbi);
+
 	f2fs_down_write(&sbi->sb_lock);
 
 	spin_lock(&sbi->error_lock);
@@ -4014,9 +4017,6 @@ void f2fs_handle_critical_error(struct f2fs_sb_info *sbi, unsigned char reason,
 	 */
 	smp_wmb();
 	sb->s_flags |= SB_RDONLY;
-
-	f2fs_stop_gc_thread(sbi);
-	f2fs_stop_discard_thread(sbi);
 }
 
 static void flush_error_work(struct work_struct *work)
-- 
2.38.1.273.g43a17bfeac-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
