Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D0F9C05027
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  8 Feb 2023 21:25:17 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pPrwI-0005fI-Ez;
	Wed, 08 Feb 2023 21:25:13 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1pPrwG-0005fB-D2
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 08 Feb 2023 21:25:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MYg+hIpHYv+GCseRUwxrRR487ZrXJ+ZOHBsq2H12VFw=; b=ks5+laVl9OgvhQLc3peN4iT/N5
 cU2ZzYo5TUzybM5L5Y904PAdTcEpTMMaC2TxvHsk9SsOt1p5Xlf45e6pmS093x6Rbv9o46UwKyROF
 Er5vQcG92hiLwxWcP12nSDOU0JAk4qErFgxuor5hlhau/2GHNjZrCLh7mGL17+g3bJ9Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=MYg+hIpHYv+GCseRUwxrRR487ZrXJ+ZOHBsq2H12VFw=; b=Q
 iz/cHtAgCaj3I6bMHY6DbUWqJ1+s4BUfJsPTafTuyPqoIbEiOi85EV5zrn8oEeqsDU09r262jUqeW
 nAfVfq4/+oBqAzTjTSpwXKjMaDQ7vcuZww2sZCPLyWkdzwfq26zaMe/exQJunZyS1WlOKpizJND3P
 EAtHWv57xmKW2CuM=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pPrwE-00FTnI-0f for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 08 Feb 2023 21:25:11 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 9786B617CF
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  8 Feb 2023 21:25:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF501C433D2;
 Wed,  8 Feb 2023 21:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1675891504;
 bh=O8SqGRTKAI1EzMIJIo7tw5hAec1UOfDobk5NcAQ+p8E=;
 h=From:To:Cc:Subject:Date:From;
 b=X8dziiOup5jCENH+y8VxA0+ogi7PeGlcaOED0qonT8PWa/CJ80KiAMJ6Q2lf9vJS8
 +7itB8EtqQiqXZsXEMyJdR5gFzD4DjckHgsL5j3f9HztuJays7ZSfgl5MxazDN864U
 DKFAJVCTU6LUOOD6NBn/gIlDqbA7Iv5jwlD3QrtQu7f1JwDA82Pzc9hRKJLjDpanTA
 KU1gMZe2bdHb/ME0AqW1U6G+1T8nAYQEkL+7uQC+kMXntXZK0q8G7/CG5P2fnJUJLC
 fDREP1jBQS8F8Fihq6oIxhPWFBgnfBiI02sqn+ULbFFIiO1CPJlfuWNtNgvFl7O1be
 UbhXbm8/c31lA==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Wed,  8 Feb 2023 13:25:02 -0800
Message-Id: <20230208212502.339427-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
MIME-Version: 1.0
X-Headers-End: 1pPrwE-00FTnI-0f
Subject: [f2fs-dev] [PATCH] mkfs.f2fs: trim all the devices except the first
 one
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

We need to check the first disk only, and trim the other disks.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 mkfs/f2fs_format_utils.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mkfs/f2fs_format_utils.c b/mkfs/f2fs_format_utils.c
index 597c2b3a7b1c..448fbaa8866e 100644
--- a/mkfs/f2fs_format_utils.c
+++ b/mkfs/f2fs_format_utils.c
@@ -129,6 +129,10 @@ static bool is_wiped_device(int i)
 	int nblocks = 4096;	/* 16MB size */
 	int j;
 
+	/* let's trim the other devices except the first device */
+	if (i > 0)
+		return false;
+
 	buf = malloc(F2FS_BLKSIZE);
 	if (buf == NULL) {
 		MSG(1, "\tError: Malloc Failed for buf!!!\n");
-- 
2.39.1.519.gcb327c4b5f-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
