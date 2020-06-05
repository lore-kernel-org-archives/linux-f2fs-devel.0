Return-Path: <SRS0=5W2J=7S=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED226C433DF
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  5 Jun 2020 18:16:04 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE07F206A2
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  5 Jun 2020 18:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="MtgZknnV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="RY/Wrylb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE07F206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jhGst-0002Nd-Iz; Fri, 05 Jun 2020 18:16:03 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yefremov.denis@gmail.com>) id 1jhGst-0002NV-6z
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 05 Jun 2020 18:16:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PzTrpawMm7O0gb9SBDejxurvPz9n3lKWKd8gdwMZTqc=; b=MtgZknnVDCrBKPpPDrWdErgBBU
 YMQTyCAn3DV3It/5iZIQpuRQ0SXQHsvK95IWAVGJL0XAbRxKlAy0AaQpRUfDYaS5XkrXIgkUHsvF2
 EKrGKvFzCeX1dkQg291u2AP9RYBwY8YhlFuKiHrrYXmF3s6ZyycstAeEYAsFOiQtCbgI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=PzTrpawMm7O0gb9SBDejxurvPz9n3lKWKd8gdwMZTqc=; b=RY/WrylbqIwgX455l9YUIunN/E
 5EW6KgDn/b/Mjs0doqvOQ2MlyaTyhHyd+pVrLk1I6gdDJaVoPpZfF9drTXDf3ZejH8INi4rAGH4It
 b/PiQ1M67rxa5XJ0p54j4cYBIf1Ea7oUPQoY5vnSgTXVZ0uv8rLeNh3N/MBHVwcDv/Hs=;
Received: from mail-lf1-f65.google.com ([209.85.167.65])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1jhGsp-00D7wN-BI
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 05 Jun 2020 18:16:03 +0000
Received: by mail-lf1-f65.google.com with SMTP id 82so6357505lfh.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 05 Jun 2020 11:15:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PzTrpawMm7O0gb9SBDejxurvPz9n3lKWKd8gdwMZTqc=;
 b=SGVnlgla5/eZWXL27/UkEsBF3T1gH5FR93Qqnf2gLwNQlVhiCV5xzI/yBjmQ3U20aU
 ToGSktwWytFWei8mfHYl4zaZ9q2iTdJCvOVYrrqADqFoLviMjSEFgf6xLMlRl3sLrfQv
 goJkr5Y6bmiiec0Ozo/D1Agz8LfErWuw6vX8ZVdk1sQgYwZy+zgBJOF3EJWc1rbiXar+
 EpyKhWP4I0Ga0QfWXFOFpnR5P3MBYap7EEBc6apka6a0vLX9Y5RVKHWWVkwNlzANFWeq
 UguaKfwEN/ALexKfhV5U68BJOkmmvETDyySLcd6UwVbB4hjt1s3W9EcP8+lMKAXSh3M5
 oEMA==
X-Gm-Message-State: AOAM531XYdQO7wmM6pL7SyafVshe5sXSo3Is3S6ObrbxSaAEKZMTGUNY
 ou6IyOIziLPeKUZJAk7MObE=
X-Google-Smtp-Source: ABdhPJzS0ySE70abv12q8PAXQnaxqUsoCsmWcoB6VQxt9iAJI1Oi5J6udwx5tG9MKHTxOZrZWfbTgg==
X-Received: by 2002:ac2:5481:: with SMTP id t1mr5967357lfk.102.1591380945576; 
 Fri, 05 Jun 2020 11:15:45 -0700 (PDT)
Received: from localhost.localdomain (broadband-37-110-38-130.ip.moscow.rt.ru.
 [37.110.38.130])
 by smtp.googlemail.com with ESMTPSA id x69sm1254625lff.19.2020.06.05.11.15.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 11:15:45 -0700 (PDT)
From: Denis Efremov <efremov@linux.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Fri,  5 Jun 2020 21:15:33 +0300
Message-Id: <20200605181533.73113-2-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200605181533.73113-1-efremov@linux.com>
References: <20200605181533.73113-1-efremov@linux.com>
MIME-Version: 1.0
X-Headers-End: 1jhGsp-00D7wN-BI
Subject: [f2fs-dev] [PATCH 2/2] f2fs: use kfree() to free sbi in
 f2fs_fill_super()
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
Cc: linux-kernel@vger.kernel.org, Denis Efremov <efremov@linux.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Use kfree() instead of kvfree() to free sbi in
f2fs_fill_super() because the memory is allocated with
kzalloc() in the function.

Fixes: 5222595d093e ("f2fs: use kvmalloc, if kmalloc is failed")
Signed-off-by: Denis Efremov <efremov@linux.com>
---
 fs/f2fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 9a3c8eba37e2..39b644c7e9d4 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3812,7 +3812,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 free_sbi:
 	if (sbi->s_chksum_driver)
 		crypto_free_shash(sbi->s_chksum_driver);
-	kvfree(sbi);
+	kfree(sbi);
 
 	/* give only one another chance */
 	if (retry_cnt > 0 && skip_recovery) {
-- 
2.26.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
