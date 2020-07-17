Return-Path: <SRS0=CtUu=A4=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64B0C433E8
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 17 Jul 2020 01:53:29 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97E022076D;
	Fri, 17 Jul 2020 01:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.b="IEPZGUDR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="ILmaJWxU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="nFQL7dR0";
	dkim=neutral (0-bit key) header.d=google.com header.i=@google.com header.b="ng8R1/65"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97E022076D
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:References:Mime-Version:Message-Id:
	In-Reply-To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=to95fzJO7SD4NPoyVQ5HV4xEjhhcJ/wxTpC23tuX9TU=; b=IEPZGUDRVLfVGaJbUcSC3PNg3
	DauH1JNpmCAn/tAQ/LyiKbCm7o/ERpG2bqQmXRUi4znstTqIi+IkjjQM9DX4nQVlqOUdAq6mJzX5k
	dyeinRHwNr5qDkOs3NiCrbwbXs24ZmDLYcjPvrP2n0Kh3ler2ZWB2iz/70Fs2CTr82kmY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jwFZ2-0003Sy-JQ; Fri, 17 Jul 2020 01:53:28 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <30AIRXwYKABkHzINzI5DD5A3.1DB@flex--satyat.bounces.google.com>)
 id 1jwFZ1-0003Sp-BD
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 17 Jul 2020 01:53:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:References:
 Mime-Version:Message-Id:In-Reply-To:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ORAQciKgJGVxLPMl88O8FRaS7Y2vfgBBYDIN8L834Cw=; b=ILmaJWxUn9DzU6Umt7j9Mqlzn
 1Ca/SNEd5xCgGdzOACCCrBaVnCqO4BgStAJLaLjZLYFbomKxFa9cte1sSGfqDy8cXQZktYZTAOg2s
 rZalyZ9/kGL1Y1t+gkJxDDERKaA4Y9+/sEmE9edvthn1jaakaaPTrWIYNqHYmDSpA8zXg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:References:Mime-Version:Message-Id:
 In-Reply-To:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ORAQciKgJGVxLPMl88O8FRaS7Y2vfgBBYDIN8L834Cw=; b=nFQL7dR0OVTUB31WITG0SEm5R2
 qrJHGbyDsvFGQvSAPJ93c6aw7L1VM21YUsyzSO37Wb5YZss2ge3YwEfAvoE8cdUTASLkRHFnI90Xp
 bsVjiAROHKs+W1tpJUqPHnQbyi8PtH+V7QgXJcxx2Z2c3CwHbqQSSj7ARkg3n5DiDG9M=;
Received: from mail-oo1-f73.google.com ([209.85.161.73])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1jwFYz-006lig-1r
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 17 Jul 2020 01:53:27 +0000
Received: by mail-oo1-f73.google.com with SMTP id y10so3736278ooj.13
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 16 Jul 2020 18:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=ORAQciKgJGVxLPMl88O8FRaS7Y2vfgBBYDIN8L834Cw=;
 b=ng8R1/65DV2iU+IQ306zEBb/0gZuzKY2wd9E8N5W+UqslArMsttZ5glLKrikl28eKb
 mHq69ANYkDbSrWX4gfqMUWI2ZBqFfFly0rtpiO9z2tckqlbPuAu+WgKmohY8YtajbC7y
 TAkC3td2D69tT+i8RxwKdpD86ImI888MHpVaS3zpZqe2TBh09T3GOUsEhGrYpq7qszO9
 0eL1IJrZbZyK33JvINmsQYzOQns4GWk/EypSIDCE0Bw5rjnxJookR+K0w4fiVIfjkP4l
 48dzxFnzHST1VX+U4ko1hntKzQ14Ezmb2zBJCYDs2eKpTWvdT0fsRQhtyl4OAmHbNGpd
 7XZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=ORAQciKgJGVxLPMl88O8FRaS7Y2vfgBBYDIN8L834Cw=;
 b=j3WkgNqX4TP/g+0DlzYImtfJ7g+IJfsUUsRvO7qHDr0fWjoiPmBVziW6J8u8V5BJlr
 O7ZWZwfjP3ya3WOxve92fMNppYXASWlH5Y8VzxSG8tvpqgtEb/iDYMCxFTnalFtzvk8o
 uzqWbA0SFnsaLAThzNaEd029B/GucbQIpJqHb/yjnMbVfr+1OweM7qfEP3XxSp1jhxYJ
 rMe+QSQMnj4BUu5Vr0Brx65ec4dKh8k+gUG9Rbdt8wWQSlFV84tU8HnFPM+AOumN2Hey
 iU3/SH/SMpSdiIa/OKu8jV+A60pMNaGWxiHThi9lljlE6r+WW1+CbtNHl9PSPOtrCrCJ
 qOBQ==
X-Gm-Message-State: AOAM533txkbEv5fyYKabnoArj6Q/HVZJMQK96xcjJlR6g3nRQJbTLQjk
 +tWFWq4MKcVAjcYsygDhXYvl1P0BkS4=
X-Google-Smtp-Source: ABdhPJypMvXx5XgQi+oxPJJGIhfKX32tGeIjNcFpR4zHf1BJbMQwMi373dkhjOi4KnE/mp1ikT0bXUTweTE=
X-Received: by 2002:a17:90a:2b8f:: with SMTP id
 u15mr7349194pjd.98.1594950352671; 
 Thu, 16 Jul 2020 18:45:52 -0700 (PDT)
Date: Fri, 17 Jul 2020 01:45:38 +0000
In-Reply-To: <20200717014540.71515-1-satyat@google.com>
Message-Id: <20200717014540.71515-6-satyat@google.com>
Mime-Version: 1.0
References: <20200717014540.71515-1-satyat@google.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
To: linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
X-Headers-End: 1jwFYz-006lig-1r
Subject: [f2fs-dev] [PATCH v3 5/7] f2fs: support direct I/O with fscrypt
 using blk-crypto
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
From: Satya Tangirala via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Satya Tangirala <satyat@google.com>
Cc: linux-xfs@vger.kernel.org, Satya Tangirala <satyat@google.com>,
 Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Eric Biggers <ebiggers@google.com>

Wire up f2fs with fscrypt direct I/O support. direct I/O with fscrypt is
only supported through blk-crypto (i.e. CONFIG_BLK_INLINE_ENCRYPTION must
have been enabled, the 'inlinecrypt' mount option must have been specified,
and either hardware inline encryption support must be present or
CONFIG_BLK_INLINE_ENCYRPTION_FALLBACK must have been enabled). Further,
direct I/O on encrypted files is only supported when I/O is aligned
to the filesystem block size (which is *not* necessarily the same as the
block device's block size).

Signed-off-by: Eric Biggers <ebiggers@google.com>
Co-developed-by: Satya Tangirala <satyat@google.com>
Signed-off-by: Satya Tangirala <satyat@google.com>
---
 fs/f2fs/f2fs.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b35a50f4953c..978130b5a195 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4082,7 +4082,11 @@ static inline bool f2fs_force_buffered_io(struct inode *inode,
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	int rw = iov_iter_rw(iter);
 
-	if (f2fs_post_read_required(inode))
+	if (!fscrypt_dio_supported(iocb, iter))
+		return true;
+	if (fsverity_active(inode))
+		return true;
+	if (f2fs_compressed_file(inode))
 		return true;
 	if (f2fs_is_multi_device(sbi))
 		return true;
-- 
2.28.0.rc0.105.gf9edc3c819-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
