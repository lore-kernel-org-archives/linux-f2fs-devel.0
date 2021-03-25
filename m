Return-Path: <SRS0=qzJ6=IX=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC0E6C433C1
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 25 Mar 2021 00:08:54 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 923E2619F7
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 25 Mar 2021 00:08:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 923E2619F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lPDYU-0005V9-9C; Thu, 25 Mar 2021 00:08:54 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <shreeya.patel@collabora.com>) id 1lPDYT-0005Uo-2b
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 25 Mar 2021 00:08:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lWy4YCALxItmIDXBlIhuAXh+hJKEBlM81XEucGpRZ/A=; b=bnWCu23gdahbjWOfZZ9DlkSAAs
 7n7PgRQDd/hUqvTYUR8lGCqpHGv6qXCrd3Xz7ISuXzfYhSDO+T2tU/9ELW4EU8xFWNbU/zNCn+suJ
 ipyay/qQ9BZTtYqo6bCL2ZLgQMTJsNQmlJdZemITqD4gxa0z8FCIZKBJiIBYpL7c5en4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=lWy4YCALxItmIDXBlIhuAXh+hJKEBlM81XEucGpRZ/A=; b=E3DETMAQC7wHCswI8tANpc2f/z
 EXtmk/0iP0bMXccsOXBF41GNxnt/REhpmDEpkfWM8qwjBzZU242BXMovejGf2fM5vB0LssQrVmNsr
 p4boe5UfVLqCVlWFmtU/ajqiizziSi1mnJCYwtKLzu9SLx6C+ll/2mXTnsiAFz9BXrbQ=;
Received: from bhuna.collabora.co.uk ([46.235.227.227])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1lPDYJ-007TpD-Ml
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 25 Mar 2021 00:08:52 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: shreeya) with ESMTPSA id 4D85F1F45F0B
From: Shreeya Patel <shreeya.patel@collabora.com>
To: tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
 chao@kernel.org, krisman@collabora.com, ebiggers@google.com,
 drosen@google.com, ebiggers@kernel.org, yuchao0@huawei.com
Date: Thu, 25 Mar 2021 05:38:08 +0530
Message-Id: <20210325000811.1379641-3-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210325000811.1379641-1-shreeya.patel@collabora.com>
References: <20210325000811.1379641-1-shreeya.patel@collabora.com>
MIME-Version: 1.0
X-Headers-End: 1lPDYJ-007TpD-Ml
Subject: [f2fs-dev] [PATCH v4 2/5] fs: Check if utf8 encoding is loaded
 before calling utf8_unload()
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
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 andre.almeida@collabora.com, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

utf8_unload is being called if CONFIG_UNICODE is enabled.
The ifdef block doesn't check if utf8 encoding has been loaded
or not before calling the utf8_unload() function.
This is not the expected behavior since it would sometimes lead
to unloading utf8 even before loading it.
Hence, add a condition which will check if sb->encoding is NOT NULL
before calling the utf8_unload().

Reviewed-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
---
 fs/ext4/super.c | 6 ++++--
 fs/f2fs/super.c | 9 ++++++---
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index ad34a37278cd..e438d14f9a87 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1259,7 +1259,8 @@ static void ext4_put_super(struct super_block *sb)
 	fs_put_dax(sbi->s_daxdev);
 	fscrypt_free_dummy_policy(&sbi->s_dummy_enc_policy);
 #ifdef CONFIG_UNICODE
-	utf8_unload(sb->s_encoding);
+	if (sb->s_encoding)
+		utf8_unload(sb->s_encoding);
 #endif
 	kfree(sbi);
 }
@@ -5165,7 +5166,8 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 		crypto_free_shash(sbi->s_chksum_driver);
 
 #ifdef CONFIG_UNICODE
-	utf8_unload(sb->s_encoding);
+	if (sb->s_encoding)
+		utf8_unload(sb->s_encoding);
 #endif
 
 #ifdef CONFIG_QUOTA
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 7069793752f1..0a04983c294e 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1430,7 +1430,8 @@ static void f2fs_put_super(struct super_block *sb)
 	for (i = 0; i < NR_PAGE_TYPE; i++)
 		kvfree(sbi->write_io[i]);
 #ifdef CONFIG_UNICODE
-	utf8_unload(sb->s_encoding);
+	if (sb->s_encoding)
+		utf8_unload(sb->s_encoding);
 #endif
 	kfree(sbi);
 }
@@ -4073,8 +4074,10 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		kvfree(sbi->write_io[i]);
 
 #ifdef CONFIG_UNICODE
-	utf8_unload(sb->s_encoding);
-	sb->s_encoding = NULL;
+	if (sb->s_encoding) {
+		utf8_unload(sb->s_encoding);
+		sb->s_encoding = NULL;
+	}
 #endif
 free_options:
 #ifdef CONFIG_QUOTA
-- 
2.30.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
