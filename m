Return-Path: <SRS0=U74u=NV=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42AAC432BE
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 30 Aug 2021 00:36:03 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 766AE6054F
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 30 Aug 2021 00:36:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 766AE6054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mKVHN-0003wr-S3; Mon, 30 Aug 2021 00:36:01 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <chao@kernel.org>) id 1mKVHM-0003wb-Px
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 30 Aug 2021 00:36:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xPpsjd/t10edleqFOZBNE1HMdxZ2o0mRY0N28lL/xn4=; b=WFYyibj7KSABOnp7DBnBfCWyhi
 xX2VF952MgG3bwRhmxFMW8uFKf/ghoidvGQozEtO11aN2OqIsPRc0pevIveUhzHw41+t+OlQmqc16
 C03sBno7Z/0hLOpiJrmVU0nd7oMt9GVb8MkH5WcUt1xM0Yee/c9nrPBEGcbC7yKruZg0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=xPpsjd/t10edleqFOZBNE1HMdxZ2o0mRY0N28lL/xn4=; b=P
 418oJ8X8TDwB6RXEbieGJZ8s/PgOxlcmCsreFeETcH0u1zEOxpzhuIsfRmY/rDzPiSsxOXYj8Xm+7
 2qf51ZjeY45nBvgy5k/QHwFdV+DhJAsVIfOoFHbvtlVk5tivOV74H5djDvLkfVdbAbxqUu6zDkbmi
 2l3JaOH/2Rht9XS4=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mKVHC-007EG3-4l
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 30 Aug 2021 00:36:00 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9BF2560F4C;
 Mon, 30 Aug 2021 00:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1630283739;
 bh=UXaVialVYc+g0/THdnyLtCXZoh9xKNxvU2i8RfeiQFI=;
 h=From:To:Cc:Subject:Date:From;
 b=HFUutMLNwyu+ZkPlRUjy1Cpq6Km0LCCNBkoz3VAmjAfwdyTcZkql4Q4rE0wKcs6aT
 gQG0t3HbspInWnJanF+50whDuvURvEaJcadpzgCeSNMoSQjPnZUPStzBQVqMLHq1od
 wd0UeedacaOTnZ4aj4Dr9kyJEauhnMt56aLTLq6MFVmknzgnF9UslWIwwkCEjUWsZ2
 7I5dppN0jFyPcVGzFg1Snz141jP48FYvN229lzWXnsH+7C3YEfTkgMT15Q/eeXGzJg
 YjqR8eIepoXWah3Z51ydR+7x56qsJc9mKAxEAuZpNY20M3Wec6JqvTa11eORD2rDbG
 5bi3whgWx7EVA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Mon, 30 Aug 2021 08:35:33 +0800
Message-Id: <20210830003533.38898-1-chao@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Headers-End: 1mKVHC-007EG3-4l
Subject: [f2fs-dev] [PATCH v2] f2fs: enable realtime discard iff device
 supports discard
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
Cc: Chao Yu <chao.yu@linux.dev>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Let's only enable realtime discard if and only if device supports
discard functionality.

Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- don't give EINVAL if device doesn't support discard for "-o discard"
mountoption to avoid break userspace behavior.
 fs/f2fs/super.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index f5148f2fd884..27c78c96d866 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -661,10 +661,14 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 				return -EINVAL;
 			break;
 		case Opt_discard:
+			if (!f2fs_hw_support_discard(sbi)) {
+				f2fs_warn(sbi, "device does not support discard");
+				break;
+			}
 			set_opt(sbi, DISCARD);
 			break;
 		case Opt_nodiscard:
-			if (f2fs_sb_has_blkzoned(sbi)) {
+			if (f2fs_hw_should_discard(sbi)) {
 				f2fs_warn(sbi, "discard is required for zoned block devices");
 				return -EINVAL;
 			}
@@ -2001,7 +2005,8 @@ static void default_options(struct f2fs_sb_info *sbi)
 	F2FS_OPTION(sbi).unusable_cap = 0;
 	sbi->sb->s_flags |= SB_LAZYTIME;
 	set_opt(sbi, FLUSH_MERGE);
-	set_opt(sbi, DISCARD);
+	if (f2fs_hw_support_discard(sbi) || f2fs_hw_should_discard(sbi))
+		set_opt(sbi, DISCARD);
 	if (f2fs_sb_has_blkzoned(sbi)) {
 		F2FS_OPTION(sbi).fs_mode = FS_MODE_LFS;
 		F2FS_OPTION(sbi).discard_unit = DISCARD_UNIT_SECTION;
-- 
2.32.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
