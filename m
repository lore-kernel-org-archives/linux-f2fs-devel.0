Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA24C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 13 May 2022 16:55:55 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1npYa2-0003ob-WB; Fri, 13 May 2022 16:55:53 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <jaegeuk@kernel.org>) id 1npYZx-0003oN-Pk
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 13 May 2022 16:55:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oLIrQGiF71PqY49j0OGzgWMdKAJvcWEJYHnOMWvPp1Q=; b=WbMDTCq3+bK7CffUzpq1azSYpn
 SWkNdwDoiamagTtizKvJVqoLiF7DQUBoaW7qW6daGrb6PunF+K9xWcgLxwO1pwClO62/o4JJCOiAd
 jrCV7NxEQHSJ55jy6ycuW4v3jVU9ZcaD/2TFZaFNd8oKsiFRNR4edCmVHKnomf7OD5wE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=oLIrQGiF71PqY49j0OGzgWMdKAJvcWEJYHnOMWvPp1Q=; b=m
 jga3lM98YhUKMbZcKjt+bjnmJzTqXNYqp9VasjVCfomGtHUJaUKlSaQG2GDRFAMze+cShJ+wvtSVm
 49DWlf8Z6TKVvCatd3kgKVUMreR+85So79lr7fDn88Sk1jgeEQMuQGaonclyLrtZG49IhfUgxcM8J
 hI2sH2tmNxHbB3MI=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1npYZv-0008EJ-IQ
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 13 May 2022 16:55:48 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 32F0861F6C;
 Fri, 13 May 2022 16:55:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E829C34100;
 Fri, 13 May 2022 16:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652460941;
 bh=7hQRe9rGGjsrPN083tCMoOVREK5I7uFqF6niMIOdvcs=;
 h=From:To:Cc:Subject:Date:From;
 b=Y2dxmQdnoUdvHzgPfs2fRgndHr54CPePTh4MA7m37bF0CWkHxVVN0/v3s8C6ptgYb
 0SFkwTu9Dd8ZrW3okZZsGPG+0jzarsdWjQ79PX7tm12bFVjfninUvWUNQIWdJu4rDY
 F3qdrBCeoujBcZgVt5lOyGykxaQK7BayZyK10eo212bhEKsqza2VNtW7VAsk6e9jHy
 u4XhCMCA4EBy5CY3cGrcr4ldWDLNI1/9YY16qJWUPheUjiWnxk7R0QC2NrCgl3XFXk
 YnquocujH1/IScWtIrhs6CXjnmeH4jjMYvxTXDR72H4NU+Iu9uvErsHkCZPxI1JfJ6
 CRiS5RPeQ6bjw==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Fri, 13 May 2022 09:55:40 -0700
Message-Id: <20220513165540.9224-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
MIME-Version: 1.0
X-Headers-End: 1npYZv-0008EJ-IQ
Subject: [f2fs-dev] [PATCH] fsck.f2fs: fix broken file_map output
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
Cc: Michael Benedict <michaelbenedicttjahya@gmail.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

The new fsck progress should not be used for file_map.

Reported-by: Michael Benedict <michaelbenedicttjahya@gmail.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/fsck.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index 3b37519e9054..4b546aeff995 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -498,7 +498,7 @@ static int sanity_check_nid(struct f2fs_sb_info *sbi, u32 nid,
 		fsck->chk.valid_node_cnt++;
 
 		/* Progress report */
-		if (sbi->total_valid_node_count > 1000) {
+		if (!c.show_file_map && sbi->total_valid_node_count > 1000) {
 			unsigned int p10 = sbi->total_valid_node_count / 10;
 
 			if (sbi->fsck->chk.checked_node_cnt++ % p10)
-- 
2.36.0.550.gb090851708-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
