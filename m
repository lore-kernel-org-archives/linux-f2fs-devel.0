Return-Path: <SRS0=CtUu=A4=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E77C433E4
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 17 Jul 2020 01:53:02 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 591492076D;
	Fri, 17 Jul 2020 01:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.b="jf84WgJ7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="ZzZqxOOs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="GYtugGrZ";
	dkim=neutral (0-bit key) header.d=google.com header.i=@google.com header.b="tEG1tbY0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 591492076D
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:References:Mime-Version:Message-Id:
	In-Reply-To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VcHLDHVEU2ltCfOSo5gCyeL9naGcDf6YyGPzP/rVsWQ=; b=jf84WgJ7Wn62W2BXAJAeF5Hr2
	zm3W79PFIX9GWTpzI82dyBa9W2dTbqIZnPm5nYBgBuvRjUzP7JhUAjrxxUcCCx+BdkHNVgQHNfpdR
	Q2RpGSj7DfY8yW3O5iYbEmfOVDNR10nzM/vNPhTnmJHC2wL5QhTJQbPolgNmtev12zyBo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jwFYc-0002w5-0e; Fri, 17 Jul 2020 01:53:02 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <31AIRXwYKAB0L3MR3M9HH9E7.5HF@flex--satyat.bounces.google.com>)
 id 1jwFYZ-0002vj-6E
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 17 Jul 2020 01:52:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:References:
 Mime-Version:Message-Id:In-Reply-To:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zr1haxdG39xCeCSCxAtAF/uCJ0PriAfrFWPYdcjKJpg=; b=ZzZqxOOsL1s7KzfSQpA30PkiW
 fUiKUDYuDgo72JDYQnYt15Bu6MbQMDboFOU8/914Jg+HmYWAxX4bbkCB4KagXL/VTuFPsVVYUwgMK
 VolXe/6bFTxCBARItjwp6Zri5/TvJuKQLyEMw6nDl3VfHuvCkQ+eqRavdandYnxUs4bNg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:References:Mime-Version:Message-Id:
 In-Reply-To:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=zr1haxdG39xCeCSCxAtAF/uCJ0PriAfrFWPYdcjKJpg=; b=GYtugGrZZFj0gsy7Gl1mWTtBle
 W0Py0Nsei0op2yJYRO+5yxQAsfiRObTfZrMlIVNEJgyJB3JOka7XrhBPzbwiq1Xj5sWZfO9KbAHK6
 TV0cEmQ4VhZNqWx38hzRL3zWGHKKtlaw5oYtsioVi9D/6PV7mvEQMRJRfVy3d36ayz8k=;
Received: from mail-oo1-f74.google.com ([209.85.161.74])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1jwFYV-006lhH-KX
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 17 Jul 2020 01:52:59 +0000
Received: by mail-oo1-f74.google.com with SMTP id c123so3727752oob.15
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 16 Jul 2020 18:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc; bh=zr1haxdG39xCeCSCxAtAF/uCJ0PriAfrFWPYdcjKJpg=;
 b=tEG1tbY0GS7WlBxSa3Kxt1rFESwI3ui5yUD/cLDZhMOcAswtEsR2gA7+HRG/RM3fom
 kKXQfxEkJ03SNR1VcwABHdAvnSgZUNipTuaqbleOSRI3ly6YGNWQXT0md6xvoxRmgISr
 aj1KioZwAFAZKz6AW2HjIi/fOOThLnth025dI4US/K0SzJSIhF6AN4lrRl8BpYvkr1Lb
 lQR2IJ1LUZ1nzraC9ZyIdcxHojIZhPSRzBFpK0Xtgwy/5Wvxiufo3xtWfUGQ9f6mDhqc
 Jy0npXSloiyPA693awr5gTPYLK5o6O/NYyKBiDV9yOX2QtiUCYUlxyhVr0ZzfowLwJVK
 ez1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc;
 bh=zr1haxdG39xCeCSCxAtAF/uCJ0PriAfrFWPYdcjKJpg=;
 b=ouNd2csidfoApTfchAwvcuUHzAWFLhBgrt1dATCGrkw99zQXBmfHAcnxByA2NlNRGd
 VP/oyX+mZ03z6U6oJcZJpWQpsjhR5YVJXYz83WiZSvnkE22sFR3QGWiySggNs2ja5WTH
 5/l9Eo2OlWP5BDtFE7Lqtnx1jzjjWhMnGUynkypBkD1I0mYcEKqfW9UBbrUZUIzCDoM8
 MmQoBm4YmGC7metGPoQfC5sVhle9sIr79l+Ws7slGf6F68pqWNb9u/x5fDTMjRmzO0Nl
 uPO3ZRqDPzMpUMUnNTJZeFW1efwH6WD91aGWh0czGyKjEWt1FPf0p02V2c8byJC5xetz
 Y5qw==
X-Gm-Message-State: AOAM533k93M8UPIQOr/mJUmO2Y0rNhO+2Fby2FtgPLRnG9LtSFGHV3qb
 7NyImPBOaDGUsYMvDzpeLdrCa2+v9pI=
X-Google-Smtp-Source: ABdhPJxOhOzjo61R2qPX4OdqO+HjLZ7jHTuuKQDlVMjuRGuop7Hl6oLUSvAWIvqqI67Mktlky6ueFrap26Y=
X-Received: by 2002:a17:90b:283:: with SMTP id
 az3mr7615052pjb.38.1594950356419; 
 Thu, 16 Jul 2020 18:45:56 -0700 (PDT)
Date: Fri, 17 Jul 2020 01:45:40 +0000
In-Reply-To: <20200717014540.71515-1-satyat@google.com>
Message-Id: <20200717014540.71515-8-satyat@google.com>
Mime-Version: 1.0
References: <20200717014540.71515-1-satyat@google.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
To: linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
X-Headers-End: 1jwFYV-006lhH-KX
Subject: [f2fs-dev] [PATCH v3 7/7] fscrypt: update documentation for direct
 I/O support
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

Update fscrypt documentation to reflect the addition of direct I/O support
and document the necessary conditions for direct I/O on encrypted files.

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 Documentation/filesystems/fscrypt.rst | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/fscrypt.rst b/Documentation/filesystems/fscrypt.rst
index f3d87a1a0a7f..95c76a5f0567 100644
--- a/Documentation/filesystems/fscrypt.rst
+++ b/Documentation/filesystems/fscrypt.rst
@@ -1049,8 +1049,10 @@ astute users may notice some differences in behavior:
   may be used to overwrite the source files but isn't guaranteed to be
   effective on all filesystems and storage devices.
 
-- Direct I/O is not supported on encrypted files.  Attempts to use
-  direct I/O on such files will fall back to buffered I/O.
+- Direct I/O is supported on encrypted files only under some circumstances
+  (see `Direct I/O support`_ for details). When these circumstances are not
+  met, attempts to use direct I/O on such files will fall back to buffered
+  I/O.
 
 - The fallocate operations FALLOC_FL_COLLAPSE_RANGE and
   FALLOC_FL_INSERT_RANGE are not supported on encrypted files and will
@@ -1257,6 +1259,20 @@ without the key is subject to change in the future.  It is only meant
 as a way to temporarily present valid filenames so that commands like
 ``rm -r`` work as expected on encrypted directories.
 
+Direct I/O support
+------------------
+
+Direct I/O on encrypted files is supported through blk-crypto. In
+particular, this means the kernel must have CONFIG_BLK_INLINE_ENCRYPTION
+enabled, the filesystem must have had the 'inlinecrypt' mount option
+specified, and either hardware inline encryption must be present, or
+CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK must have been enabled. Further,
+any I/O must be aligned to the filesystem block size (*not* necessarily
+the same as the block device's block size) - in particular, any userspace
+buffer into which data is read/written from must also be aligned to the
+filesystem block size. If any of these conditions isn't met, attempts to do
+direct I/O on an encrypted file will fall back to buffered I/O.
+
 Tests
 =====
 
-- 
2.28.0.rc0.105.gf9edc3c819-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
