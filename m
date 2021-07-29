Return-Path: <SRS0=A5bl=MV=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA06C4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 29 Jul 2021 01:22:56 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AC76608FB
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 29 Jul 2021 01:22:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6AC76608FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1m8ulD-00013y-0c; Thu, 29 Jul 2021 01:22:55 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1m8ulB-00013m-PQ
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 29 Jul 2021 01:22:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kmplko0SoGr4Md/4wR0T5J7xYk5dwkmFK2pl19ghwnQ=; b=aX6jdkbUjLZG00BuFAaUBCpGAp
 wtnwqJgMEnOM1zRg4S50yQtHc+Jdhhk7QoCbkYj1l6qJ5NuwAvYcfKPIqvHOycyoQNf9qmUFYau2+
 0eHb2sAyNm5MMLDjEmkQnLprE+kt4WWHjxxmqD25deV2s1yZJBLuZ6VRaezBK+jJEDnc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=kmplko0SoGr4Md/4wR0T5J7xYk5dwkmFK2pl19ghwnQ=; b=A
 5xglXI7iWQ1JhdAMpcNswQJm5rl/VPe0iwGrYxMpiM1T7UTRs2r/c+nZcpT2q3md5/xux5Fwz++Cz
 Rb3lxvD6uwEEWlFlqSu/SdeaKOJZVn0iA8nkwWTOCWvvqx9rTkqQ4qWTvaskmUrU6CE9M/HeJeYj2
 kfyn4Jft15pd7k70=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1m8ulA-005xtv-NE
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 29 Jul 2021 01:22:53 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4127E608FB;
 Thu, 29 Jul 2021 01:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627521767;
 bh=d0zv6RtbSmg5wdXW/LCxn3s+mk2wN2t8jhgBEjbtGcc=;
 h=From:To:Cc:Subject:Date:From;
 b=i6G5Yx3LUfltP2gYE3dSAYTM95ux/dp35zDFndVUcM+TfanOFNDYYHIcLykSo6+j9
 YUUgXI05NgJKg5EYRAjF1BqMu53YGvSs5kiOCVudslok1nJadGH3lotbzM1zjAxCIB
 qmpQ5F/yzhIf8oBontwcdfvcyY6EUzUK1Yq4MI64anGhz/vXe+zJNAm+0+9ARfs3tl
 77bmbHBEJXiY9jh/eFNZIdDqv31qH/W9WuHkQf7cAlzHGUGovTu30eOQiRwsxFb33a
 VaeiYmAlyOkLEDcCQYOakvmzs1jHGBZiH2lhfpJttzFsKzge8wl4sUfZeQNGoYGDIx
 AfgarM/OLsTgg==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Thu, 29 Jul 2021 09:22:17 +0800
Message-Id: <20210729012217.788321-1-chao@kernel.org>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-Headers-End: 1m8ulA-005xtv-NE
Subject: [f2fs-dev] [PATCH RESEND] f2fs: fix wrong checkpoint_changed value
 in f2fs_remount()
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

In f2fs_remount(), return value of test_opt() is an unsigned int type
variable, however when we compare it to a bool type variable, it cause
wrong result, fix it.

Fixes: 4354994f097d ("f2fs: checkpoint disabling")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/super.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 41765e90caa2..18c1ffb8710e 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2062,11 +2062,10 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	bool need_restart_ckpt = false, need_stop_ckpt = false;
 	bool need_restart_flush = false, need_stop_flush = false;
 	bool no_extent_cache = !test_opt(sbi, EXTENT_CACHE);
-	bool disable_checkpoint = test_opt(sbi, DISABLE_CHECKPOINT);
+	bool enable_checkpoint = !test_opt(sbi, DISABLE_CHECKPOINT);
 	bool no_io_align = !F2FS_IO_ALIGNED(sbi);
 	bool no_atgc = !test_opt(sbi, ATGC);
 	bool no_compress_cache = !test_opt(sbi, COMPRESS_CACHE);
-	bool checkpoint_changed;
 #ifdef CONFIG_QUOTA
 	int i, j;
 #endif
@@ -2111,8 +2110,6 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	err = parse_options(sb, data, true);
 	if (err)
 		goto restore_opts;
-	checkpoint_changed =
-			disable_checkpoint != test_opt(sbi, DISABLE_CHECKPOINT);
 
 	/*
 	 * Previous and new state of filesystem is RO,
@@ -2234,7 +2231,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 		need_stop_flush = true;
 	}
 
-	if (checkpoint_changed) {
+	if (enable_checkpoint == !!test_opt(sbi, DISABLE_CHECKPOINT)) {
 		if (test_opt(sbi, DISABLE_CHECKPOINT)) {
 			err = f2fs_disable_checkpoint(sbi);
 			if (err)
-- 
2.22.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
