Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97DD0C9830E
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 24 Sep 2026 13:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=uLrCcMpbia7gnp7zohHpqoglCmxD64ARgsq4dwFaEPI=; b=nIXld1ZzMLIVAagzBfl3KIcrVd
	h/7RHmfWUSo8orJAWd1LsgLgbj3cUGQFwavKnZD27h8BbDRicUMl+Z2axoNcltCw1NX5I5UrM2waW
	0RCFxF8t81Mus79Om/TI9HILL/28zMfO8byXP7xlBLGdIT/aBXRkymAei8c83oO0Jyq8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x9jeC-0004bV-3B;
	Thu, 24 Sep 2026 13:38:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nsvatoslav515@gmail.com>) id 1x9jeB-0004bL-F0
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 24 Sep 2026 13:38:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3gTj4dxjCy6zhrK/mNMo01nqIzFYfn+n6Nf0sCRFv4c=; b=QXoXd4eIWDFBw9Q4K1Fdq7lgMC
 e1PcF8pjb6KMaQfY8dQrsP/JuqjX1O1uzbHHhsXjYVx4+MCsLEkLWs7p4zx9KDSUr7TCcdxEaB3pI
 aNilnbeJYU78gQlPtEgKqzq5587JjDlcW/totUc2vv2PtNOAWFmmvGOcN6ChlFUUQZ1M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=3gTj4dxjCy6zhrK/mNMo01nqIzFYfn+n6Nf0sCRFv4c=; b=Q
 KijEkmJQdFAKou6TDOZsgeQ1P/Sm3wB0jEM/NmhslaeqYUAtut2YusYnffjXWZcztz22X5Hl/SGRZ
 uobBxCrH9aQei/WXE+lZB6GeP4w4rUhWfG07LM3PRfKOJVaB/F4PVLsAfvk+aYcMOlkzshGiffkFK
 Jew7oSPgSxiZI1QM=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x9jeA-0000kv-SS for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 24 Sep 2026 13:38:00 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-485b1d2874fso816983f8f.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 24 Sep 2026 06:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790257072; x=1790861872; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3gTj4dxjCy6zhrK/mNMo01nqIzFYfn+n6Nf0sCRFv4c=;
 b=Qri45hksJZrCJPo50eIEjx5Zb/apd4KHoy11r7YrR6UJ/BdrvCPSgjJdrQ+vNPQbeT
 TI5U/eVbwf3rWRLwgkoPW9V/C49gbOuiez/qboUCMRUQERt5GgauS/TelVb13h6FpbRg
 hxVZmbIHAKawBWl1m0NyZsCfpqcfecIB4drr+9pW0BINJR9gTJ0WkcTdaMc9eu8Hh7wz
 +HDBHlQa73topyANljr6uw+k8CKPnH+/0/V59jOPznQFFncz/13AvKTVcppNsuaAX0wO
 o3BuFNAuwlnBdh5PHScKPJWi8e9KCb1b7/tZfqHclHtNEyny8PNBleNro6hn3fz37Dmk
 qPJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790257072; x=1790861872;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3gTj4dxjCy6zhrK/mNMo01nqIzFYfn+n6Nf0sCRFv4c=;
 b=xhEgqygUcjJ/rdE4AtZL1DAxZ8EJ9eXHHc7HkA02SV2fEsZi3mS+UzaJ50dlIhUQTZ
 M7KxVneOVVYtQKeO5T9QY4Q8bBY1YlxLzFzlJ0a35HSRuNXvllhponUrWMs55v11hoCE
 RDJh/RaaGAKnoSmRuMqdP2mM0dpF3cPl2lvn/MBXk1B9INyO+yzy6SywfWq3nYJUESZW
 5QveRRbxDH8WdKgLdzn6/DclIVayyTRcD7K1w/3fxkoYcoLVo/c7hJiIOs/SwVDR2aZn
 CV3XGktkYLCtV94kCS8bcGX4RIyaJ2q/SBH4iYVAgWRlLxEd80TNln0EUJsfs/7pQVCK
 UlTw==
X-Gm-Message-State: AFuF++n7Mx6xUqmEV9PhM8oCuRG9lQUre/sfO9PGfvcj8r8A3drGmDsu
 2pOgpHJJtqK5FTtT0bq4YconysQuC75mcojutODV8tosykqznkZHQmms
X-Gm-Gg: AYBFou1CJrpH4oJ0RtTQH3PatRuwDqu0eQHmq6hP1spzn5KkzYTTHwWuRrR/Nn9LOpC
 fVhPdH5Ub0ooZw84xuLRwnv5AxiaBMr0N8TIhiNkubne89ULf2C9pg7yKu8GX1xnev3kUnd1/So
 h7v2BV1zGkCC+GIywRUxdIgq1GYTsgDNfYycPtnFgx41VwnFainZTBdIZAnoSJYCZ1BO+3fTOmP
 0LZCZ3nm7bOiRCs1ENf5XXY0w0yQWZljqUyoX35V8Ue/JsBtej8cyPQHZusHhpwWlC6hoK225XN
 pTzFiX6JKK53rsT6cOxBLTgUnRbJ4wwAREE+3SvPZepsKkZ18cU4Vem8W0Q+ydpj0v+r6cUe+eQ
 LKZEO77XtlY9ntUupNHBSnxQKuzpUc8gI5Hj3kntY/ngkZ1+1BNkfKrKa7WLvlVEKHxtHTU28GY
 SRuCU4ICORX5Z5IC0ES1+o0hkc6VOGeJA/2lA7fP1HJWIhbIVEcXLEPWSkwshb57IvZIp5aIr2E
 nK2Ch1UERXtEJyf
X-Received: by 2002:a05:600c:3513:b0:49e:6836:5386 with SMTP id
 5b1f17b1804b1-49fe66ca6f5mr47506875e9.0.1790257072144; 
 Thu, 24 Sep 2026 06:37:52 -0700 (PDT)
Received: from localhost.localdomain ([94.240.182.136])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe5b9f253sm77377825e9.1.2026.09.24.06.37.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 06:37:51 -0700 (PDT)
From: Svyatoslav Nikolenko <nsvatoslav515@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Thu, 24 Sep 2026 16:37:25 +0300
Message-ID: <20260924133726.2250-1-nsvatoslav515@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
X-Headers-End: 1x9jeA-0000kv-SS
Subject: [f2fs-dev] [PATCH] f2fs: check log_blocksize bounds in
 __f2fs_commit_super
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
Cc: Svyatoslav Nikolenko <nsvatoslav515@gmail.com>,
 linux-kernel@vger.kernel.org,
 syzbot+dfcbc1741488709db4b2@syzkaller.appspotmail.com,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Syzbot reported a shift-out-of-bounds panic in SECTOR_FROM_BLOCK() during
superblock writeback via __f2fs_commit_super().

When mounting a corrupted filesystem image where log_blocksize is set to 0,
f2fs attempts to perform recovery or commit the superblock status.
SECTOR_FROM_BLOCK() relies on F2FS_LOG_SECTORS_PER_BLOCK(sbi), which evaluates
to (sbi->log_blocksize - 9). When log_blocksize is 0, this calculates 0 - 9 = -9,
causing an unsigned underflow (4294967287) and triggering a UBSAN shift
out-of-bounds error when shifting sector addresses.

Fix this by validating sbi->log_blocksize at the top of __f2fs_commit_super()
and returning -EFSCORRUPTED if it is less than 9 (the minimum valid sector shift exponent).

Reported-by: syzbot+dfcbc1741488709db4b2@syzkaller.appspotmail.com
Tested-by: syzbot+dfcbc1741488709db4b2@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=dfcbc1741488709db4b2
Signed-off-by: Svyatoslav Nikolenko <nsvatoslav515@gmail.com>
---
 fs/f2fs/super.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 6a2f09c61dcd..b6b32bcbc126 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -3934,6 +3934,9 @@ static int __f2fs_commit_super(struct f2fs_sb_info *sbi, struct folio *folio,
 	blk_opf_t opf = REQ_OP_WRITE | REQ_SYNC | REQ_PREFLUSH | REQ_FUA;
 	int ret;
 
+	if (unlikely(sbi->log_blocksize < 9))
+		return -EFSCORRUPTED;
+
 	folio_lock(folio);
 	folio_wait_writeback(folio);
 	if (update)
-- 
2.47.3



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
