Return-Path: <SRS0=3D5a=OC=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6188C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 12 Sep 2021 01:51:30 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79F7361214
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 12 Sep 2021 01:51:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 79F7361214
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mPEeX-000068-Hi; Sun, 12 Sep 2021 01:51:29 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <fengnanchang@gmail.com>) id 1mPEeV-000061-Qo
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 12 Sep 2021 01:51:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=H3CpivejDV9pcJltUX4SVLNQx2lsoJgXEsms2yzUULY=; b=Yer2VJiWu37ijJpjBFWqD5oqjS
 QiRijOIy8XEXZV10FmcSagxdf4YROzBhyJuSB3clundWTIJ36lvuMuVNlqPgNOUiHXTluo56rE6t4
 XWvvdhKfzZpelTJOq5gibnyD479NRV2CFH0BDGpBsKI2X+QyNHesH5MxxpZcGt1doVgc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=H3CpivejDV9pcJltUX4SVLNQx2lsoJgXEsms2yzUULY=; b=mDa8J1L+rzlTryKf5HfNosAlSb
 SWKEyl5aWq24E6OXM5Tm7YSkaTq/gMg7tTbg4fAjz/Dj6fcZbIsuG+N+Fvny2mPPHtHNhtWHKx4xj
 29QT1UKI1KI7rYcnkOqnUEOmF1aa30anoL2ow6nn5O2mMCRz3vWmcXOayyKLxme+B5GM=;
Received: from mail-pf1-f176.google.com ([209.85.210.176])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.3)
 id 1mPEeS-007bRs-HA
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 12 Sep 2021 01:51:27 +0000
Received: by mail-pf1-f176.google.com with SMTP id j6so5165581pfa.4
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 11 Sep 2021 18:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=H3CpivejDV9pcJltUX4SVLNQx2lsoJgXEsms2yzUULY=;
 b=mRyxDa8oZ1sI2Oa8WYDcU4/DplaO3r15i3yD4R5qlGxXBzcuzy3tM7Z662PXDDTNwl
 T5euDtWD7fXAzGgAyS/eUs9zhMk23+Fffqay8Xr/DzdDjCfTmQ6odta43yKgYdaNqVxM
 Ywc2g57ZVu7t/pPsO4FZbFp8y6qU/84cYPSucQwFe93etlmB+XUF7iiR8EMA0wEKojBI
 q89AlP6749KDltsv+Yu5TEleL4/YrSIrWYWOoVb/zUr67RJV91IuUYPFQmqC1mvaa4+4
 LkjeQlH+zu7pszd9ScytAYgp5TqHrFvJIlQnz+svuh465eb1IY/Z3hinw38MzhoEPz/f
 Qz1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=H3CpivejDV9pcJltUX4SVLNQx2lsoJgXEsms2yzUULY=;
 b=UB0zeSmiQNBgmjAr4gmPV64x058mJ28MjHFcdHI6RdIMzuj5XnaP7UEfOvsOgTsUwh
 SaArjSk5Szy8y2k+Sb8Q5O8vtBrbS+Rn4Smtua6fxvV20zcCFCinFChUmcx3gZdemLoZ
 lEx4Qd+iULI21235Wuh/5lR3hPnH+G0wK7XbSVNr6L2a20t46YhtMECFUEXpKFIoHcx7
 dIMqP+eKgeoVokSZsTlsY9tfMGWMDuS6V/r4VmG7ODm9NEsiJRt5TeqUahZoZsAmB/2p
 dHPI4VgBAkRsvl98VlrUixG9STSwMxsk+w4E1pDVVsCEhqBHeUlzoBmgIH6jkJ2fON7w
 JM3A==
X-Gm-Message-State: AOAM530jeL94FAgiMvL/UH34TFVzRqARf6Gp11Y4kKg0P+nubEPvzxDA
 Y2Lpsza/30pMeeliVf58frM=
X-Google-Smtp-Source: ABdhPJxlMbolSMFlLjHgbA7JnAFT6hd7h+sr14MYsatvx0vcnoYWGaFO3WRYQhnIp+/SEw2Zz3jphw==
X-Received: by 2002:a63:561a:: with SMTP id k26mr4734297pgb.144.1631411479064; 
 Sat, 11 Sep 2021 18:51:19 -0700 (PDT)
Received: from localhost.localdomain (061239141224.ctinets.com.
 [61.239.141.224])
 by smtp.googlemail.com with ESMTPSA id l13sm2638912pji.3.2021.09.11.18.51.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Sep 2021 18:51:18 -0700 (PDT)
From: Fengnan Chang <fengnanchang@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Sun, 12 Sep 2021 09:50:58 +0800
Message-Id: <20210912015058.14063-2-fengnanchang@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210912015058.14063-1-fengnanchang@gmail.com>
References: <20210912015058.14063-1-fengnanchang@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1mPEeS-007bRs-HA
Subject: [f2fs-dev] [PATCH 2/2] f2fs: fix missing inplace count in overwrite
 with direct io
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
Cc: Fengnan Chang <changfengnan@vivo.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Fengnan Chang <changfengnan@vivo.com>

For now, overwrite file with direct io use inplace policy, but
not counted, fix it.

Signed-off-by: Fengnan Chang <changfengnan@vivo.com>
---
 fs/f2fs/data.c | 7 ++++++-
 fs/f2fs/f2fs.h | 7 +++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index c1490b9a1345..b5d488c9f9f9 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1491,6 +1491,9 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 		if (flag == F2FS_GET_BLOCK_DIO)
 			f2fs_wait_on_block_writeback_range(inode,
 						map->m_pblk, map->m_len);
+		if (!f2fs_lfs_mode(sbi) && flag == F2FS_GET_BLOCK_DIO &&
+				map->m_may_create)
+			stat_add_inplace_blocks(sbi, map->m_len, true);
 		goto out;
 	}
 
@@ -1553,7 +1556,9 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 				goto sync_out;
 			blkaddr = dn.data_blkaddr;
 			set_inode_flag(inode, FI_APPEND_WRITE);
-		}
+		} else if (!create && !f2fs_lfs_mode(sbi) && flag == F2FS_GET_BLOCK_DIO &&
+				map->m_may_create)
+			stat_inc_inplace_blocks(sbi, true);
 	} else {
 		if (create) {
 			if (unlikely(f2fs_cp_error(sbi))) {
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 3d4ee444db27..49230115d241 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3792,6 +3792,13 @@ static inline struct f2fs_stat_info *F2FS_STAT(struct f2fs_sb_info *sbi)
 		else								\
 			(atomic_inc(&(sbi)->inplace_count[1]));		\
 	} while (0)
+#define stat_add_inplace_blocks(sbi, count, direct_io)			\
+	do {								\
+		if (direct_io)						\
+			(atomic_add(count, &(sbi)->inplace_count[0]));  \
+		else								\
+			(atomic_add(count, &(sbi)->inplace_count[1]));	\
+	} while (0)
 #define stat_update_max_atomic_write(inode)				\
 	do {								\
 		int cur = F2FS_I_SB(inode)->atomic_files;	\
-- 
2.32.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
