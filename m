Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E774F606A324
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  2 Nov 2026 19:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=SfaM2xfO;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=UL85e8R3;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=AokZsI5b;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E9+P0O++
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=s5H4OO0hd16GaMG4nePIUApTlPtnFZRcN4aoKoUWm7k=; b=SfaM2xfOtfour0e+Ew5yEmAMzh
	t/HrB7Jx8chvOdVKayZ/E4fI6LPX7B8KMaQEwEqh8AnYZ9EARdEL1Lp9VOU5VtQ9JcDElP0LnYuun
	lgpLB9CBo2nCBDRCvB5SO31IMyAzjek88Nb+PDz9897SMP567lkpA7RJyQ78mmLzjLoI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xNxu2-000000004m7-2VqA;
	Mon, 02 Nov 2026 19:41:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <daeho43@gmail.com>) id 1xNxtk-000000004kL-0fII
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 19:40:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uXk4plWW+OCeCf0/xrqLno6+gljAR6KSsv1QLQj6fLU=; b=UL85e8R3tsZmb71GeGjo6TM2Vq
 mS6sQ+o/orlqtwWSieA//eTmNT1MNB3C5NSZnfxoWU5ZkXghZFbi78QjSW+VVZl/4XWlSrRUp33gl
 Uc09KHxtj32MT31J4duraL4e9CWS1xeCAcEyVic+NYYoft0ZfiIN+IHykgFA7qgcIzXs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uXk4plWW+OCeCf0/xrqLno6+gljAR6KSsv1QLQj6fLU=; b=AokZsI5bzMRhNr/W87vtd9M0FS
 tzbDo9EDr7caGoGUn/UX7Fp2+aq45V+FiSeC6sttX8SMCV6eXSvisA4oUBm1teFmAgVi3cyggyKH9
 7MI/fJJVIfpoosV+flfWrj4GF724jdDvn5K3DekmrEBqhTkBnrcorWhR4kPJASH2OQMw=;
Received: from mail-pj1-f52.google.com ([209.85.216.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNxtc-000000002EE-1hmS
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 19:40:45 +0000
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-3ada8bc2380so1560261a91.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 11:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793648439; x=1794253239; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uXk4plWW+OCeCf0/xrqLno6+gljAR6KSsv1QLQj6fLU=;
 b=E9+P0O++vqRnjPb0RQizUhc0kJx+CAn5gsIyP0Oz6/40goZJkRgqXym5NoR+wnyCsZ
 awoXGeSM1r7p2kcYK4C3h+AGDDMzgSibMTKIrVGZj8s7MdETwi8wlptKOdIgqpuTBlj5
 bhDFWD8GjnwTsBvoi9xOI9tUPKhKdF1ECpgyWkvTxciCPkK9Qd4LOXvQh6JbM8a15Fzl
 U6ONKv0soxosv/Lqyqv+fIJsfAf9Fm4VbBY3xjEOgQkuyqYVXfze2YqntBRpZ6RJ0CPR
 zNAbQ89bSVaCfgLxXH11GouZilNO0EH5ifi9vfR8F6ZH870d70gduHlC4p4PBzPLzpkQ
 VW6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793648439; x=1794253239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uXk4plWW+OCeCf0/xrqLno6+gljAR6KSsv1QLQj6fLU=;
 b=geOuMxp2tOUll1Pp85XIAyDco3QyYvfPKLjQIeZowipbmzrdctpV0zjJlV6dNmhOvG
 JQVBZ9/VhAd5wJUiseAw9qWn4iAFC0pycmFVttBqPKMRJAcgG1nyL0Fc+pJ7EVVxE2J/
 qah9bg/AM+kZh7Stxzp9pn8B5i4eJ5TTbX/+IwPXXfgJiBrAZRsYynWKrxnXt5533Ndz
 Xo0yua+UIXWfulYZmeWxKsnHL+0Jmdn+XgaZya3ZmYto8pk4A8+HRe5QFeMUEBziKgA0
 YhGjGQCs03zNzCbvPFQQNVUc7TlwqsYjlki1MHwARmInQzWSpktzIrRxAVp604ItiXAf
 cRTw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwxSsQ324w65yk9uJQC1Ev1j2N1jfKwJxtMIGgrcU5tXzhMK5jAIN3bpDGh2EExWIJqF5vbC/yMRv+XW7upzCN8@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8M9kK9JedofKzx4Ed6srrHAbsv/yG4HEOgy8lPOxtCwwpJu/5C
 7V2TFHbv6zunO6ckumhUfyTnCQTC1OgNeI48iEXJa4eXZdB9O1MTLcsQ
X-Gm-Gg: AYBFou16iTAB2xETA1PJjyDDsuQRoIjSVEx0HT0PMoCgFOzuRT+0qIPwKoAKR+kNIGH
 xfXNTvQ6ww4Je5GznoYKB8h9ADD5tTCF4lCuuIqtAoLbiBmvzXXIMLeJux/Jl5F1rl/ckR2/TJD
 bPshftHTukgyL+lS1fgl4YgDyOIoEOYkaVYLl9tEVswykt4XoET7mjlAXbVxQvrsmvS6Q80yEct
 /sYgyJVpMlwlkuIov5rMLk72WtdaAHg8MF5LKL6UOuiPv9pXv9SoGe+mXW8brUMd/TWj9Y6iY3T
 0W+8WWCatKqKeHeFo4Qwb20VT6rM69+XMsbUsqDXkcl3l+sOnnneHrP1zDcofVrU/kaH8Vi09kF
 Ga8PWrFKTNh5GAw5DjAWwg97Te2pbJLnKmM4Oz3jPS+g2hLAmG0DO1QpAh2LIwpj69g0Xr8mPOf
 5J3Q1NPM9tHr1PmjBu2nPZf9Y185fMWMnfzPBnsKHCFalGa0ufyXfJETiFqQdhJIBuASp5FiC4E
 EQfTe3EipRPNxRSgjK+uR+r0/BL9gYfLPTf5etx70i1JvBcGMeKVN9nJAzWvFpI8iE9pmCD61Tc
 rAdCOo9s3e09uLfkf7XQoBeCi6VlA34NWX1vOhBFzjHl1rUpQrxjZIWS6S09FTT6WyogHcyJLbe
 8xuo6ZLNtxdy7MKs1r4ZBoV/ihgbMsfNUq0x2hdFpE7g9zA==
X-Received: by 2002:a17:90b:3148:b0:3a8:13d6:f740 with SMTP id
 98e67ed59e1d1-3ae897364c0mr8466891a91.22.1793648438705; 
 Mon, 02 Nov 2026 11:40:38 -0800 (PST)
Received: from f2fs-test.c.googlers.com.com
 (193.67.125.34.bc.googleusercontent.com. [34.125.67.193])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cdb364c48d4sm241826a12.27.2026.11.02.11.40.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 11:40:37 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Mon,  2 Nov 2026 11:39:49 -0800
Message-ID: <20261102193952.3002018-18-daeho43@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
In-Reply-To: <20261102193952.3002018-1-daeho43@gmail.com>
References: <20261102193952.3002018-1-daeho43@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.1 (+)
X-Headers-End: 1xNxtc-000000002EE-1hmS
Subject: [f2fs-dev] [PATCH 17/20] f2fs: support subpage blocks in online
 resize
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Daeho Jeong <daehojeong@google.com>

Resize works in blocks, segments and sections, independent of
PAGE_SIZE, so remove the -EOPNOTSUPP check.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/file.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 91f792cf879f..67ed6be8952f 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4250,9 +4250,6 @@ static int f2fs_ioc_resize_fs(struct file *filp, unsigned long arg)
 	struct f2fs_sb_info *sbi = F2FS_I_SB(file_inode(filp));
 	__u64 block_count;
 
-	if (f2fs_has_subpage_blocks(sbi))
-		return -EOPNOTSUPP;
-
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-- 
2.56.0.317.g454f8302e1-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
