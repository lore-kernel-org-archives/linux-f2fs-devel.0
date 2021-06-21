Return-Path: <SRS0=Iay9=LP=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A559C48BDF
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 21 Jun 2021 02:39:55 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26B13611AC;
	Mon, 21 Jun 2021 02:39:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26B13611AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lv9qo-0002NM-8P; Mon, 21 Jun 2021 02:39:50 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1lv9qm-0002NA-Jf
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 21 Jun 2021 02:39:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3JySJCylwTUelVazDzL+YxJkur34xvdAOOSTvjuUMUE=; b=F7fKyyCWGFeLOleq9jxeq9vwEY
 XrBpB0uK306rrCQ6eWCaWhYuA2imqiGlIUCHVsInyfdoZdWVvioOFK/7PJwrr2qPXtCAcmizsowEq
 70PyGzWpP7mX6wmAW9Af371XyMHFvotoYvYGfIQKar22mX30zRxVpmhHlBZ7FRjSpmeI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=3JySJCylwTUelVazDzL+YxJkur34xvdAOOSTvjuUMUE=; b=D
 xq11v3xBbjh2q6nz96fIZQnF20OiyJCEGNaqJNyjvIi1cJ41+GHlUz78XNovZeq4hBhky3V/eqSpB
 XJHMo1Wygi4r3robyEDGWVO3Ojb+YlJYUWuZsrTI18vlDGllMDEHZJ54bjp8acnssM04+5xe7yK6v
 OVZociz5/VHdRP0c=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1lv9ql-0035mn-CO
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 21 Jun 2021 02:39:52 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id E20C460E0C;
 Mon, 21 Jun 2021 02:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1624243182;
 bh=r4RVU2iJOlHYs1JFAQdtHOidkR6SWVFumwqfab0ceyY=;
 h=From:To:Cc:Subject:Date:From;
 b=tssa7XIE1rNrT7Jl8TrQp9rWUxsKXqyd6QPBLRwwRtXH8a7ZR6v9fGiYvAF/wnhDH
 rzSEij88kcnoJci9iDVOhwK2vShtnUjCeJvZnZSxTMKU/S1ar6/dimmoU4SHa80YjE
 bM4+6TNpMgNeE6AWXKoDqDNPiOn8LMjUmH5u7pacSPOOuZFE/cYG5JRHDP1uo4z8u4
 Q7gw5ZGdnOQcymA7iSOnuzmxHzRuEw6dqr+/l9VptnaZMpicufv7yZMqcunuQTCR03
 hQ+aB/BE95ICH+kEwBG4z0seE/3iySkozyRfHK4a36eIdR09muB1xnNTIT5KaTLA5T
 CgvjU5x6Uqkww==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Sun, 20 Jun 2021 19:39:36 -0700
Message-Id: <20210621023939.1510591-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
MIME-Version: 1.0
X-Headers-End: 1lv9ql-0035mn-CO
Subject: [f2fs-dev] [PATCH 1/4] mkfs.f2fs: remove android features for RO
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

We don't need to enable all android features for RO.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 mkfs/f2fs_format_main.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
index 03eb748170ad..031244d5d67a 100644
--- a/mkfs/f2fs_format_main.c
+++ b/mkfs/f2fs_format_main.c
@@ -110,11 +110,16 @@ static void add_default_options(void)
 		/* -d1 -f -O encrypt -O quota -O verity -w 4096 -R 0:0 */
 		c.dbg_lv = 1;
 		force_overwrite = 1;
+		c.wanted_sector_size = 4096;
+		c.root_uid = c.root_gid = 0;
+
+		/* RO doesn't need any other features */
+		if (c.feature & cpu_to_le32(F2FS_FEATURE_RO))
+			return;
+
 		c.feature |= cpu_to_le32(F2FS_FEATURE_ENCRYPT);
 		c.feature |= cpu_to_le32(F2FS_FEATURE_QUOTA_INO);
 		c.feature |= cpu_to_le32(F2FS_FEATURE_VERITY);
-		c.wanted_sector_size = 4096;
-		c.root_uid = c.root_gid = 0;
 		break;
 	}
 #ifdef CONF_CASEFOLD
-- 
2.32.0.288.g62a8d224e6-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
