Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1BD9C27C79
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 18 Jun 2024 00:41:59 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sJMv7-0007Jh-OJ;
	Tue, 18 Jun 2024 00:41:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <3yddwZgYKAHYXlimYhaiiafY.Wig@flex--drosen.bounces.google.com>)
 id 1sJMv3-0007JA-Dj for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 18 Jun 2024 00:41:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:Message-ID:
 Mime-Version:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eeWAwKNyi6aVQ6EN90rM7zyGSNPuFg6n/JEZRLaHcM4=; b=dwZq5u7tPlnSdsGC5U0/C50YD2
 RPa7KcHDxfkyjl4MDyLw2IsPirHvROo4Mo1DlzM6icnF6dpSnXPNagBO8gM0OrZ1S+WDUn2Bmm+mR
 tEgaO0Og/Sb96Vtc5KfapLr0r0qsAJrV4YDKmchIpBoYFVSckMNPxGxfpTQosZuPNKZo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:Message-ID:Mime-Version:Date:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=eeWAwKNyi6aVQ6EN90rM7zyGSNPuFg6n/JEZRLaHcM4=; b=d
 8x3pmXT8oN3iSttNDJkELSddwafQhWMIcU9rORhzwPt+gbUByguPOYYoZUQ2fB2m8CF3A1Dcuhjok
 gNB488u0QaBlMNBaYhqJj6e3HYEehzWSzqOIxGFCp9A9UMDvnsif7l1aG9O4jspFLHaKCeDWjAgg+
 YsmD3uWwvlvyBRzI=;
Received: from mail-yb1-f201.google.com ([209.85.219.201])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1sJMv3-0004z5-5o for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 18 Jun 2024 00:41:52 +0000
Received: by mail-yb1-f201.google.com with SMTP id
 3f1490d57ef6-df771b5e942so8641552276.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 17 Jun 2024 17:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1718671306; x=1719276106;
 darn=lists.sourceforge.net; 
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=eeWAwKNyi6aVQ6EN90rM7zyGSNPuFg6n/JEZRLaHcM4=;
 b=Qv53+kmeYjKIASfny5bcbr6lNXgtGp01stBAqRYam7Uh42z0Q7MDhaV8x3oAKAWE3X
 fvcCDAG3Gcnfc5f6zkZNGvn/l5dGsWzx0vdizdKqrsRPtpqH4/LmH34yv4JXV1lcd4m8
 VKL5GqVwfqx53tKcAcXOEbPEPUOE0mXcrxOxpFzfql5Q5X5wzlv6Em4zUwPMOpfImE0s
 9/64ftWB2clL1ndCzoHL8fr0Fs0ZudHCLx77sjd5ni9VSc/6gnp9atjwXKmNWPts4SDR
 C0QTVOPRf2wbtF32T5SMAHuWdBv+G45oJdeshJ3L0TMv/76R4puC1+pF7NAr1T9jTFBH
 Z3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718671306; x=1719276106;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eeWAwKNyi6aVQ6EN90rM7zyGSNPuFg6n/JEZRLaHcM4=;
 b=aomB2q2hvzR6jWAKj/3YvDplE/l+54dTRdD49ZdCY8OuNYQwmBAYjBU+VVPTSMpCfY
 Ki3uv2r9URYly7Kz3vZrGJyo91GNwqxBVCdfhX3A2N6asTtsMVsbvTaA2N8Pe9WjhhZ8
 rveK2XVqZ64ztOzTxAu7sa6JEpc2eUcaC+lATp3ZhHLR3oLt6J7rzAFWiqra6sZ3DpCL
 a99vAGtDWTOTjs8tLD+iDo4xO6yHghp+ZqhiTuMImefrPXrdxoasGLEp6ElawgUe2Vdg
 01t5YY+TINfHurS5m+4EThaq1s5+ZQ+rtuN1JnNUMQRbTTI6JD5eZr4nCqYcuj1DP3jD
 gw3A==
X-Gm-Message-State: AOJu0YyAnuU227VFS1/4+fQbaeBdsdhnVVNYOY/dkiDKyaHjdzzKPick
 TgmfUMel5z7SVzpoiQszQ/NH+15+f+oSVHL7B557T1zk11zbmaf6mu/A9Dr3dF+4K2aloT8+CZT
 jn7FHnJbnYWm/T091wxkrggCuu/GrDPeKG+tWCiqNXKQwZF4K6OthhNhkhzo2qFN6M4imsS6Psi
 f+Y6LPJeoP0Hc6N3P373ZM/2PObMk4RDFPHJ2OmzJDEX7EvpqGJeezcA==
X-Google-Smtp-Source: AGHT+IGIMdi9RUsyYll/ae5cAdZr8bQjwh6IigoDtp2KK3YoCB0+JuRM1IvlUbfmuRWg0pX5dDohGH0BxHM=
X-Received: from drosen.mtv.corp.google.com
 ([2620:15c:211:201:eab6:28c3:5427:f5bf])
 (user=drosen job=sendgmr) by 2002:a05:6902:114a:b0:dfe:fe5e:990a with SMTP id
 3f1490d57ef6-dff154c42f9mr1096722276.9.1718671305860; Mon, 17 Jun 2024
 17:41:45 -0700 (PDT)
Date: Mon, 17 Jun 2024 17:41:36 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240618004136.1336922-1-drosen@google.com>
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1sJMv3-0004z5-5o
Subject: [f2fs-dev] [PATCH] dump.f2fs: Fix dumping inlined files
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

The code for dumping files was ignoring i_extra_isize, leading to
invalid data for some inlined files after dumping. This swaps inode
dumping to use the common inline_data_addr function.

Signed-off-by: Daniel Rosenberg <drosen@google.com>
---
 fsck/dump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fsck/dump.c b/fsck/dump.c
index 90e3e0e..8d5613e 100644
--- a/fsck/dump.c
+++ b/fsck/dump.c
@@ -479,7 +479,7 @@ static int dump_inode_blk(struct f2fs_sb_info *sbi, u32 nid,
 	if ((node_blk->i.i_inline & F2FS_INLINE_DATA)) {
 		DBG(3, "ino[0x%x] has inline data!\n", nid);
 		/* recover from inline data */
-		dev_write_dump(((unsigned char *)node_blk) + INLINE_DATA_OFFSET,
+		dev_write_dump(inline_data_addr(node_blk),
 						0, MAX_INLINE_DATA(node_blk));
 		ret = -1;
 		goto dump_xattr;

base-commit: c1a97862b05d8a736ad8719939395c61bd71c982
-- 
2.45.2.627.g7a2c4fd464-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
