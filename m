Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D49606A335
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 16 Nov 2026 04:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=EqlCKp9V;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Q8Br65YL;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=DIj+gwT8;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wYsi+Jr9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=cOryQI3PsDxN5eBBiHtAJZtBeC6DosUjXKh0pbKlsoI=; b=EqlCKp9V97pJDp13S9hz0NE7ao
	WRvdTMB6Ae9qc5LnzsRNW3lVCSZ8Bx1Z5+F+olqfYH23t9OOjXC2GLzYjg4LB+OpDGQa84t3Ac1BI
	9s8t2o4mJsFxxSssUZX6v8R+1yg9iUDReBlzqJ0ERzy1IFHtJ34hfuUcW3Ktt0j5sRxo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xSo2H-000000007x0-1u1Z;
	Mon, 16 Nov 2026 04:09:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <daeho43@gmail.com>) id 1xSo2G-000000007wo-1oYU
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 04:09:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sKcclmgJVhnLMVPLneFBpTL8LFfEdvb8QzwcAhBl0MQ=; b=Q8Br65YLx3N0xAbF/AmWl++oOA
 sA5KUXRXjcKAln3p3yl32X6REKSMHBUb+qi1l46aM+xi0wo5lsNfMTKD00Pt+f6+x21k208Emnq/V
 q5Odj+r5Jpa3DWKysd9HJ5JQ0OU5hAlbV+JSpMiZHxYL9XKEi14L+rNEniHgI6QJClJk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sKcclmgJVhnLMVPLneFBpTL8LFfEdvb8QzwcAhBl0MQ=; b=DIj+gwT8dkc4YzCPyamXVrKtC8
 nCJKpcNrCj0K51+DShQTSCQpXj0IP+MPGI4+KW0nyDCbOxm1B4rGavtHakzEXiVpilvrRkyUFKQzd
 5HeHGQ3QH6co0MmeKuF6xuI/hn0H5ECJUtesbcbIab1dttghDDoHKbN1OjjTsKomW5tA=;
Received: from mail-pj1-f47.google.com ([209.85.216.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSo2G-000000007d0-07kZ
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 04:09:40 +0000
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-3ac9f49b984so1528476a91.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 15 Nov 2026 20:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794802174; x=1795406974; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sKcclmgJVhnLMVPLneFBpTL8LFfEdvb8QzwcAhBl0MQ=;
 b=wYsi+Jr9k9FM/TeyE5Lo7dYxZ/MeGcsj1e2yv35OZTuHBYsqtmaRRqBhs246XJsGpH
 +nS3Ps+97VdY1xSThXuudI9soQuf3CDbDg5lRNx3k+9DHbYOjnPcb9u9c5A8bURRSAc9
 amhH0MXFUrYtFKubFIUYvwFmkjIhQe7NbNc7g4q/KvJFFrDWlm1TEtW9Ur4Ozm7CZOzP
 LbH4EF1buV+kq2rJRLmkNkUAfxzmvq6OO9hcjEsPbLj8WOwJJLCNdNrfdqX9DWr/gPmW
 Gfz2gxP9zXjVZUtRfTpIUu6YcNL252s3vALiRxMtVwnYF0W3aQz4nuunzYCxVr73Brlf
 nSNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794802174; x=1795406974;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sKcclmgJVhnLMVPLneFBpTL8LFfEdvb8QzwcAhBl0MQ=;
 b=Ns+cnjTenUSFNDro6wYP7WQwPPkgfN0buhUkgoDEGp2MSkrkvI7LRJFfihZWVCm5QS
 mDlsE23vG3PkZxbLFZFhpmmLHUqSilT06E5IK2qKFMFT7ruM7tTOyG+NSX4iLKBA9mow
 LSKfx92DBpIiuRdMEY2xRsGeHKMAi3GjCJRFn+IW/0pyI5kc3AdJfuCG41GchbbweRiG
 NwAg2R15cJP0RjxVyWQhqt/av0d3NkWMpasAwz/FA1NjbEX89UzRrqsg8qTBbdVdEQpt
 q5AzFrFhBHL7keweZL0VnN98dUs+8ZSKGzUaRgTU2D1CYzkHXIobiPv+ZNOX/iiaEDE5
 9BPA==
X-Forwarded-Encrypted: i=1;
 AL+hErFvLvCYVyaD6cY/eykngQZu/aiAl9uKy6vLB/mmdcwDJrKTZp3mXqCcY1RyLUUa9CjMWu1OhIF9BYq1cbHXZAqi@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9+Kq2INElpad9szWfu7+cOZVGpRk/VsaTf6FdPJIPQ+9/P48Dv
 gvhuw2kFm8aaMPa2WmVCeM4GIucHj08iujMJdvdia7rk1H7T2u9FvqjMLdTSBA==
X-Gm-Gg: AYBFou3cSID2vYfvTkw2Xlb6mqd+AAHlAkeP72t07zbUSVa/bkHZUjlFKHmqVQuGMlP
 cpp5D9Uu+drxmxlcAp45gCzC2Ep4Gaml1SIiYj6RgqjJjOqq5REIu8QtiujKtoUdVNTv7l7zFmW
 kXaXnExnB4BR6kcDtQ7Arl51s1anPtnldrz4ZlXiHZpwkP3zp72BJYDfUs3WEyLtC/Gx30cP/p/
 Aw1i64vjk2xz/TSVqPigaKUloFdCaCwgH28T/FdkzCep7TLTGlxpqkn5sFTLDjZBuNIKlQIb8+J
 aExeclw14TefYBTdT5ijZct3XWXw3gNci2Jszp7QbbWckQ1tBirkaTHS0grabQPt/uMWuz2o7J3
 teckbCvy0SA6KYf4t+40Ld4/tHlZPI8QAqvqcIpEjJflz6ndeLKcOyQP3TZV20RVob6BsNZC5Qf
 6wOHCoi+awF1bxNXsjtVzHpqMXDV1nryAfRcLyVH5zUGWtCWV07DbZq2Kp49W1f9re/7+HhIltW
 Qj/fWhzC/j08Si23ARzihYIXCZMCKUOcCEjF9tHHKfIeGgVs1ppOH6TDsaMmjFkQS1GC0sDA6wF
 Jb3pUBJWQz3/Mh6EHC1xMDF6/Yl0JDx61vYXUuzdRNq+CY+taLpUbNNXLsiSzJ48iscsUr1zP17
 C1xFdKfQmgkgNpX+qtIubqkf2ofA31/uDtBGl+X9Mt0zdsF9g2xmqg4iH/ojywSxAbYan
X-Received: by 2002:a17:90b:4ec5:b0:3b1:6689:a016 with SMTP id
 98e67ed59e1d1-3b1b0b8f9cfmr5536642a91.16.1794802174329; 
 Sun, 15 Nov 2026 20:09:34 -0800 (PST)
Received: from f2fs-test.c.googlers.com.com
 (193.67.125.34.bc.googleusercontent.com. [34.125.67.193])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1b3f09b92sm7191989a91.4.2026.11.15.20.09.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 20:09:33 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Sun, 15 Nov 2026 20:08:48 -0800
Message-ID: <20261116040851.2849696-18-daeho43@gmail.com>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
In-Reply-To: <20261116040851.2849696-1-daeho43@gmail.com>
References: <20261116040851.2849696-1-daeho43@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.1 (+)
X-Headers-End: 1xSo2G-000000007d0-07kZ
Subject: [f2fs-dev] [PATCH v2 17/20] f2fs: support subpage blocks in online
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
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
index d6304b705e06..64c91827a5f4 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4325,9 +4325,6 @@ static int f2fs_ioc_resize_fs(struct file *filp, unsigned long arg)
 	struct f2fs_sb_info *sbi = F2FS_I_SB(file_inode(filp));
 	__u64 block_count;
 
-	if (f2fs_has_subpage_blocks(sbi))
-		return -EOPNOTSUPP;
-
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-- 
2.56.0.611.g1030f0b940-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
