Return-Path: <SRS0=CtUu=A4=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F09EC4345D
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 17 Jul 2020 01:46:04 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0CFB2070E;
	Fri, 17 Jul 2020 01:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.b="LiNydI5M";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="TEmCSSew";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="fq646cLb";
	dkim=neutral (0-bit key) header.d=google.com header.i=@google.com header.b="IuienX4m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0CFB2070E
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:References:Mime-Version:Message-Id:
	In-Reply-To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=A7stB+XvJQD9AyrEk//33puP/mjMPyYAUzuyXimKBu8=; b=LiNydI5MWdnIbxWE/JBWocvG0
	Kya07KiiTQfMAIlYx43lEqN/qBUNBNK+PSGmJOc/4MZE1GVPQcuawJtRzLGUWSbISJhu+VNq4YoR3
	um8txy542/3ms6RSnlLGek7clqKOzpKDXkgFCdvxWQW8/yzFz5DMoI1ZAJKqeQxosq3z0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jwFRr-0002yi-H0; Fri, 17 Jul 2020 01:46:03 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <30gIRXwYKABsJ1KP1K7FF7C5.3FD@flex--satyat.bounces.google.com>)
 id 1jwFRp-0002ya-RJ
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 17 Jul 2020 01:46:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:References:
 Mime-Version:Message-Id:In-Reply-To:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=M2BARCIgcttWxNELPw4zNOFpxD9+a8coXLhy2/p7EJA=; b=TEmCSSewQzcyIbAjq1uwZ5mq9
 UOMPQZcCsQNdcLazETGgvqxPbrhVdsxW0m5Ti2ftNHOBC+y0vDhn4OXHRHVpVj4O5K9xUkvzpmd4A
 VntmoptX5sgGNCw+9I5hxceGNfmBg1XF5YMOQeoqgDHy+hken5ViVDXdnt7+xy8+oR7WI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:References:Mime-Version:Message-Id:
 In-Reply-To:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=M2BARCIgcttWxNELPw4zNOFpxD9+a8coXLhy2/p7EJA=; b=fq646cLb5b8GdprYnB+ZUMuEDf
 fFC1U6gZDAa7t4+sFge7w3nNzFjJp3QU9m3d9P/KZnBML86frSMwQgpoa2tlbZ4UHAyEjkypHyQ2H
 wHyhJFRlSVZL52+org2jJKhpqKd7VcQkgVYfdNaTUA7ofqp98duVF30tJ3iZAhO4oI0Q=;
Received: from mail-yb1-f202.google.com ([209.85.219.202])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1jwFRo-00BM36-3y
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 17 Jul 2020 01:46:01 +0000
Received: by mail-yb1-f202.google.com with SMTP id i203so9535052yba.9
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 16 Jul 2020 18:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=M2BARCIgcttWxNELPw4zNOFpxD9+a8coXLhy2/p7EJA=;
 b=IuienX4mga40GmSRRKzTF+joRBlWaewlilX9kK4DbxKVxKtc0HgNzNmwzCZ1zOSkZS
 /sl4RwiktZzyDIGk22y0rBU4/6to0p2Mb+0sHuOgVc59Of+mmEYUSL/X8GIx7S9N2g7k
 AAsNYq+yOp1P9y/M3dpmzdp+iTmYeg60KNpHeU9Q4DinrRedG6NGSsYmC3G3+ZszcxWF
 iiLyYi1e8fZMhBIQmpfrA1eMen9sCtNU9W9nDP6q6QwGvJa13W8tY3dxZyWvEvjE0cyb
 7vhn6iWIVWyfKhLFtLO/KNWOxq8m9tNiM/Xk00LgFuq+iUFipff48yn3YZCVEhX9KuBH
 cXvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=M2BARCIgcttWxNELPw4zNOFpxD9+a8coXLhy2/p7EJA=;
 b=JwNBGCLbjbJKg5rQJ8JbMKCLRqQ4/VwMwbnHgTgkVI/uT4a5UcgYW5+7nmapKKi6fT
 eW3tr1YLJQzd3uT0hKIG8vBXAGoiT7fWmWm4A2G8MV8mAU/tjoZCeAAzuFYS/ax7AfSg
 OYTVbMs43sKuz/7JjEmcemAm1GXYZ/kNXJbFTgtjgzu3Iug6TrTx4XeatLeNHAwe1rho
 Ad+GGBW3ZnKBJPpiuq4yDkb5jJHHJkfgQWgTwhNBEI5tB6sxKYiHGb768gYFYrX7t+TL
 C7kgJ9DCIGTFcxXEzQ1GBmJ38gm1ttY19Ha2wbQGM2aYUDZ62yXWJGflkyfptJCvY//V
 JZaw==
X-Gm-Message-State: AOAM533OaJvzli5zPSvo9aSUzddhICWIN80iDtAez9sGNI50zQRYtA3r
 iPICT4cSFuQrcXwmiGkCfECpXbSO+/E=
X-Google-Smtp-Source: ABdhPJxSclWXD3pWyzJ/EO11UCYSucRKXFbMR9YelueZjjlG1f9W2/r7ez0qwF6s0pIusA0evwMmb2iIxEk=
X-Received: by 2002:a25:3789:: with SMTP id
 e131mr10722971yba.417.1594950354393; 
 Thu, 16 Jul 2020 18:45:54 -0700 (PDT)
Date: Fri, 17 Jul 2020 01:45:39 +0000
In-Reply-To: <20200717014540.71515-1-satyat@google.com>
Message-Id: <20200717014540.71515-7-satyat@google.com>
Mime-Version: 1.0
References: <20200717014540.71515-1-satyat@google.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
To: linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
X-Headers-End: 1jwFRo-00BM36-3y
Subject: [f2fs-dev] [PATCH v3 6/7] fscrypt: document inline encryption
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
Cc: linux-xfs@vger.kernel.org, Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Update the fscrypt documentation file for inline encryption support.

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 Documentation/filesystems/fscrypt.rst | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/fscrypt.rst b/Documentation/filesystems/fscrypt.rst
index f5d8b0303ddf..f3d87a1a0a7f 100644
--- a/Documentation/filesystems/fscrypt.rst
+++ b/Documentation/filesystems/fscrypt.rst
@@ -1204,6 +1204,18 @@ buffer.  Some filesystems, such as UBIFS, already use temporary
 buffers regardless of encryption.  Other filesystems, such as ext4 and
 F2FS, have to allocate bounce pages specially for encryption.
 
+Fscrypt is also able to use inline encryption hardware instead of the
+kernel crypto API for en/decryption of file contents.  When possible, and
+if directed to do so (by specifying the 'inlinecrypt' mount option for
+an ext4/F2FS filesystem), it adds encryption contexts to bios and
+uses blk-crypto to perform the en/decryption instead of making use
+of the above read/write path changes.  Of course, even if directed to make
+use of inline encryption, fscrypt will only be able to do so if either
+hardware inline encryption support is available for the selected encryption
+algorithm or CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK is selected.  If neither
+is the case, fscrypt will fall back to using the above mentioned read/write
+path changes for en/decryption.
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
2.28.0.rc0.105.gf9edc3c819-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
