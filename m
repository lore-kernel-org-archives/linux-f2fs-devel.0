Return-Path: <SRS0=J76h=NJ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9853FC4320E
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 18 Aug 2021 14:11:22 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 577D260295;
	Wed, 18 Aug 2021 14:11:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 577D260295
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mGMHq-0006Va-14; Wed, 18 Aug 2021 14:11:22 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from
 <BATV+c26a8f31a710de91e748+6569+infradead.org+hch@casper.srs.infradead.org>)
 id 1mGMHo-0006VT-Sz
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 18 Aug 2021 14:11:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xF37HHtJ9cCyf/tD4T3D2NA1Hm2ffytUKSp7nde/n7w=; b=AgqvNn06kYBbrDnWmFSsoOTNGi
 G55yHToKLZ3ex09OmrkmWXKyXmd8BdaylS6Ae2z62vXPEBqGatmhEAzTN6SN4pZpzup3jpqn3+ayz
 /h/+7I0CHtZsUn8G8AlGUI3gXPLaJsiZhY5NVbgJLcEgsHjfQZwAYvKIVb9uhVDsS9Tk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=xF37HHtJ9cCyf/tD4T3D2NA1Hm2ffytUKSp7nde/n7w=; b=efkoVck6ACs6xOZHIU7Xj8pDlS
 Zo16eplGqpkbR/76g95pouzWTFcpGDeKF5/jVVZIaGVm90VkuBwhKX7M28U3K3upe6Qy1uo4GPJ97
 q7sc04nlheufHaPGhWw25PDnJbYtBcNVVPqI7im1CyRLVGwjBCK3wwak1S/+2gqdw0zg=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mGMHo-00AXQM-9y
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 18 Aug 2021 14:11:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=xF37HHtJ9cCyf/tD4T3D2NA1Hm2ffytUKSp7nde/n7w=; b=h+NlzP2kBp6K9ActIGzJh8bm2k
 kYmcKNHroU3KyqP11rWLE/BCZqKWE+OcAmdszJ0q15QKN2pKxomWbQBihuxshlMKYZc2TpzY5V9B2
 qQU1e5HUaE6/y5kRj85z+QBLO/TOPFKLrazdp193mD3tFKh3NtItHTuaWQDHlIY9lOpJSKddf8SfD
 LbM4z2nIJ5weULEH+wyHBEnFwpy5CnASoEvLzYsA8J0xZFThSUXfaAH60IQ+bUe0/6XFV/eZFeNud
 tqqnpthQDt74bWvI83WdKTiw+ohwqwJqqEP0b8cutE71m+58/Mn3Umgwa04lALjYpTl5VF+sOe8W4
 glrPutdA==;
Received: from [2001:4bb8:188:1b1:5a9e:9f39:5a86:b20c] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mGMG0-003uPq-K8; Wed, 18 Aug 2021 14:09:45 +0000
From: Christoph Hellwig <hch@lst.de>
To: Gabriel Krisman Bertazi <krisman@collabora.com>
Date: Wed, 18 Aug 2021 16:06:42 +0200
Message-Id: <20210818140651.17181-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210818140651.17181-1-hch@lst.de>
References: <20210818140651.17181-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1mGMHo-00AXQM-9y
Subject: [f2fs-dev] [PATCH 02/11] f2fs: simplify f2fs_sb_read_encoding
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

Return the encoding table as the return value instead of as an argument,
and don't bother with the encoding flags as the caller can handle that
trivially.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/f2fs/super.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 8fecd3050ccd..af63ae009582 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -260,24 +260,17 @@ static const struct f2fs_sb_encodings {
 	{F2FS_ENC_UTF8_12_1, "utf8", "12.1.0"},
 };
 
-static int f2fs_sb_read_encoding(const struct f2fs_super_block *sb,
-				 const struct f2fs_sb_encodings **encoding,
-				 __u16 *flags)
+static const struct f2fs_sb_encodings *
+f2fs_sb_read_encoding(const struct f2fs_super_block *sb)
 {
 	__u16 magic = le16_to_cpu(sb->s_encoding);
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(f2fs_sb_encoding_map); i++)
 		if (magic == f2fs_sb_encoding_map[i].magic)
-			break;
-
-	if (i >= ARRAY_SIZE(f2fs_sb_encoding_map))
-		return -EINVAL;
+			return &f2fs_sb_encoding_map[i];
 
-	*encoding = &f2fs_sb_encoding_map[i];
-	*flags = le16_to_cpu(sb->s_encoding_flags);
-
-	return 0;
+	return NULL;
 }
 
 struct kmem_cache *f2fs_cf_name_slab;
@@ -3730,13 +3723,14 @@ static int f2fs_setup_casefold(struct f2fs_sb_info *sbi)
 		struct unicode_map *encoding;
 		__u16 encoding_flags;
 
-		if (f2fs_sb_read_encoding(sbi->raw_super, &encoding_info,
-					  &encoding_flags)) {
+		encoding_info = f2fs_sb_read_encoding(sbi->raw_super);
+		if (!encoding_info) {
 			f2fs_err(sbi,
 				 "Encoding requested by superblock is unknown");
 			return -EINVAL;
 		}
 
+		encoding_flags = le16_to_cpu(sbi->raw_super->s_encoding_flags);
 		encoding = utf8_load(encoding_info->version);
 		if (IS_ERR(encoding)) {
 			f2fs_err(sbi,
-- 
2.30.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
