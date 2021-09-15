Return-Path: <SRS0=+EAZ=OF=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96F2C433FE
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 15 Sep 2021 07:07:36 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F30D61185;
	Wed, 15 Sep 2021 07:07:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6F30D61185
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mQP15-0004vR-Ty; Wed, 15 Sep 2021 07:07:35 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from
 <BATV+8aa05ddd91fea3e0ef51+6597+infradead.org+hch@casper.srs.infradead.org>)
 id 1mQP14-0004vD-Cz
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 15 Sep 2021 07:07:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6OPFUqW/e7vubD4u/iFL4D4EShCGd15ditWyTiZVzcg=; b=h/7u/HwWDqweh/ClTP0PnFPRhd
 CdiuWxCppdmdByp5MWn0XSWFJbCp+CyTFDxDsuEMO6AXIvkakPo8Ii39eduMcUB805HyqK7R70bMJ
 9m5bbGVPCSe/gFcD0HGDlX5nxfmH/vPd2Jd8/wbsxYOyKDMVPKx+EKZC3FNyDTX7CL3c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6OPFUqW/e7vubD4u/iFL4D4EShCGd15ditWyTiZVzcg=; b=eyzJEeq98P8cv5+aIRBdI17wZS
 5hQCtirasR13euDPQTu0JYDGXezfbTNymP5g7VgLCM5AqwnEkSglQELJzQXs61Spa5tXD1wxTrOqf
 Uq+U9B7SfgYcNXt/n9bItadLd+wF86YQckWaShqxFNK34b81APco7fjc4pE9KlIDiwNU=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mQP10-00BFhv-Rh
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 15 Sep 2021 07:07:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=6OPFUqW/e7vubD4u/iFL4D4EShCGd15ditWyTiZVzcg=; b=rNI1M4cQEZ7nw/T7h4zQmqhG8w
 xc5M0lxSkAa9a03MMgv7aK9MoF8jdjVsD8b2qes0/i8gU9aMpwPDxoxVdlTrGBziodeNYLNKTJr5G
 RtsrLtytoJKmjEqaP5BnTFSo1xAMSeTdhlvP7mOpCbiA7bGeQ2nU8PkZOkjIOTw1z2ta7SvjH9Zdu
 LMAHkx8ed2ouF7M28Dl0xnAYeJOqWVzLvRieNGvVDB94XAk/n4pfq5DrnjpXptcwzae/ndPo6oumy
 cZgWn7HTg3T14Y4QEp+eQpBW+uSG06RtxM64j7/Lp6WzeZRq3pjoAkj3E+O3I67VXRMTFwyXVOefP
 eXhvczeg==;
Received: from [2001:4bb8:184:72db:8457:d7a:6e21:dd20] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQOyp-00FRgx-Vs; Wed, 15 Sep 2021 07:05:53 +0000
From: Christoph Hellwig <hch@lst.de>
To: Gabriel Krisman Bertazi <krisman@collabora.com>
Date: Wed, 15 Sep 2021 09:00:02 +0200
Message-Id: <20210915070006.954653-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210915070006.954653-1-hch@lst.de>
References: <20210915070006.954653-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1mQP10-00BFhv-Rh
Subject: [f2fs-dev] [PATCH 07/11] unicode: simplify utf8len
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

Just use the utf8nlen implementation with a (size_t)-1 len argument,
similar to utf8_lookup.  Also move the function to utf8-selftest.c, as
it isn't used anywhere else.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/unicode/utf8-norm.c     | 30 ------------------------------
 fs/unicode/utf8-selftest.c |  5 +++++
 fs/unicode/utf8n.h         |  1 -
 3 files changed, 5 insertions(+), 31 deletions(-)

diff --git a/fs/unicode/utf8-norm.c b/fs/unicode/utf8-norm.c
index 4b1b53391ce4b..348d6e97553f2 100644
--- a/fs/unicode/utf8-norm.c
+++ b/fs/unicode/utf8-norm.c
@@ -391,36 +391,6 @@ static utf8leaf_t *utf8lookup(const struct utf8data *data,
 	return utf8nlookup(data, hangul, s, (size_t)-1);
 }
 
-/*
- * Length of the normalization of s.
- * Return -1 if s is not valid UTF-8 unicode.
- *
- * A string of Default_Ignorable_Code_Point has length 0.
- */
-ssize_t utf8len(const struct utf8data *data, const char *s)
-{
-	utf8leaf_t	*leaf;
-	size_t		ret = 0;
-	unsigned char	hangul[UTF8HANGULLEAF];
-
-	if (!data)
-		return -1;
-	while (*s) {
-		leaf = utf8lookup(data, hangul, s);
-		if (!leaf)
-			return -1;
-		if (utf8agetab[LEAF_GEN(leaf)] > data->maxage)
-			ret += utf8clen(s);
-		else if (LEAF_CCC(leaf) == DECOMPOSE)
-			ret += strlen(LEAF_STR(leaf));
-		else
-			ret += utf8clen(s);
-		s += utf8clen(s);
-	}
-	return ret;
-}
-EXPORT_SYMBOL(utf8len);
-
 /*
  * Length of the normalization of s, touch at most len bytes.
  * Return -1 if s is not valid UTF-8 unicode.
diff --git a/fs/unicode/utf8-selftest.c b/fs/unicode/utf8-selftest.c
index 37f33890e012f..80fb7c75acb28 100644
--- a/fs/unicode/utf8-selftest.c
+++ b/fs/unicode/utf8-selftest.c
@@ -160,6 +160,11 @@ static const struct {
 	}
 };
 
+static ssize_t utf8len(const struct utf8data *data, const char *s)
+{
+	return utf8nlen(data, s, (size_t)-1);
+}
+
 static void check_utf8_nfdi(void)
 {
 	int i;
diff --git a/fs/unicode/utf8n.h b/fs/unicode/utf8n.h
index e4c8a767cf7a5..41182e5464dfa 100644
--- a/fs/unicode/utf8n.h
+++ b/fs/unicode/utf8n.h
@@ -39,7 +39,6 @@ extern const struct utf8data *utf8nfdicf(unsigned int maxage);
  * Returns 0 if only ignorable code points are present.
  * Returns -1 if the input is not valid UTF-8.
  */
-extern ssize_t utf8len(const struct utf8data *data, const char *s);
 extern ssize_t utf8nlen(const struct utf8data *data, const char *s, size_t len);
 
 /* Needed in struct utf8cursor below. */
-- 
2.30.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
