Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D28C624CE
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  1 Sep 2026 01:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vuN5n3i96nBKIq7IJ8mBZJZ2JhFDro2c4IL4/4cQ7NU=; b=m+0b6Diu+zZRRj1QmRefyWhBI1
	JITvUpBXP5r1cQsxUWI1NF+/krneday5WYOvxQLe0jTSCmrVI13ioR1qdhkryQisuH4jawp3f8y0e
	8oyISYIFNHoOI2moav6MNybt/Ry07frrtkzz4TynottPh34XUgEsv2HpbsJpF3Fl68kA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x1DBY-0003vg-Cy;
	Tue, 01 Sep 2026 01:21:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhangxp1998@gmail.com>) id 1x1DBX-0003va-Vt
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 01:21:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JTmlGIyIWbMG/g0r7aBMDjsD8OZ6wSBjrj4mI5wQmow=; b=Hu5xztKXqyZ66Tl9el42TmTkm5
 raW6eSDgk39i1CQPWTMLQMfXdLI45rPd8VXo0RKZ1svuavK5WuuBCvA3YSzEoCKGoGUo0I6Bss7C1
 OcF9qnd1QabBzMORrdAzHUoxLAs31JWOvZAEKxrTU3ImjkFZ7RQsHP4fIP09PXo+8b/o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=JTmlGIyIWbMG/g0r7aBMDjsD8OZ6wSBjrj4mI5wQmow=; b=CVTtRBRxHk6TXYdlrg5Gwl/CkX
 E7I8l9+tD/ixEYe2Sk4AyqNzr1bs3Ha4K7U522EzJ6Q5hQYS/JznDqz4qASltFfb5kYiwmgW/ovhp
 05XcFWmeNzux07lJ+I6kVH6f40RxJaw97I+mj28nap1KqaSwL/ZbquJwUceAAr2myxSw=;
Received: from mail-pj1-f44.google.com ([209.85.216.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x1DBV-00076f-0A for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 01:21:09 +0000
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-38511175ad3so4293810a91.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 31 Aug 2026 18:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788225663; x=1788830463; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JTmlGIyIWbMG/g0r7aBMDjsD8OZ6wSBjrj4mI5wQmow=;
 b=aRWqVr/Q8pxAubAXaopWsxbuWq4Eb+5y9vCktMMLkKvZ8SnRBQFozqEWsAvZgG0EKw
 pEzIvYdALrb6ZXE2hVOAyb3AQ+YN4lYK3iJi7BicHCjsdsOiYRyA8oyw9AjJlX28LYA/
 ascvjirhF1gauFxsC6UkeL+J++uRF+Nd+/reVRM2yyPxQfppAbEe4qyfYQEM2oq8zgKU
 hJ2zINDayjPsC9IRexYl06W3RTke/mWc1eORGL7bV+Gq2vw1DGYrcRXjMWqe5IQ2A/yc
 H/G8/gkKA8eEt+7Ktf0ay94gsFEljg8a3obCe8hVfYlNzlfaC15ut0hXPCEBIoWah04B
 iutg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788225663; x=1788830463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JTmlGIyIWbMG/g0r7aBMDjsD8OZ6wSBjrj4mI5wQmow=;
 b=hupSd3xMG1QujNXjY3wDMEu3v3gJjZzadM+/Egq+P1Oc6eelM72DzZi/2hXRhWlGWw
 VxRaq6Zc1fRCOs3zktIxZne2sHq23j36vtd0o/4BrlF7TCrqJYuPZHwfmVw3nuW3+l+C
 nu0IEFCVG6kQxRKJ0xjilid/t6GF7hCVhV2SCjIZX1om+x7J6uCdUDIgvWkcOW0EkXgE
 DhXqZXMxy67oDuDQ0RV4q3CGBEYJvgnoUfLYTb6U0FfpMkju5S0GQXFklQF+jsITNnvt
 pPn7itB1/G+vtwf6BUnQGcxgEBrxS0PaWdRNIXjrYL6y7p4yxgkCqAFNEjwmxgACUxbt
 8wmg==
X-Gm-Message-State: AFuF++mb7DXZN83CyUc0rjpSHeOqCYO76P9+ohqqEgjnxcXMUA5sEVxH
 Fd6MxO87ykiWM4qUmn0NRuaaphXPXL+2awUOA9ZoE1xbui8xPUhDI9gpapBQDsft
X-Gm-Gg: AYBFou12pM2Si4us+BRmbdUJvKUfJuoBIcV3T6ilnzPv6QKcNvZckSus7x25/IQ8M6c
 hXqDz9QZ5/V4CHH0eCTERPYF1elhNWGjpO1O4Ay/jlf03/t5RR8Hif3J8Sxe6GpbvHrm8rUHBRk
 LgfqtwwE1yd1rObhaLsMvz6TXwSLh6D1WZWu0RoXGfLcHoEOb5JzHCsg/Ir/YUFsUVZEA3hEFLU
 /Oenu8UrmqkUl+vmqV6BTo8h2EiKKpNBchyAkeUkxLL3bpqg87lTu+rHpsLgE1rvSGOlhigOsHr
 vBwoaPvd6FZz/ani531/U03Q0ELkj/Hxg3O6HQroNe35YK8jhcy33qVK2+XdofIPM+UYLKH+JmI
 7y6jvr9xNQXEqA9nDgb51rP5657S8F857v008rO0pZzBvf9EJIfU3h8mlwl4/GJRxg72hZfQAR3
 XY8nyagReonbv2JKy8Dl+uKZcjethsNT6sEwLyV0mVQdn13br2SYP1K4O/3Fv+I1QAoQ==
X-Received: by 2002:a17:90b:3c48:b0:398:9bd4:d1a with SMTP id
 98e67ed59e1d1-39907ed3bcdmr6440498a91.25.1788225663180; 
 Mon, 31 Aug 2026 18:21:03 -0700 (PDT)
Received: from [127.0.1.1] ([2601:647:4184:b3f0:91a4:c2d8:1d54:21ad])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3286f9595bbsm38316713eec.14.2026.08.31.18.21.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 18:21:02 -0700 (PDT)
From: Kelvin Zhang <zhangxp1998@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Mon, 31 Aug 2026 18:21:01 -0700
Message-ID: <20260901012101.242104-1-zhangxp1998@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <9134210e-8ce6-4b74-bc25-af024aabeb75@kernel.org>
References: <9134210e-8ce6-4b74-bc25-af024aabeb75@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1x1DBV-00076f-0A
Subject: [f2fs-dev] [PATCH v2] f2fs: avoid underflow when counting free NIDs
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org, stable@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

__count_free_nids() subtracts the retention threshold before checking
whether the cached count exceeds it. The operands are unsigned, so a
smaller cache wraps before the result is assigned to long.

The PAGE_SIZE-derived threshold happens to make this an unsigned long
subtraction, whose wrapped result becomes negative when converted to
long by supported toolchains. Do not rely on operand width or
unsigned-to-signed conversion. Compare values before subtracting.

Fixes: 1b38dc8e74a3 ("f2fs: shrink nat_cache entries")
Fixes: 02110a4fd531 ("f2fs: avoid casted negative value as shrink count")
Cc: stable@kernel.org
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Kelvin Zhang <zhangxp1998@gmail.com>
---
Changes since v1:
- add the Fixes and stable Cc trailers suggested by Chao
- carry Chao's Reviewed-by
- resend as a standalone patch through direct SMTP because the v1 list copy
  was corrupted by mail transport line wrapping

v1: https://lore.kernel.org/linux-f2fs-devel/CAH=xXfG2Hzc-kNAPqEUsTJ4hwrQ-gYEnFrXHGxL7qpYpggkLUQ@mail.gmail.com/
---
 fs/f2fs/shrinker.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/shrinker.c b/fs/f2fs/shrinker.c
index 4f6bf5926de4..1fd0ee4f89a9 100644
--- a/fs/f2fs/shrinker.c
+++ b/fs/f2fs/shrinker.c
@@ -23,9 +23,10 @@ static unsigned long __count_nat_entries(struct f2fs_sb_info *sbi)
 
 static unsigned long __count_free_nids(struct f2fs_sb_info *sbi)
 {
-	long count = NM_I(sbi)->nid_cnt[FREE_NID] - MAX_FREE_NIDS;
+	unsigned long count = NM_I(sbi)->nid_cnt[FREE_NID];
+	unsigned long max = MAX_FREE_NIDS;
 
-	return count > 0 ? count : 0;
+	return count > max ? count - max : 0;
 }
 
 static unsigned long __count_extent_cache(struct f2fs_sb_info *sbi,

base-commit: c966d29e01bbf829f8bb4a39a49811c56cdb49c3
-- 
2.53.0


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
