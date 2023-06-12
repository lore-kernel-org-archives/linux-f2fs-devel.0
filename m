Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16664C7EE2F
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 12 Jun 2023 15:17:20 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q8jIF-00053B-5W;
	Mon, 12 Jun 2023 15:17:19 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1q8jID-000535-Si
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Jun 2023 15:17:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QgdYQ+rC7cMtDwv59wuKaNazUFLjkseUqz6AeXl/mrk=; b=dC4inEfxevzzEj8JlGoVmayOpy
 EVPDNguYnry1nzdAOywVCw0secmDOcyc1Alu96yjUjcWpNZF5plFxLIUrjkjxkhHAOF3G4iiX0VWC
 gbR2OV/6vhRbR+5dTXa9zynfQkvpLaJHLS3/HrKmjNayZygJ0npVsKSau14PU1T6b1MI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:To:
 From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=QgdYQ+rC7cMtDwv59wuKaNazUFLjkseUqz6AeXl/mrk=; b=YlGz06qNtLup7lqZoqbAo01nlH
 oNWssdu9k22+mTxzLhvqPzimQelRF5FRNlJHBzFEWQP5souVTIXPhNMKM4v2hR4v9yXzcJvORqu31
 YY5cJZCG0yaxeHHxBK8EqBrvfO02/4FuKSiaTnNRjEmd2RydmmnjCvtkso3bao+3Q3fM=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q8jIC-000pui-QW for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Jun 2023 15:17:17 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 3A67A62A9B
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 12 Jun 2023 15:17:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B98EC4339B;
 Mon, 12 Jun 2023 15:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1686583027;
 bh=zvMmSk16NAGIeLq/EL3xVdNol4rQeFRyAw2A01ZY1Os=;
 h=Date:From:To:Subject:References:In-Reply-To:From;
 b=IhQTGNZ8O8RGV/cM7SpgNfZL/3shSHAvFLxU3wHUn9zvhTysxcMBk+gE/rhOd1t6y
 oso5GzBlEQluyifZFXhwB1ykK6SHldGCi/ryo0ah/xLpcPcRC941K1PHrk9ZTygSby
 EmU/vi35gJm0jRwqwV9fQDIiCA+gC/yOvhsqB0YtWwP+vQLsMdBbn4zWZpwxhjCAo5
 YcgN8H+PJxyk3n5LEnAusCYO4WOn6ipsxXD7rCkk7x1+ZXCIuWYmkLTmxR9nG74flX
 mosppfyQOcdnT3H/75VJ3TC6GGS8XVDn0yOK2R4ViINoNEE9QUxpfUOI6ONf25PoxZ
 Cykv5GXwfuwlw==
Date: Mon, 12 Jun 2023 08:17:05 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Message-ID: <ZIc28R76RSEC6uo1@google.com>
References: <20230607162954.2651657-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230607162954.2651657-1-jaegeuk@kernel.org>
X-Headers-End: 1q8jIC-000pui-QW
Subject: [f2fs-dev] [PATCH] f2fs: set zstd default compression level to
 ZSTD_CLEVEL_DEFAULT
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

ZSTD does not support compress_level=0.

The commit d7ffafc99c42 ("f2fs: add sanity compress level check for compressed file")
started to complain this.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
Change log from v1:
 - use default macro

 fs/f2fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 8fd23caa1ed9..ce3b628b5072 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -627,7 +627,7 @@ static int f2fs_set_zstd_level(struct f2fs_sb_info *sbi, const char *str)
 	int len = 4;
 
 	if (strlen(str) == len) {
-		F2FS_OPTION(sbi).compress_level = 0;
+		F2FS_OPTION(sbi).compress_level = ZSTD_CLEVEL_DEFAULT;
 		return 0;
 	}
 
-- 
2.41.0.162.gfafddb0af9-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
