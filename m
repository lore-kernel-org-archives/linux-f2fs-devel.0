Return-Path: <SRS0=+EAZ=OF=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC46C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 15 Sep 2021 07:08:30 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 312C861178;
	Wed, 15 Sep 2021 07:08:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 312C861178
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mQP1x-00052C-OM; Wed, 15 Sep 2021 07:08:29 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from
 <BATV+8aa05ddd91fea3e0ef51+6597+infradead.org+hch@casper.srs.infradead.org>)
 id 1mQP1w-00051z-Ab
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 15 Sep 2021 07:08:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ctn47iOUG23WTZHpkRfHiqpVZWyp+4lYPz03KBPcHmM=; b=f3NF7EtYCDJ4lHFrX5UDxSAlvv
 vdI06voUcQkwy6Bi6KnGyGe5htj9Svf8gLbH6bhXbWQCPTnfojQRoI8GX4ldqbHvLN1IQ+y6wSLWC
 dhhGQXQyDmbCvZe1Dgarn+lLApu4NZf/Ser9hE0Hv0IohPmWHDRc56o/VukEfTnRdCJA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ctn47iOUG23WTZHpkRfHiqpVZWyp+4lYPz03KBPcHmM=; b=DOqT7xcDUrIGYBYGoIAzQdpd4h
 h39a4buEYvKMIWbFyddZPJVAFKBBWtslvIz1WBReRNVWx5sTgF4VkWeR+xeh7tIZ2LKK0tnZqExdI
 CRrXqvYBIZvVd3pxgCL0Zyd08+1IVsRbu92Vr6KD5Qe/ZeU8/quoNCZFHDDV5kdjtC2Q=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mQP1v-0000I8-Q9
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 15 Sep 2021 07:08:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=ctn47iOUG23WTZHpkRfHiqpVZWyp+4lYPz03KBPcHmM=; b=aUxOOqH3yUEDxn81r1ojkoN2Pt
 xDcQJd+cpS/z37ePt9x1YQaMvwM36knu8d6vHWyoRyYPrxtFFbWKDXcEC7AKKuCYHRbVczHv5/E+U
 wbLQqBZ1qEu9yQ/cQtcstJ/GEhe6vWMUm5WK3EEnvfWSPzGHSBDvR4FQCatwP6FPWFRUc7BYE73/7
 V9636czZUeqKXCMLrx4ZeRrEup/N7RXRB723lby5hXgxLEobx0r43q8HCoZMp/wm5VVu0bsSECd+j
 A69VYCNv+dPclfwCfrkHgAiquGg4eM1HD8/PT6UxXNzf5GSgnN3l4uabixV8z2ASjC8NETVk2PgCt
 viv+EPng==;
Received: from [2001:4bb8:184:72db:8457:d7a:6e21:dd20] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQP0b-00FRmR-P6; Wed, 15 Sep 2021 07:07:15 +0000
From: Christoph Hellwig <hch@lst.de>
To: Gabriel Krisman Bertazi <krisman@collabora.com>
Date: Wed, 15 Sep 2021 09:00:03 +0200
Message-Id: <20210915070006.954653-9-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210915070006.954653-1-hch@lst.de>
References: <20210915070006.954653-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1mQP1v-0000I8-Q9
Subject: [f2fs-dev] [PATCH 08/11] unicode: move utf8cursor to utf8-selftest.c
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
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 Shreeya Patel <shreeya.patel@collabora.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Only used by the tests, so no need to keep it in the core.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/unicode/utf8-norm.c     | 16 ----------------
 fs/unicode/utf8-selftest.c |  6 ++++++
 fs/unicode/utf8n.h         |  2 --
 3 files changed, 6 insertions(+), 18 deletions(-)

diff --git a/fs/unicode/utf8-norm.c b/fs/unicode/utf8-norm.c
index 348d6e97553f2..1ac90fa00070d 100644
--- a/fs/unicode/utf8-norm.c
+++ b/fs/unicode/utf8-norm.c
@@ -456,22 +456,6 @@ int utf8ncursor(struct utf8cursor *u8c, const struct utf8data *data,
 }
 EXPORT_SYMBOL(utf8ncursor);
 
-/*
- * Set up an utf8cursor for use by utf8byte().
- *
- *   u8c    : pointer to cursor.
- *   data   : const struct utf8data to use for normalization.
- *   s      : NUL-terminated string.
- *
- * Returns -1 on error, 0 on success.
- */
-int utf8cursor(struct utf8cursor *u8c, const struct utf8data *data,
-	       const char *s)
-{
-	return utf8ncursor(u8c, data, s, (unsigned int)-1);
-}
-EXPORT_SYMBOL(utf8cursor);
-
 /*
  * Get one byte from the normalized form of the string described by u8c.
  *
diff --git a/fs/unicode/utf8-selftest.c b/fs/unicode/utf8-selftest.c
index 80fb7c75acb28..04628b50351d3 100644
--- a/fs/unicode/utf8-selftest.c
+++ b/fs/unicode/utf8-selftest.c
@@ -165,6 +165,12 @@ static ssize_t utf8len(const struct utf8data *data, const char *s)
 	return utf8nlen(data, s, (size_t)-1);
 }
 
+static int utf8cursor(struct utf8cursor *u8c, const struct utf8data *data,
+		const char *s)
+{
+	return utf8ncursor(u8c, data, s, (unsigned int)-1);
+}
+
 static void check_utf8_nfdi(void)
 {
 	int i;
diff --git a/fs/unicode/utf8n.h b/fs/unicode/utf8n.h
index 41182e5464dfa..736b6460a38cb 100644
--- a/fs/unicode/utf8n.h
+++ b/fs/unicode/utf8n.h
@@ -65,8 +65,6 @@ struct utf8cursor {
  * Returns 0 on success.
  * Returns -1 on failure.
  */
-extern int utf8cursor(struct utf8cursor *u8c, const struct utf8data *data,
-		      const char *s);
 extern int utf8ncursor(struct utf8cursor *u8c, const struct utf8data *data,
 		       const char *s, size_t len);
 
-- 
2.30.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
