Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F85CC6B1D
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 14 Oct 2026 16:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+V/6lg+gbve0POkWSSUAJRoDYQB+MNEC8F89ZimSkJw=; b=Uus7qvWr0qYLGX08o92RLnHr10
	8IiZoQghWonko5g94QT7EBOj5Da/LcG8RpL1mJGt9JnEz+DNCRkMyUlmkThbXnjpH6jrtSzum5HOS
	FNSwyel/Awe+vruTK8GEz4CaRsw5BBHql/pczQ5LYtHSagsSMYNIqLke0q0m0DfliT60=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xH1jA-0004K5-90;
	Wed, 14 Oct 2026 16:21:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xH1j5-0004Il-9N
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 16:21:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7V18tfsYXcjCvNOL3n2Er8gFphu9vTX401aeCsw4YqE=; b=kIm4teOluibnAsQIuoVX0eaItR
 udViBl8FxhE0Or9bDgRoPIKo076Z8imKueWpEjxNMuWabdtopz63RktDgv2tFVEULh7IbVyOMocPg
 wTa1T22OMrI2rLgvHIVKwTzdtj8JX6EfNM5Vu7uo6xnIKkev7BULgykVj03SKEbZYH94=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=7V18tfsYXcjCvNOL3n2Er8gFphu9vTX401aeCsw4YqE=; b=LW/pQCtA5RSfvNCylEyiRnbK24
 qB5QzGk5hJQbLNiHpKlixSYYYJV03s00NB0XqWEtElM78oxwS5EkTfdG722qdmigc3C8zTWHwEt8x
 Cbs+aLHYDQWNMPVZM4ORH48uUzrSTjA5xYaVQA2luctUX/Z/yFa5Hf3e5E+VT4EjGSoI=;
Received: from mail-pl1-f195.google.com ([209.85.214.195])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xH1iZ-0003nY-Al for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 16:20:40 +0000
Received: by mail-pl1-f195.google.com with SMTP id
 d9443c01a7336-2db710396ffso35294885ad.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 14 Oct 2026 09:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791994834; x=1792599634; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7V18tfsYXcjCvNOL3n2Er8gFphu9vTX401aeCsw4YqE=;
 b=LATZvpczTkjHXXj6/GV1aAI/p+j43uiY1HhsjbHlbMf/CUhnhZHpMfoho42tUCeXue
 qL2SryjX2qUFx2t+yfAIY4Ef4ZbH+U5I88dAxy3fg5Kv6ug2gbut3a/bEHx5VN44Z6Xu
 rzGGmNhJDs/Qx1RH3LzHNaA/9Sy9RHtA4crwyr/Qi7UV+m0zGx7CTulaVvTf8c/rMNcF
 pzL5JgRAVC4RoYeIUL2yyPrPTSEPVi9lRfYsScppFXZ6yeuQ0BM9omorynS3ZjUpWJ3N
 /+mX/2XBnMtRF5rPhee1KvgzCifrbmQX2/x9VAJDg2BOjeVyZUYA+C6m0eCR5/vTBAwW
 2FUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791994834; x=1792599634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7V18tfsYXcjCvNOL3n2Er8gFphu9vTX401aeCsw4YqE=;
 b=fUb66szD7sPsokLMwqdjxtcsv1NP6km71XRMJO7vSeiPvDlcOk13uH6ChIwlQqk9by
 XEluebm8rPwinFp8x84XwKCi2k9HPTzleITLugdR9i8l6ux+RVVpNamhZsXHRteYYvMH
 ZKlirm7f2HdSMjiVm6dQ8fo4LFyb4r/MAIEEXXvclmFrtgoxDpIUwWteDOj3ieDhc7Wu
 oHNF+0pyJ/Fp+9+vCyukDXEFDfclnl/Km/RsiaeFmz51sTv6lARi3mNIR3w/Z2WeVbt2
 7dSQ3XgKMjPEGVH2GMEnofL+kygW6tReCH2w88hvD3QPICxrRlhxqOtic2FiE8SJ3RWJ
 Vl8g==
X-Gm-Message-State: AFq9FYJaFxrEgF7qOK/obzWoePNGrS7uOgf9wmROGtJ+cK+NWf9JVuii
 K3tKu59i0x7RZW253MMSOrD4CFoE9jHC8j+tuYCShCbCVBtq6iBG9/X2PfCZYkPaRBo=
X-Gm-Gg: AYBFou3fX+7PS74nkh7qefecbuzHbFnN8oqvmJYF6k6mEah5LAFih3B8P8HO9H/jpLi
 0DrTobcp2+DEeP4LdBzfcOOHD9FKdF0LwhmJ5eVfBoVl5LEuujxAabo6v5IU079DvI8SrBz5iq8
 tPIc/FCqOmOWivZId7Np3/KbwhOzrKXbaUuM+LSKqhUxMiBIxqkxOadpd1f+ojKlXIYoLEENfNz
 ZcmLYNP8dRNgG2cmialHHeo8YEN8qkoUUqQDe33Ts57cdFqTSKASeAbvcq64XvZYIGtq+CoDHqf
 x3Kzs6zcs4em5ZWlWfxRa0P9I9DPFCa6rBg8AHRWnBnMtAKuuNNcUAGGI7l/7z4LsdoPKtA0xZa
 DokVsZ8SemBNJlJLFjwH17KWEDqj3kQbpYUfbhue9Xhmy1sdr6Yn2WujGNlaG6ugO+Zrclohorl
 dtwqjOFtwrovlvrUr+gWHgWeESRu7UssvegOGv9H06lvlxRmcQa8h+KDycfSraezZMSIR9YjpK/
 enJIu/Bve8kbL/3yFuiB3QnhXjIgeSDGT6COg==
X-Received: by 2002:a17:903:26cf:b0:2dd:86a3:232d with SMTP id
 d9443c01a7336-2e8404bcd1emr109659955ad.8.1791994833582; 
 Wed, 14 Oct 2026 09:20:33 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e84219e525sm73402515ad.16.2026.10.14.09.20.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 09:20:33 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
X-Google-Original-From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Thu, 15 Oct 2026 00:20:29 +0800
Message-ID: <20261014162030.3834216-1-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014064445.2835813-9-zhaonanzhe@xiaomi.com>
References: <20261014064445.2835813-9-zhaonanzhe@xiaomi.com>
MIME-Version: 1.0
X-Headers-End: 1xH1iZ-0003nY-Al
Subject: Re: [f2fs-dev] [PATCH v5 08/16] f2fs: make GC migration large-folio
 aware
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Sashiko says:
> UAF on folio->private in f2fs_ffs_test_blk_uptodate due to lockless access.
> f2fs_find_data_folio() retrieves an unlocked folio from the page cache using
> f2fs_filemap_get_folio(..., FGP_ACCESSED, 0) [...] and passes this unlocked folio to
> f2fs_ffs_test_blk_uptodate [...].  Concurrently another thread can call
> f2fs_invalidate_folio() -> ffs_detach_free() [...], resulting in a Use-After-Free.

Changes:
@@ -1701,7 +1718,7 @@ struct folio *f2fs_find_data_folio(struct inode *inode, pgoff_t index,
 	folio = f2fs_filemap_get_folio(mapping, index, FGP_ACCESSED, 0);
 	if (IS_ERR(folio))
 		goto read;
-	if (f2fs_ffs_test_blk_uptodate(folio, index))
+	if (folio_test_uptodate(folio))
 		return folio;
 	f2fs_folio_put(folio, false);
 

@@ -1710,11 +1727,11 @@ struct folio *f2fs_find_data_folio(struct inode *inode, pgoff_t index,
 	if (IS_ERR(folio))
 		return folio;
 
-	if (f2fs_ffs_test_blk_uptodate(folio, index))
+	if (folio_test_uptodate(folio))
 		return folio;
 
 	folio_wait_locked(folio);
-	if (unlikely(!f2fs_ffs_test_blk_uptodate(folio, index))) {
+	if (unlikely(!folio_test_uptodate(folio))) {
 		f2fs_folio_put(folio, false);
 		return ERR_PTR(-EIO);
 	}

v5 restores `folio_test_uptodate()` in `f2fs_find_data_folio()`, leaving the function unchanged. 
Because this function is only used in dentry call paths and directories only use order-0 folios.

Sashiko: https://sashiko.dev/#/patchset/20261013115621.968742-1-nzzhao.sigma%40gmail.com

Thanks,
Nanzhe Zhao


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
