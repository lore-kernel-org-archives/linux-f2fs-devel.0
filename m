Return-Path: <SRS0=n2Zs=K5=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BD05C47096
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  3 Jun 2021 10:21:29 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAA826139A
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  3 Jun 2021 10:21:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAA826139A
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:References:Mime-Version:Message-Id:
	In-Reply-To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ryb4H2HvIwcKEbb0vYD1/PRzo7Wu9+U7TziN6iUWx94=; b=dbKgHzFAkqRBIJSW2ws4E+9bU
	JodUPgFHKnjmmlrakE36IEICiz2aMPfUEaseI21ctEl3TUhg1DUMzHTddc18Gi9wOOHNtU9Z1Yo/B
	1obykoWj4V+bqSNfZVK5xyHgjVlC+zsK8c9S9+ndfjG8EDow/UCb655GRyi5bEFlPwoLM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lokTe-0006xy-QW; Thu, 03 Jun 2021 10:21:26 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <39aW4YAYKADAPdaeQZSaaSXQ.OaY@flex--drosen.bounces.google.com>)
 id 1lokTe-0006xm-4x
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 03 Jun 2021 10:21:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:References:
 Mime-Version:Message-Id:In-Reply-To:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kcHV5gWpfes4THP3FELWNQNHxoWa/shR0B9tGbdkBnA=; b=erDHhCrosv3sqyxLtpkSwWQUS
 5vtr5QCJkWBpf0TYLTnOq8TvYTMQeiqmXQ6fSXMj9uMLOET3YTjE3Z240aekYuu+UIa7VoIwNv4by
 DiLBlUeH/I2Y630nEfXBOsiE6nG7tZ+7v1gara9X+tixC+avWzOfBU/IwYm48l1a9tIUo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:References:Mime-Version:Message-Id:
 In-Reply-To:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=kcHV5gWpfes4THP3FELWNQNHxoWa/shR0B9tGbdkBnA=; b=jDKP93urimx3CAhssSser8y/fi
 kcF90kp3DvrMLmUO/vtzCbVxlUTWb7D9n0pi0BpxeSFxvbbmmOvu7T5j/MiR4pDs3a04aanKfrwKt
 Z8EVf38CAGtDImRe1ghC9xkCB1KZR/pP+xLB1HsUIFYa5ZkpKjp6fFSWqerer87vDMQA=;
Received: from mail-yb1-f202.google.com ([209.85.219.202])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.3)
 id 1lokTW-008kMQ-AR
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 03 Jun 2021 10:21:27 +0000
Received: by mail-yb1-f202.google.com with SMTP id
 g9-20020a25ae490000b029052f9e5b7d3fso7104492ybe.4
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 03 Jun 2021 03:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=kcHV5gWpfes4THP3FELWNQNHxoWa/shR0B9tGbdkBnA=;
 b=PuudTZ14PqkkF7RO4Rf+mCRnc/o6LmDJEuNGL3MfafamdxhETKEpKnJAFo+MPejrn9
 73YPmOjxQRlZ/K4bVoxTVtCk5ZeCr3wRNMEZBBXrBjS228q5P3pYjyp1ywX0+XrjXR20
 rpjOUP0z24bcUAqTt4lv5vFxXVbBmU7l2cyeE1jxDXUajHV2b7KGg1ajO2rIZs5QfwSj
 +BK9T05nB4G2UUzcO9BZ9CaJvyG909kWWoKLRFHHHPsHZwvjg0Eyl+QkjBUGhKxbdprO
 3QpyCk+hH+Q3tp3Zku8kCucmsS2kgdLf0wXnstnKuvd9MCNZOtl/fkxTm7cNZw5nNy7F
 VX0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=kcHV5gWpfes4THP3FELWNQNHxoWa/shR0B9tGbdkBnA=;
 b=EtH6HkCsw85+WYXc0WzSXHtXVJabSbV5plWvqxql0lGfEGSQHE0crWAHkwmKLuJeCf
 XZCswz+2S4/S+ogK1dMuttbv1mxmzRr/Q4HFFBSWAhSwtFNaqbgxEypLzj1vjztT/v/c
 WT3wFusG/FlZcJUHwWaiZYv5AkhA6HuiRcRjynm88MInmhDrfcADhPC1CVTjCSsFrz0o
 Hbk+4r8oLy5sTbZbSYcxPn1qO4sXpMMJ+q1k4xMNBE3gUFITMGzCJYnldZAuyHS5BlK/
 0wUGG8+Di8lAkzAA7vph71fSznEJapF6ECHDzQMrbheKrerqW8xYSQIc9cw27HM9bJB/
 d0jA==
X-Gm-Message-State: AOAM531sqBdBtm0tpOnOI5b19VpBdJxYxqvmNRkmOPAFlQfOyfhaw5F6
 LeXqtS3IKCucsctDFWQ6PgGvHeXbxMg=
X-Google-Smtp-Source: ABdhPJy8xiO/ttoSoyFhrkeb1Vy0GuuYttk2gPq2x6PFXSdfcbUYCWy3cBM864we5xBQhIGpxomGoEWRTRQ=
X-Received: from drosen.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:4e6f])
 (user=drosen job=sendgmr) by 2002:a25:a1e2:: with SMTP id
 a89mr51767520ybi.439.1622713845802; 
 Thu, 03 Jun 2021 02:50:45 -0700 (PDT)
Date: Thu,  3 Jun 2021 09:50:38 +0000
In-Reply-To: <20210603095038.314949-1-drosen@google.com>
Message-Id: <20210603095038.314949-3-drosen@google.com>
Mime-Version: 1.0
References: <20210603095038.314949-1-drosen@google.com>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, 
 linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1lokTW-008kMQ-AR
Subject: [f2fs-dev] [PATCH v2 2/2] f2fs: Advertise encrypted casefolding in
 sysfs
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
Cc: Daniel Rosenberg <drosen@google.com>,
 Gabriel Krisman Bertazi <krisman@collabora.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-fsdevel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Older kernels don't support encryption with casefolding. This adds
the sysfs entry encrypted_casefold to show support for those combined
features. Support for this feature was originally added by
commit 7ad08a58bf67 ("f2fs: Handle casefolding with Encryption")

Fixes: 7ad08a58bf67 ("f2fs: Handle casefolding with Encryption")
Cc: stable@vger.kernel.org # v5.11+
Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fs/f2fs/sysfs.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 09e3f258eb52..6604291a3cdf 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -161,6 +161,9 @@ static ssize_t features_show(struct f2fs_attr *a,
 	if (f2fs_sb_has_compression(sbi))
 		len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
 				len ? ", " : "", "compression");
+	if (f2fs_sb_has_casefold(sbi) && f2fs_sb_has_encrypt(sbi))
+		len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
+				len ? ", " : "", "encrypted_casefold");
 	len += scnprintf(buf + len, PAGE_SIZE - len, "%s%s",
 				len ? ", " : "", "pin_file");
 	len += scnprintf(buf + len, PAGE_SIZE - len, "\n");
@@ -579,6 +582,7 @@ enum feat_id {
 	FEAT_CASEFOLD,
 	FEAT_COMPRESSION,
 	FEAT_TEST_DUMMY_ENCRYPTION_V2,
+	FEAT_ENCRYPTED_CASEFOLD,
 };
 
 static ssize_t f2fs_feature_show(struct f2fs_attr *a,
@@ -600,6 +604,7 @@ static ssize_t f2fs_feature_show(struct f2fs_attr *a,
 	case FEAT_CASEFOLD:
 	case FEAT_COMPRESSION:
 	case FEAT_TEST_DUMMY_ENCRYPTION_V2:
+	case FEAT_ENCRYPTED_CASEFOLD:
 		return sprintf(buf, "supported\n");
 	}
 	return 0;
@@ -704,7 +709,10 @@ F2FS_GENERAL_RO_ATTR(avg_vblocks);
 #ifdef CONFIG_FS_ENCRYPTION
 F2FS_FEATURE_RO_ATTR(encryption, FEAT_CRYPTO);
 F2FS_FEATURE_RO_ATTR(test_dummy_encryption_v2, FEAT_TEST_DUMMY_ENCRYPTION_V2);
-#endif
+#ifdef CONFIG_UNICODE
+F2FS_FEATURE_RO_ATTR(encrypted_casefold, FEAT_ENCRYPTED_CASEFOLD);
+#endif /* CONFIG_UNICODE */
+#endif /* CONFIG_FS_ENCRYPTION */
 #ifdef CONFIG_BLK_DEV_ZONED
 F2FS_FEATURE_RO_ATTR(block_zoned, FEAT_BLKZONED);
 #endif
@@ -815,7 +823,10 @@ static struct attribute *f2fs_feat_attrs[] = {
 #ifdef CONFIG_FS_ENCRYPTION
 	ATTR_LIST(encryption),
 	ATTR_LIST(test_dummy_encryption_v2),
-#endif
+#ifdef CONFIG_UNICODE
+	ATTR_LIST(encrypted_casefold),
+#endif /* CONFIG_UNICODE */
+#endif /* CONFIG_FS_ENCRYPTION */
 #ifdef CONFIG_BLK_DEV_ZONED
 	ATTR_LIST(block_zoned),
 #endif
-- 
2.32.0.rc0.204.g9fa02ecfa5-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
