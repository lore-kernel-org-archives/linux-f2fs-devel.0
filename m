Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AAF8C001B0
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 16 Aug 2023 01:45:14 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qW5ay-0007rX-Li;
	Wed, 16 Aug 2023 01:45:13 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <37iLcZAYKANE0EBF1A3BB381.zB9@flex--drosen.bounces.google.com>)
 id 1qW5ax-0007rR-KV for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 16 Aug 2023 01:45:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:Message-ID:
 References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EtokK/S0JdydvYkGO4D4dn6PL0VDx3I2PilqfFBiRjU=; b=gPkEkAStaOKcHlkArooNaGxz6m
 BkNlcJQAOMR/azL1u8nV0XvPGIs1FIC6/argX7kenkq981hDNGR4DXmWo54r2W08/WTFKx/bXXTDV
 ZjaTxmkXR5TQ06epv0vHfQdEbfv52vyFaTougVk5Kn7n0vq9+r0p/QXzp+HR5fYLjlOc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:Message-ID:References:Mime-Version:
 In-Reply-To:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=EtokK/S0JdydvYkGO4D4dn6PL0VDx3I2PilqfFBiRjU=; b=k0so4gM3F9kKmdMah79jnIU8Qy
 o3J/YXCZRmprSfew2RrmIfySoVJ4ZXZ5nwSyZGba0KqM1M0Mb/1KppwkR9RhZCpKvWXsD1yYh2fpp
 pO3hAHm2hUgysb0pPT+C7gY8q6k4p+0AaOekoSCdJyzhdeo8xCjUmcYFMIPdHDU3bqCY=;
Received: from mail-yw1-f201.google.com ([209.85.128.201])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1qW5ay-006iEv-3X for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 16 Aug 2023 01:45:12 +0000
Received: by mail-yw1-f201.google.com with SMTP id
 00721157ae682-58c4d30c349so23436437b3.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 15 Aug 2023 18:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1692150306; x=1692755106;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=EtokK/S0JdydvYkGO4D4dn6PL0VDx3I2PilqfFBiRjU=;
 b=6x7srC3tM5DZrrk/i/hyQRMxY/pnLHc06l8yLb2KkzJBmYE0+/A+Par/1BmUBRleEF
 4pg54Ypj5FYh0SHCwHiaHwQ1VCR4MrHBYIuKUyy1F2ZU2xddO0wicnRxIgqmo8b+9sgQ
 hMDcrK45LHGCumHpIf2Ty285ozg9wk4LS8JlV29EGcXg4oSBybaS7jWTu/sVHztWnbBy
 9Ukq70sTT1Cbau2heVS3mt10CzNeqwYZfTUBA7AJqwF0B6N6312BubN14NPd0DTP/Z5m
 QL8cGLQkoqTb1035MvsGQd1kAqqW/d0F6KmzoGm38h2XWSWYDl63np93+MhJ3ryRRY3B
 V1Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692150306; x=1692755106;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EtokK/S0JdydvYkGO4D4dn6PL0VDx3I2PilqfFBiRjU=;
 b=c24c3I0pioBD4NxSWoLLreSqAh5m9FK6Dxk3BPxtO+yHuhIeneAF4kAJznxcM/mWCf
 yUE50GD3pXmq/V2LYmSQSAyVY5IMkE7X1WX/a9mA9bGuLQAN+cLBweQnWDosnhUfOwUc
 a/tRTTCEKkLDkjhbFNUdXOmZZyzNJjG4tVGHtfgpnZRh/TrVDBBZC1rta4bRiIHsKwi3
 6MkJItacGk8UCUfGsqeMG0glV7wTAhb/ULUVrTXxeUtgEGREYXunBrx3ZqWcnYI0268s
 6E1m3SuvEkjFFFq0b9fvQuADHR2/WCE6jfHPtE3akvog4/d6eu0LrkX/oqsOpK2d4KYs
 MiHw==
X-Gm-Message-State: AOJu0YxxZBd5YrNoD2Fw44m/j96qN1cQR9YKV2eE7yVGOElFPlzxdrGu
 e5YRpPiQCtntcOjir1URr8DkXsifSLdRVajzEK/KZFfrVKhYkHAP6nknxobcdaKMKmzFnGwsEFl
 J+DipFnjMyBuZYzQPkZwuEK0KnpF2GIXobX6lMkJRhTbZy/QbMcoBe4hVg3U9KOMmrPwE6Fxmmk
 XyE1fDFrU=
X-Google-Smtp-Source: AGHT+IHtVp52aojaLVtqsEIM5SrI6ZlcQAM7/pFgr/ZT6cqeUx1hwc74hOqkdh79OKO+tfluCLvB5RJMt0g=
X-Received: from drosen.mtv.corp.google.com
 ([2620:15c:211:201:19fa:33cd:f272:37ec])
 (user=drosen job=sendgmr) by 2002:a05:690c:731:b0:586:4eae:b943 with SMTP id
 bt17-20020a05690c073100b005864eaeb943mr3656ywb.8.1692148462518; Tue, 15 Aug
 2023 18:14:22 -0700 (PDT)
Date: Tue, 15 Aug 2023 18:13:56 -0700
In-Reply-To: <20230816011359.1964484-1-drosen@google.com>
Mime-Version: 1.0
References: <20230816011359.1964484-1-drosen@google.com>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <20230816011359.1964484-5-drosen@google.com>
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1qW5ay-006iEv-3X
Subject: [f2fs-dev] [PATCH 4/7] f2fs-tools: Refactor SIT/NAT block structs
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, kernel-team@android.com,
 Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This converts f2fs_nat_block and f2fs_sit_block to be variable length
arrays. This does not change the way they are accessed, but removes a
misleading statment that these sizes are fixed, as opposed to deriving
from F2FS_BLKSIZE

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 include/f2fs_fs.h | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 13a1c14..b2d479f 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -1119,11 +1119,9 @@ struct f2fs_nat_entry {
 static_assert(sizeof(struct f2fs_nat_entry) == 9, "");
 
 struct f2fs_nat_block {
-	struct f2fs_nat_entry entries[NAT_ENTRY_PER_BLOCK];
+	struct f2fs_nat_entry entries[0]; /* NAT_ENTRY_PER_BLOCK */
 };
 
-static_assert(sizeof(struct f2fs_nat_block) == F2FS_BLKSIZE - (F2FS_BLKSIZE % 9), "");
-
 /*
  * For SIT entries
  *
@@ -1169,12 +1167,14 @@ struct f2fs_sit_entry {
 
 static_assert(sizeof(struct f2fs_sit_entry) == 74, "");
 
+/*
+ * On disk layout is:
+ * struct f2fs_sit_entry entries[SIT_ENTRY_PER_BLOCK];
+ */
 struct f2fs_sit_block {
-	struct f2fs_sit_entry entries[SIT_ENTRY_PER_BLOCK];
+	struct f2fs_sit_entry entries[0];
 };
 
-static_assert(sizeof(struct f2fs_sit_block) == F2FS_BLKSIZE - (F2FS_BLKSIZE % 74), "");
-
 /*
  * For segment summary
  *
@@ -1995,6 +1995,14 @@ static inline void check_block_struct_sizes(void)
 
 	/* Check Indirect Block Size */
 	assert(NIDS_PER_BLOCK * sizeof(__le32) + sizeof(struct node_footer) == F2FS_BLKSIZE);
+
+	/* Check NAT Block Size */
+	assert((NAT_ENTRY_PER_BLOCK + 1) * sizeof(struct f2fs_nat_entry) > F2FS_BLKSIZE);
+	assert(NAT_ENTRY_PER_BLOCK * sizeof(struct f2fs_nat_entry) <= F2FS_BLKSIZE);
+
+	/* Check SIT Block Size */
+	assert((SIT_ENTRY_PER_BLOCK + 1) * sizeof(struct f2fs_nat_entry) > F2FS_BLKSIZE);
+	assert(SIT_ENTRY_PER_BLOCK * sizeof(struct f2fs_sit_entry) <= F2FS_BLKSIZE);
 }
 
 #endif	/*__F2FS_FS_H */
-- 
2.41.0.694.ge786442a9b-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
