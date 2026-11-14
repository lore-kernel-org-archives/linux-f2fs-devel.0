Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE7D606A330
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 14 Nov 2026 01:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Knq5yOxO;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=GhOPGBZ1;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Hiuzhr7q;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Sqn19WJw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=ozzgoZzkh6nMsGyqEJ8HG8OzzJg651b26t4/gV65KkE=; b=Knq5yOxO6Iwo04lncOdGzVYHBv
	dP7+M7XHRjEOe99yG7uFCmgDPeA7nZHJYzzsaosHryr7k3RSAsZ6o91C3R+Lkm9L3R+vpcd+pXGwr
	iExD5eZ/2t9dgeqxG5t0Jw+2HtKrvmhaQxF7OSy1eQVSFwWnG+dJr7F511flMSDj2MHY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xS2Oq-00000000271-2CnJ;
	Sat, 14 Nov 2026 01:17:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <daeho43@gmail.com>) id 1xS2Op-0000000026v-1gL5
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 01:17:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6UTFVXkWgy98qyxzLDJCgKeEPxYMOKuPd/fVMWkBbdI=; b=GhOPGBZ1+MrTmp14azRSx4EfOf
 V0l42PLmRupi7kZQEjClVCFoqxrnvf2rQPo0IN3dFq9E/Ey/l7o6YGZNae7zYcQabWdM9bTm5EuCh
 w3cvDQ7/ct1LHAp8moM/HCZTGoBPrIvTJXA6HXb5mfd4WgDnICyqNLYuy37ieQS2t/hw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6UTFVXkWgy98qyxzLDJCgKeEPxYMOKuPd/fVMWkBbdI=; b=Hiuzhr7qoMwUMU3auSszoBRjhz
 yvjrMiE24whZj4iymzTaOYXj4xJKsC1p1rEAjQIpP/pGSR62REKhyUZxC4xZf94WqqZIXAzhfSMYz
 zBKVleWXLZXysqGMQU2NmURu578CVaEKl5+Z1cAlcC7Ipf3wrW5YMWP167F9E7Km+AsM=;
Received: from mail-pl1-f174.google.com ([209.85.214.174])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xS2Oo-000000000w7-3Ncx
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 01:17:47 +0000
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2e9e53d011eso19126625ad.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 13 Nov 2026 17:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794619061; x=1795223861; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6UTFVXkWgy98qyxzLDJCgKeEPxYMOKuPd/fVMWkBbdI=;
 b=Sqn19WJwhdx9FH+sefwZ5xslDyuk5I0p03xwHAic2XO2MetcEVxqnAOjsCy85TZ9FY
 x3++L0sKajlneQSu5wkjHtocRCtQ7E2SeVG1dr2G8aVuXbn5PC+sJFtDgZaWWmOAINMz
 hu0M4HVcvuHMRfyhvhwk8JxxbiBhJrXVEagw723hE7SLVuo7HFUVQSFqMXXXVgv+ou2s
 ZQ3ClhF8Ug9iacHYVPc+c0Djtj5hok3UCzX9jLwo4sVN1BUy6lRnb/QgcBvPgCEU8PTU
 Y15kHz0cQrV0AbsdbyYxggM0bOMrcQ8IuTsEae2HQDbs6jsICttnYfuZ4ZhkT1OgDjCK
 Jb0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794619061; x=1795223861;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6UTFVXkWgy98qyxzLDJCgKeEPxYMOKuPd/fVMWkBbdI=;
 b=EmBj/1kKEBDg4ZFPIKPI4l2md5YiRTWxk20ZMScAmR/9PZhCODNwLQE2UlkOlHuLR2
 R2rCPELxJTl0h+cNvQgzJTgwh7k85spSqd5th5AAhcxej/k3rlfAfUBLVakFRBtUvmpG
 HKV0wvdEq2T+9b9306m16incJl58+2+rqKjIlj7Sc9WohuLTzkYmHi2Hp/7qO7j7F/uh
 mV1BifFxw67JtrSn5Fr4a4N3PLQYjaQ92SfOuwJ/3st1P8D1In8hHLKPtZNNcbSjGoZw
 ZWgzGo935DdlMwVfSH510t3DQ/T9AM0tOI1VwiBsEKJrLsYFJPjHEbMg104eO6G6cbi7
 9GpQ==
X-Forwarded-Encrypted: i=1;
 AL+hErF0b+c8w7iyylWKONIZsxyrmpmvj1coDX/KrhadONoaABmAaNLHxgFlzaSbG7HOuNiZ3DxFBsP/80/woI8i3t4W@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+Xm1VKrgya/+YmYbBGSQcbG09zGjeMyDI5eb4l7JewZMRMyBh0
 AVH94NUFNAQ+TfGZcm8i2yjkxgQwTM7B9QpDvLb9+x22Q/1bncWEwO1n
X-Gm-Gg: AYBFou07ATci+9G0jTiVJc6MsQksNh7S4EJ7gqbDSsRqCkLS+HcxAyYAZZAaW25UIwD
 7Lt5OZ/w02LpYEroYxfOyx29stkesmm9ba6O6UBFQZi4LeMHM29Rn/Ft95tRS6Fholtmb6UxCdj
 czrgxAGEDjq1eMGEeNVoxGROEvaQkJqAs7f3Pj+AL+eIvi8AhXRQJmYD0ifWBDQGh8GxZpsQMHh
 yYv+Nod9vMgSox9jS2ovEyKYujSSsIDJNkMsKttg5T2grwU9cKTjTQsuhphTzYZuAde5CBU0YL6
 IYNpPFVlZPhwNCeV/39L6wCBp/Nxw9elZP0Ad6ErimGVVGyg7ZzaKiL/fpxL609rPBTOZZlgGCh
 x6SfPOqLQ9MIvqtbsJ/AV0qS9bpdpstFf4kY+P5Sl3pvM6E3DP1WhsTNp6r7JhmjqJyUUjouTNU
 GsBl1nCiSFPiai/KW0XdSgmtH0TrQ+ufg7QmaR3NnOYFoKNz4/nJut7aBSu2b+205m8+i7QgbMh
 h7J3xM0TQHxKO1JHatnX8VkvsHezSqfEDZcbWxg+dSsF37VGDvD3lsszPOotxs74+5wbxt0IS7q
 KbgLl5NWZkijnDG5KN6wkJCIMJsotyT/1cMErwXfhiUizUaxbNYcPFvnR0WYnX0V5S5lfru2749
 tlyEPPPqoq3StaG6eSN4oOfVTQ0f/mdz8M5471pOeriDhG/M=
X-Received: by 2002:a17:903:41c4:b0:2ed:cab:e977 with SMTP id
 d9443c01a7336-2ee0da966e7mr44417145ad.12.1794619060990; 
 Fri, 13 Nov 2026 17:17:40 -0800 (PST)
Received: from f2fs-test.c.googlers.com.com
 (193.67.125.34.bc.googleusercontent.com. [34.125.67.193])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ee0f4acd77sm16792445ad.3.2026.11.13.17.17.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 17:17:40 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Fri, 13 Nov 2026 17:17:34 -0800
Message-ID: <20261114011734.3806377-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.1 (+)
X-Headers-End: 1xS2Oo-000000000w7-3Ncx
Subject: [f2fs-dev] [PATCH] f2fs: avoid underflow in
 get_available_block_count()
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Daeho Jeong <daehojeong@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Daeho Jeong <daehojeong@google.com>

get_available_block_count() subtracts current_reserved_blocks,
alias_reserved_blocks and root_reserved_blocks from user_block_count
without checking the result. Only unusable_block_count is handled so
that the result does not go below 0.

f2fs_ioc_reserve_dev_alias() checks the free space with the root
reserved blocks allowed when root calls it, so alias_reserved_blocks can
overlap with the root reserved blocks until the reservation is turned
into valid blocks. For example, with

  user_block_count = 1000, root_reserved_blocks = 100, valid blocks = 30

reserving an alias device of 950 blocks passes the check, since
30 + 950 <= 1000, and sets alias_reserved_blocks to 950. Then, for a
user who cannot use the root reserved blocks, the available block count
is 1000 - 950 - 100, which wraps around to a huge value, so the check in
inc_valid_block_count() does not stop such a user until the reservation
is done.

current_reserved_blocks can make it wrap in the same way, for root as
well, when reserved_blocks is written through sysfs in the meantime,
since it is set without considering alias_reserved_blocks.

Sum up all the reservations and return 0 if they do not fit in
user_block_count, as was done for unusable_block_count only.

Fixes: eae3faf210bd ("f2fs: support dynamic reserve/release for device aliasing")
Cc: stable@vger.kernel.org
Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
This was discussed in the review of "[PATCH v2] f2fs: reserve space to be
shrunk during resize_fs" [1]. v3 of that patch is sent separately on top
of this one.

[1] https://lore.kernel.org/linux-f2fs-devel/20261022165526.1539629-1-daeho43@gmail.com/

 fs/f2fs/f2fs.h | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 50a5f845176d..59bc3c2fb70a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2710,23 +2710,20 @@ static inline bool __allow_reserved_root(struct f2fs_sb_info *sbi,
 static inline unsigned int get_available_block_count(struct f2fs_sb_info *sbi,
 						struct inode *inode, bool cap)
 {
-	block_t avail_user_block_count;
-
-	avail_user_block_count = sbi->user_block_count -
-					sbi->current_reserved_blocks -
+	u64 reserved = (u64)sbi->current_reserved_blocks +
 					sbi->alias_reserved_blocks;
 
 	if (test_opt(sbi, RESERVE_ROOT) && !__allow_reserved_root(sbi, inode, cap))
-		avail_user_block_count -= F2FS_OPTION(sbi).root_reserved_blocks;
+		reserved += F2FS_OPTION(sbi).root_reserved_blocks;
 
-	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
-		if (avail_user_block_count > sbi->unusable_block_count)
-			avail_user_block_count -= sbi->unusable_block_count;
-		else
-			avail_user_block_count = 0;
-	}
+	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
+		reserved += sbi->unusable_block_count;
+
+	/* the reservations can overlap each other, so do not wrap around */
+	if (unlikely(reserved >= sbi->user_block_count))
+		return 0;
 
-	return avail_user_block_count;
+	return sbi->user_block_count - reserved;
 }
 
 static inline void f2fs_i_blocks_write(struct inode *, block_t, bool, bool);

base-commit: b9d7379d10d43386b59082da8c9a0b111e054781
-- 
2.56.0.611.g1030f0b940-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
