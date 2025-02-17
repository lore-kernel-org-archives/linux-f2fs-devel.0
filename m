Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AA9DC021A9
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 17 Feb 2025 12:38:53 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tk0Og-0008MD-Hx;
	Mon, 17 Feb 2025 12:38:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1tk0Og-0008M5-6z
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 17 Feb 2025 12:38:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PG4fgAQZzNMo6ov3oZ4DBtF16u/USn4AaJj1RnMBbyA=; b=mqmj+u7zIvbdQlrdBFmG9SAOtO
 kJhj9yIuG2nB4mstsEJI8CmpHCHMRNri7pxQbiM1nJaTteUYlQpNl6WZDi8NVRds6u5d+dJnok+6F
 z0bGbqucbCnhsjDeB45sAw4Wra2DoiBZ8RUMjAjJ9Id/cS3gjlx5ZJPXL8vsygn5RMJI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=PG4fgAQZzNMo6ov3oZ4DBtF16u/USn4AaJj1RnMBbyA=; b=jVVHB3opx/QOhi4Usl92a9FNn7
 qkXIaKJv/cyrladSELOUJYJflLtV+ybvxWde+T9vG94qpt1JGB+kTD4Yg5/gHrRGt9mzA2zGfo5mT
 OYO9FAUfMGBw3k+Zaw9YsqtWv+9/VTFJepMCp1ArTOWxqRkZ0FtNAqkJv/YbINEeTn4c=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tk0Og-0006Qy-8l for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 17 Feb 2025 12:38:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 8A5975C55BE;
 Mon, 17 Feb 2025 12:38:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A6E7C4CED1;
 Mon, 17 Feb 2025 12:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1739795924;
 bh=X0oRZi8zYTDNfAJos6hQDutixGfIUWF4rPx0EH6eyLw=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=PvkSZJkfULpDTie60tVXnfff1IZSq8ewJEUdKfnnOgGdBxhs+vahQQByLMw+WO6qa
 OdBWOLEaaeuFTco5PG0mFnlUeeWGduo58eyJgvGndEQAylWQV+jsamVLlVsme+MQ5d
 2LrwNi/9KqFeyRQyCemmt/GUEexGMqzD35oBckzy3oWkErltHCuxTe1Gv135QxVmXi
 5DodKwE/jEcptJ43IRunJ477ym3dVvx4ewmj6KBfwltvVuBEt8Ahzlha31bTKT4hYq
 xcCRpv23YZ0BiKTofg5sLeBA+QRiKuLjvu+ikTdUUdYSeQH7h+gcFQ9+TuXDJFoK7m
 b3pblP27d8stA==
Message-ID: <53598146-1f01-41ad-980e-9f4b989e81ab@kernel.org>
Date: Mon, 17 Feb 2025 20:38:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Yohan Joung <jyh429@gmail.com>, jaegeuk@kernel.org, daeho43@gmail.com
References: <20250204145353.165-1-yohan.joung@sk.com>
Content-Language: en-US
In-Reply-To: <20250204145353.165-1-yohan.joung@sk.com>
X-Headers-End: 1tk0Og-0006Qy-8l
Subject: Re: [f2fs-dev] [PATCH v1] f2fs: fix to ensure queued discard
 commands are properly issued
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2/4/25 22:53, Yohan Joung wrote:
> F2FS zone storage requires discard and reset zone for each conventional,
> zoned device.
> In the current configuration, Discard granularity is set to the zone
> size but queuing is inserted into the pend list with a maximum size of the
> segment size As a result queued commands cannot be issued.
> so we are restorting discard granularity to its original state

It seems commit 4f993264fe29 ("f2fs: introduce discard_unit mount option")
introduced a bug: when we enable discard_unit=section option, it will set
.discard_granularity to BLKS_PER_SEC(), however discard granularity only
supports [1, 512], once section size is not equal to segment size, it will
cause bug. blkzoned feature became the victim since it use
discard_unit=section option by default.

What:           /sys/fs/f2fs/<disk>/discard_granularity
Date:           July 2017
Contact:        "Chao Yu" <yuchao0@huawei.com>
Description:    Controls discard granularity of inner discard thread. Inner thread
                will not issue discards with size that is smaller than granularity.
                The unit size is one block(4KB), now only support configuring
                in range of [1, 512]. Default value is 16.
                For small devices, default value is 1.

What about this?

Subject: [PATCH] f2fs: fix to set .discard_granularity correctly

commit 4f993264fe29 ("f2fs: introduce discard_unit mount option") introduced
a bug, when we enable discard_unit=section option, it will set
.discard_granularity to BLKS_PER_SEC(), however discard granularity only
supports [1, 512], once section size is not equal to segment size, it will
cause issue_discard_thread() in DPOLICY_BG mode will not select discard entry
w/ any granularity to issue.

Fixes: 4f993264fe29 ("f2fs: introduce discard_unit mount option")
Signed-off-by: Yohan Joung <yohan.joung@sk.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/segment.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 6ebe25eafafa..2b415926641f 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2320,10 +2320,9 @@ static int create_discard_cmd_control(struct f2fs_sb_info *sbi)
 	dcc->discard_granularity = DEFAULT_DISCARD_GRANULARITY;
 	dcc->max_ordered_discard = DEFAULT_MAX_ORDERED_DISCARD_GRANULARITY;
 	dcc->discard_io_aware = DPOLICY_IO_AWARE_ENABLE;
-	if (F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_SEGMENT)
+	if (F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_SEGMENT ||
+		F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_SECTION)
 		dcc->discard_granularity = BLKS_PER_SEG(sbi);
-	else if (F2FS_OPTION(sbi).discard_unit == DISCARD_UNIT_SECTION)
-		dcc->discard_granularity = BLKS_PER_SEC(sbi);

 	INIT_LIST_HEAD(&dcc->entry_list);
 	for (i = 0; i < MAX_PLIST_NUM; i++)
-- 
2.48.1.601.g30ceb7b040-goog




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
