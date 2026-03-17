Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60846FD8741
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 17 Mar 2026 11:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-Id:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=iLpdOkLo7elKpBCDtHgaUPW4jgX38Y3HCYe/2Io3Cag=; b=Hmt1VlojnJNeNpzwqh8qgwxl4U
	LF33E8QPiynryFreIDGUD1cOIbiYuoi8b4tRvDS5h4nXObl/fG9xsDSxABb5mNY+fDU85teLNmWmw
	xBA+V1wzrfVXI2nmJU0p1iHpVEgXVR1YyQI+Pbw2fOSDD8YkdZvs/ylj4mmmH5CZZyYE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w2T4i-00019g-Ok;
	Tue, 17 Mar 2026 11:59:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zzzccc427@gmail.com>) id 1w2T4g-00019Y-T5
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Mar 2026 11:59:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Cq0vJNChMsEMEHTNP5c+O7i5TNPZoynhpBa0bLte5W0=; b=lMEjqjja3USb0OHOyUQ3iB9+Rx
 s1eGQDbQkwrZhXfWxSUppRMT8ihvznBG1jfWm1lyocSu6/gTBJKdH3CYj5wCQbgqacwQfiK+topPJ
 4YTjIWcvObCln+jYVcYasvP4OocoRrDu2CUAKIsQWBvobMIxuWV1DYPfha2AvAh29vtk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Cq0vJNChMsEMEHTNP5c+O7i5TNPZoynhpBa0bLte5W0=; b=Y
 EGOHtfjtM1ypXnAu1gM9gmrRn2CRKTZLoTrNEKHXhYCMCbrpsrxNPiA6INcm7xMuLMMgokSCcZaWi
 fV5DW7iVXURVkzoF24klc1N2sEtaubEm+CLEZFlxL6OVNUTJGowtVyN/Ei0NaA590w+uvc/t47zN7
 SfaXUphqpZGMSxS0=;
Received: from mail-pl1-f180.google.com ([209.85.214.180])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1w2T4g-0004ki-Ai for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Mar 2026 11:59:02 +0000
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2ad617d5b80so40238505ad.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 17 Mar 2026 04:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773748737; x=1774353537; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Cq0vJNChMsEMEHTNP5c+O7i5TNPZoynhpBa0bLte5W0=;
 b=m58Hz6Bqo2TXN3p4skIO7g0/n8yyEOtKj5ynBlP1CHBeHJqjHnf1qdQe+AqsffklK1
 LNurgUkgs0LxTMEcpgo0h9dwpJHFc3boHXO1Xil+Y4bIsNPS1rorNWXEoWQoz54WRK0V
 cX18nXn70XB9hItMp0MMA95WUpeDdxFrCluqGTAIXFnZsXWmB1Cv5KuAi3dFAuvaIdQe
 M1Y/+BwbPOpNFu0pyRZacRcU2Bi9BB5yo0ADOmiYkRCpSbP3iiSRDT2hus8GR2caNarG
 QohRPSzaOerGUCYxsUlaDebfUu0z9FbsP+6/7BT4+oXMQPQnxTkCmHbN/NL4EoIDAYsd
 sNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773748737; x=1774353537;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cq0vJNChMsEMEHTNP5c+O7i5TNPZoynhpBa0bLte5W0=;
 b=MS13J107r3Et6xghaB4ak4Bb6fKxTznvjjXYlTAP7GIVYSoA+lEeaop5DojNK2fWuu
 xkYjRmIX60CvWFULys/hAs3XtHHZzW9Ex7T82PSBtyZE/gFWcxBPhLc0HV9H0pUHAPAT
 jXKQorgC3e/k1KSnkv9pDkyFOlkogixmA84PcgCi46lFPJHcYJRpfZanZaUtvmTxs5Y7
 Tbo+0b7fRahd0tCrdNbFi42ZJWjeOxr3Wdu/7HmrlhK/A3MSwNMNV7/gDYAoIvZE6xNa
 6ehEjJs6e/VaDMwMthnWDwAgAzdu4y6aHE+OrCFctyVcjxPMPakF55KKNruTBHZpRLY0
 yjOg==
X-Gm-Message-State: AOJu0YyClaj/rMuZa/X4bXg+3hzQAj/+jPFL99tHJExjke3J/88ILWgI
 xWmfFiJSeyRP8QhnSPcF52HLGMeurljg1Ihsw0qZKLWeLzdOXnv/Yf3o
X-Gm-Gg: ATEYQzxCTTIdPYi66SFSu289Jod3+uYpZGbOmKSDY0HKOcOIekBAEGyeB1/vNYzD0DH
 RnGnHk1AXjflNJVQEShWZz1T3pNWQkZh8g+gG5x/xsY8DeqAVaKQ/9juWD5EAsDYZx6w6O16f+2
 epqteQseqg+MAeH8XUiL0h1OkQFqKwRzEPRjoO82Uypa0qIjP8YoIj1R4C+354ZEocs8GluOoE2
 3Sl5z8kioQktaOmZFpzUUDnHRzTsIGkQ80cUDTKfqi2E55PMJqhfFgXqCdOlFfxSWvu06ABNljI
 OxsES0g8xp8UN+baN92e0VCvB0Pn7jysBvvxJgnoW9gGUjgdyvrOyEA56g0BJPl7ijvB/TGu+zs
 0MwMJeWG2ynBLAOpbw8F3QOLMMXP0jKrifIQeIcFVFm7hKvc+OpHhgpVp0usKs4ER54Zrnb0g30
 1ISCcuX7X2q2kshhkhrQ==
X-Received: by 2002:a17:902:f68a:b0:2b0:41eb:163c with SMTP id
 d9443c01a7336-2b041eb191emr116688885ad.3.1773748736543; 
 Tue, 17 Mar 2026 04:58:56 -0700 (PDT)
Received: from localhost ([111.228.63.84]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b0537b6567sm78172245ad.58.2026.03.17.04.58.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 04:58:56 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Tue, 17 Mar 2026 19:42:25 +0800
Message-Id: <20260317114225.3017089-1-zzzccc427@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Headers-End: 1w2T4g-0004ki-Ai
Subject: [f2fs-dev] [PATCH] f2fs: add READ_ONCE() for i_blocks in
 f2fs_update_inode()
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
Cc: gality369@gmail.com, zhenghaoran154@gmail.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, baijiaju1990@gmail.com,
 Cen Zhang <zzzccc427@gmail.com>, ziyuzhang201@gmail.com, r33s3n6@gmail.com,
 hanguidong02@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

f2fs_update_inode() reads inode->i_blocks without holding i_lock to
serialize it to the on-disk inode, while concurrent truncate or
allocation paths may modify i_blocks under i_lock.  Since blkcnt_t is
u64, this risks torn reads on 32-bit architectures.

Following the approach in ext4_inode_blocks_set(), add READ_ONCE() to prevent
potential compiler-induced tearing.

Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 fs/f2fs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 078874db918c..73b913dbe02a 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -694,7 +694,7 @@ void f2fs_update_inode(struct inode *inode, struct folio *node_folio)
 	ri->i_uid = cpu_to_le32(i_uid_read(inode));
 	ri->i_gid = cpu_to_le32(i_gid_read(inode));
 	ri->i_links = cpu_to_le32(inode->i_nlink);
-	ri->i_blocks = cpu_to_le64(SECTOR_TO_BLOCK(inode->i_blocks) + 1);
+	ri->i_blocks = cpu_to_le64(SECTOR_TO_BLOCK(READ_ONCE(inode->i_blocks)) + 1);
 
 	if (!f2fs_is_atomic_file(inode) ||
 			is_inode_flag_set(inode, FI_ATOMIC_COMMITTED))
-- 
2.34.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
