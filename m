Return-Path: <SRS0=sdIt=BD=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5FAC433E1
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 24 Jul 2020 12:40:35 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5D132074B;
	Fri, 24 Jul 2020 12:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.b="UkSpSe5R";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="XSzxpz/x";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="W8MHzJVc";
	dkim=neutral (0-bit key) header.d=google.com header.i=@google.com header.b="kiMq1ZWt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5D132074B
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:References:Mime-Version:Message-Id:
	In-Reply-To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=gp785tBYb1FNsQIBZ6rfiIDj5KgGfRjQwJHOqbOU8xs=; b=UkSpSe5RuFQb3op5VRq+pC5Se
	N0vP1Abq7jP9Ja9XGe9ijCOwBD7JVT7XOqmzSuFtp2eoSbTvKQBuOHPmDHT8sr+LEBzkMXLoeVZo5
	mY0Qpbd3PoqwKrgMHPeu9bvcmlUQnQq0o073Fs0/f0Aj6uasEqAv1U52HVbqR+OjYxhWQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jyx06-0006DU-EJ; Fri, 24 Jul 2020 12:40:34 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <3D9AaXwYKABoI0JO0J6EE6B4.2EC@flex--satyat.bounces.google.com>)
 id 1jyx05-0006DJ-FH
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 24 Jul 2020 12:40:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:References:
 Mime-Version:Message-Id:In-Reply-To:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=U1mjdiTf1REytCgM0qXLRwHi12+4iLhjMHz6o0dObf4=; b=XSzxpz/x7Blgl+ntWDF0Zf5jK
 eZT+E+sTXPNsRun0lkdN1dIC2Si43tvUOMRfXhNqLpS/Nv0tTS3UEOOdffQiAsUUjGyffzvkt6p9Q
 PHFUzrGESY1e787o7kVaDXo+K39HbLl+38ayOhoysrGbzh3iFRGOhe9nvNuQg+86gG0G0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:References:Mime-Version:Message-Id:
 In-Reply-To:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=U1mjdiTf1REytCgM0qXLRwHi12+4iLhjMHz6o0dObf4=; b=W8MHzJVczpDLTL/NksP9AHUr7Y
 H+sSdT5gnJe+IsyUparuWO02KZnPaeCR3oYU/GrGNUfOiGrMvQYdqH+o3yqBrz4HT8pMoEme9fjvM
 zfManFo/SPdjT1fAcecL63KOFvOPq0Fwp8o59+jdeSqcTIiYTfWTc/hke4ZcWw+9jLas=;
Received: from mail-pl1-f202.google.com ([209.85.214.202])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1jyx03-001Nwo-UF
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 24 Jul 2020 12:40:33 +0000
Received: by mail-pl1-f202.google.com with SMTP id y24so5348088plp.18
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 24 Jul 2020 05:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=U1mjdiTf1REytCgM0qXLRwHi12+4iLhjMHz6o0dObf4=;
 b=kiMq1ZWtQnJd4reX4VWrcLsQOtCggJ6Lx8/zqeNQSzQ7hT54ehmC/vMQjFsmcj5Bzl
 vfX6LCyxcL40ZX02qaEmRhcqWquQZcpcm14ND8JtsyogdqAL+HsczyPTJ/86YKvMEITC
 a+14IVbSsKlMoJEklV7JAH9lru+zgeEFcHQouasVGEZpC36HAZ0A8fXzWaPHdHwwh531
 3sgi8AC8myUTqxXOiGCGooXwGHlrL4xx7SKojIoIGoqgllfhRf7ZT072nwliYBJnNjsH
 kgVdv5uGrSMRIfdEbgA6jSqsd00RikhGl/OBLE9V+8itOqdO7bSHm0kJnSbdv6a48pA2
 Wz1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=U1mjdiTf1REytCgM0qXLRwHi12+4iLhjMHz6o0dObf4=;
 b=VjfaHEn7rXBnaiv65g6/iEP4i/vp8zbjL8KRGOYMN+rQk6E9GlWEi+yW0A3XgnRz+8
 yAMDVc1Yqce/RMvkVvHmo+xcudxnyeP2QKSdqwofLIbjDOzmBNmrUCNurZgKCFhijXpF
 fj2ZLeh8/fBJjmbj2JVRhOO+blNjm1dY4PUWSRTvdAvFnH9fPVhw+xwunOwINKT16sqr
 +3/YP70Dp30DBrRT3TsGvCHhFqyGM1FSf4B985XJ0ZDpTxoeY99gQjklyEkIioxMgTov
 y7UZQDJUEir0OgvzknVbpC2dMhzV67+ngIoRmeBR/IgNOcdLTnvNaFQUfSlwejoeotW8
 QmUA==
X-Gm-Message-State: AOAM5322u7J4gXVg7BQQlM4EgqSPbFAvWaaALTOCEMaIDHujSdzcA8IX
 QlOvQMpXPB+SLEyJI1E4yjbUnmInF3Q=
X-Google-Smtp-Source: ABdhPJxJfhv4J/Z8dONpLYUW4MpGcI1VRHtlxbqb93pVNIkZdbpJQqFPedb6S47261MqborqJwQs/SHfE9o=
X-Received: by 2002:a17:902:c389:: with SMTP id
 g9mr7645772plg.317.1595592719727; 
 Fri, 24 Jul 2020 05:11:59 -0700 (PDT)
Date: Fri, 24 Jul 2020 12:11:42 +0000
In-Reply-To: <20200724121143.1589121-1-satyat@google.com>
Message-Id: <20200724121143.1589121-7-satyat@google.com>
Mime-Version: 1.0
References: <20200724121143.1589121-1-satyat@google.com>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
To: linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
X-Headers-End: 1jyx03-001Nwo-UF
Subject: [f2fs-dev] [PATCH v5 6/7] fscrypt: document inline encryption
 support
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
Cc: linux-xfs@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 Eric Biggers <ebiggers@google.com>, Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Update the fscrypt documentation file for inline encryption support.

Signed-off-by: Satya Tangirala <satyat@google.com>
Reviewed-by: Eric Biggers <ebiggers@google.com>
Reviewed-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 Documentation/filesystems/fscrypt.rst | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/fscrypt.rst b/Documentation/filesystems/fscrypt.rst
index f5d8b0303ddf..ec81598477fc 100644
--- a/Documentation/filesystems/fscrypt.rst
+++ b/Documentation/filesystems/fscrypt.rst
@@ -1204,6 +1204,18 @@ buffer.  Some filesystems, such as UBIFS, already use temporary
 buffers regardless of encryption.  Other filesystems, such as ext4 and
 F2FS, have to allocate bounce pages specially for encryption.
 
+Fscrypt is also able to use inline encryption hardware instead of the
+kernel crypto API for en/decryption of file contents.  When possible,
+and if directed to do so (by specifying the 'inlinecrypt' mount option
+for an ext4/F2FS filesystem), it adds encryption contexts to bios and
+uses blk-crypto to perform the en/decryption instead of making use of
+the above read/write path changes.  Of course, even if directed to
+make use of inline encryption, fscrypt will only be able to do so if
+either hardware inline encryption support is available for the
+selected encryption algorithm or CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK
+is selected.  If neither is the case, fscrypt will fall back to using
+the above mentioned read/write path changes for en/decryption.
+
 Filename hashing and encoding
 -----------------------------
 
@@ -1250,7 +1262,9 @@ Tests
 
 To test fscrypt, use xfstests, which is Linux's de facto standard
 filesystem test suite.  First, run all the tests in the "encrypt"
-group on the relevant filesystem(s).  For example, to test ext4 and
+group on the relevant filesystem(s).  One can also run the tests
+with the 'inlinecrypt' mount option to test the implementation for
+inline encryption support.  For example, to test ext4 and
 f2fs encryption using `kvm-xfstests
 <https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-quickstart.md>`_::
 
-- 
2.28.0.rc0.142.g3c755180ce-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
