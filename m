Return-Path: <SRS0=vASv=AF=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179F3C433DF
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 24 Jun 2020 05:04:37 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA4E4206E2
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 24 Jun 2020 05:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.b="Ggr4cwmJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="JndA8RIp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="cf6Sg/IT";
	dkim=neutral (0-bit key) header.d=google.com header.i=@google.com header.b="tZlQ1+jy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA4E4206E2
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:References:Mime-Version:Message-Id:
	In-Reply-To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Nk64JW4atU7kcyNYPxo2wwvxHOP4A5RrzL/14scEr6k=; b=Ggr4cwmJsZmCAPBR4fFlKSqhm
	7WxWFZ+MHOxGHGBU9IXjGANGKK9qdU0Jh+/NNZljRf6A2Fu5QpS7TT5gTa7c+9weBQ3oNBY+vunZQ
	ROr4lAy5apMtGfgURAf4P6GT6f3B+TM9sOAbZxIJGik5ieKJColBk5Csp+8aLdQCTWeEY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jnxaO-0006p6-Fd; Wed, 24 Jun 2020 05:04:36 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <3tdfyXgYKAC4NbYcOXQYYQVO.MYW@flex--drosen.bounces.google.com>)
 id 1jnxaM-0006oy-Po
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 24 Jun 2020 05:04:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:References:
 Mime-Version:Message-Id:In-Reply-To:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wjYzq7dNm+b/15M65eILIbgPJ/utRyDEBt1j+IyIFNc=; b=JndA8RIppjRz15UBiIlSpXyIF
 bBMEPNOABA8a5mcbPiQbgCCowWJg32Fn5K1YO2zTjPFHwvCQXYdMiDb5nLXgzi4/6WhW6b0SXbVGn
 9o4U0HXRhIMhAhojtHP5cFz9zELzWQCnf8zDDpKVtU12nBV8rLbbS3Bepnhi3OFrGUsP0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:References:Mime-Version:Message-Id:
 In-Reply-To:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=wjYzq7dNm+b/15M65eILIbgPJ/utRyDEBt1j+IyIFNc=; b=cf6Sg/IT9yehfkPeqSYgIvnJ/L
 4Nn04aE9ahwEoQcCqhUzqhL9iQ1IirqMqk/pZZ5FUCYZbGdip7L5AlNWKQZt6BfSg/bSSUiQyOzA1
 a1KxIPBoM38OIC+CPf/CjTEz/6wCCwTjcP9PHgjYgqd+9EO4o7rVkdUg/EeiSBfJFdCs=;
Received: from mail-qk1-f202.google.com ([209.85.222.202])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1jnxaL-00GA4S-D4
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 24 Jun 2020 05:04:34 +0000
Received: by mail-qk1-f202.google.com with SMTP id i6so780886qkn.22
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 23 Jun 2020 22:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=wjYzq7dNm+b/15M65eILIbgPJ/utRyDEBt1j+IyIFNc=;
 b=tZlQ1+jyfoR+7clXo6vrzd7pzgmnVS1pNwJ0UpJnMv8xv9+lzT5abGBMINYUNEUfgy
 wdW429okaRdglWfYGu7Ufv0UtQ5ZeFFeGzVjbeo0Xr8kg504XwZmBSE6aggZ+/vpQUXr
 jf/RyvipjXVfAL3RKcKQ3/zZm23wd9GYDVLGifCgvkc9Nu3e3J5/r9Fbt9l4vnko05Lw
 3KLoYb78+1YFNX3aWw3/90HzD3sa+Per824hrr4K1hxgUMUJe5rxLQdxiTtq4A22HSw6
 tZDO7K5LI3nuAlIbk0UEgIYk7QPJ35tPLzqslI5XJF8EJLq4Utbmj6YYPnRXMwnzxzf2
 GSzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=wjYzq7dNm+b/15M65eILIbgPJ/utRyDEBt1j+IyIFNc=;
 b=U7+VqEk1aPytSnZsZvVDjzY/jOTMSDwhtN+L2iwi+j14OPFRc51HR9MpjHdlxkh/tM
 4Ca3E125fl24lFU4FTgjllk5P/RN2qfcE03N7VUuyipXMARj+SRGZSZ4SfSRIPamK2lX
 kEX6kIzMi7VQzIVDTUV+haXvWPNmvu3F9JpqdLvlvPLgxCaP7MrBEhVUTNZYcqHYtmmR
 4XhxOWjREcyxS0CWPokUnTD+kGuFPKZ7MDAZ+NIzMER4xYYZ/SAXgENodt+LlmMku4/w
 wlGYZtIdOn70SzAPVUveTun4RZOnL01oycFw84AOvUp8IZDG4cPrixfzFN9vtcloJrmd
 l8xQ==
X-Gm-Message-State: AOAM533/Qu1qjPgm9jiNn5GSp8F7tYuqFEln8lyFmroElyI/oqceQ0AX
 Z88d9qVCc7Gtp/HztjPDmpSSadlsbkA=
X-Google-Smtp-Source: ABdhPJwQv3r1LvOO9FWS3NA1m0vFrLjIyQEAcgvFUZrYFA3esKkj7HG6enTwbe1RS/YIKDoAxkLiThK0vyo=
X-Received: by 2002:ad4:49aa:: with SMTP id u10mr30687919qvx.162.1592973237877; 
 Tue, 23 Jun 2020 21:33:57 -0700 (PDT)
Date: Tue, 23 Jun 2020 21:33:38 -0700
In-Reply-To: <20200624043341.33364-1-drosen@google.com>
Message-Id: <20200624043341.33364-2-drosen@google.com>
Mime-Version: 1.0
References: <20200624043341.33364-1-drosen@google.com>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
To: "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org, 
 Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, 
 linux-f2fs-devel@lists.sourceforge.net, Eric Biggers <ebiggers@kernel.org>, 
 linux-fscrypt@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Richard Weinberger <richard@nod.at>
X-Headers-End: 1jnxaL-00GA4S-D4
Subject: [f2fs-dev] [PATCH v9 1/4] unicode: Add utf8_casefold_hash
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
From: Daniel Rosenberg via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Daniel Rosenberg <drosen@google.com>
Cc: Daniel Rosenberg <drosen@google.com>, linux-doc@vger.kernel.org,
 kernel-team@android.com, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel@vger.kernel.org, Andreas Dilger <adilger.kernel@dilger.ca>,
 linux-fsdevel@vger.kernel.org, linux-mtd@lists.infradead.org,
 Gabriel Krisman Bertazi <krisman@collabora.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This adds a case insensitive hash function to allow taking the hash
without needing to allocate a casefolded copy of the string.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fs/unicode/utf8-core.c  | 23 ++++++++++++++++++++++-
 include/linux/unicode.h |  3 +++
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/fs/unicode/utf8-core.c b/fs/unicode/utf8-core.c
index 2a878b739115d..90656b9980720 100644
--- a/fs/unicode/utf8-core.c
+++ b/fs/unicode/utf8-core.c
@@ -6,6 +6,7 @@
 #include <linux/parser.h>
 #include <linux/errno.h>
 #include <linux/unicode.h>
+#include <linux/stringhash.h>
 
 #include "utf8n.h"
 
@@ -122,9 +123,29 @@ int utf8_casefold(const struct unicode_map *um, const struct qstr *str,
 	}
 	return -EINVAL;
 }
-
 EXPORT_SYMBOL(utf8_casefold);
 
+int utf8_casefold_hash(const struct unicode_map *um, const void *salt,
+		       struct qstr *str)
+{
+	const struct utf8data *data = utf8nfdicf(um->version);
+	struct utf8cursor cur;
+	int c;
+	unsigned long hash = init_name_hash(salt);
+
+	if (utf8ncursor(&cur, data, str->name, str->len) < 0)
+		return -EINVAL;
+
+	while ((c = utf8byte(&cur))) {
+		if (c < 0)
+			return c;
+		hash = partial_name_hash((unsigned char)c, hash);
+	}
+	str->hash = end_name_hash(hash);
+	return 0;
+}
+EXPORT_SYMBOL(utf8_casefold_hash);
+
 int utf8_normalize(const struct unicode_map *um, const struct qstr *str,
 		   unsigned char *dest, size_t dlen)
 {
diff --git a/include/linux/unicode.h b/include/linux/unicode.h
index 990aa97d80496..74484d44c7554 100644
--- a/include/linux/unicode.h
+++ b/include/linux/unicode.h
@@ -27,6 +27,9 @@ int utf8_normalize(const struct unicode_map *um, const struct qstr *str,
 int utf8_casefold(const struct unicode_map *um, const struct qstr *str,
 		  unsigned char *dest, size_t dlen);
 
+int utf8_casefold_hash(const struct unicode_map *um, const void *salt,
+		       struct qstr *str);
+
 struct unicode_map *utf8_load(const char *version);
 void utf8_unload(struct unicode_map *um);
 
-- 
2.27.0.111.gc72c7da667-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
