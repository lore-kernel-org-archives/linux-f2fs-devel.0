Return-Path: <SRS0=CtUu=A4=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175B2C433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 17 Jul 2020 02:06:34 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6ECB207BC;
	Fri, 17 Jul 2020 02:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.b="Tgi2WGc5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="RNnJYGwA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="Y4ePZDFZ";
	dkim=neutral (0-bit key) header.d=google.com header.i=@google.com header.b="ELjLl7Vq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6ECB207BC
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Mime-Version:Message-Id:Date:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Se7oRM8Sye31buha+x3uG6H9Qn2MpoBz457d8CzSIKQ=; b=Tgi2WGc5JNoThhhyDtJTONJI8G
	Ub1HloQFZXr04Fgi+RJbm3iyLMr9DJXPNuIYGGFm5j8T34WuIshaVJ05dS2ulmg8uNAW1/KEeZ7do
	WPNeq6V2MR+L1oxMxrs75IAxv/G4UQmynmhVagN1GB1MkCtTyhAbVH00lcB+haAY0KEc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jwFlg-0003s7-NX; Fri, 17 Jul 2020 02:06:32 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <3XQARXwYKAKASATYATGOOGLE.COM@flex--satyat.bounces.google.com>)
 id 1jwFlf-0003rz-0V
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 17 Jul 2020 02:06:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:Mime-Version:
 Message-Id:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=h180B5pNtOzbYEBjxwcBboRvZXlnjHO7g27S8UvB6u4=; b=RNnJYGwAxf++b53fFE2NWV+5VU
 5blzmNh2TMi4rHAIY7TLQDv1WuzWpMIzQhj3soA2X3B4SwmaU82JcBqobWq6i63Wrzy5s1du/Vu28
 MZp1scSmsWL4UgD1jxjC2kg2XmmG+CdnvuZUPtQRyACrrXh5bCnEgTnIUAx6FMcaBG9I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:Mime-Version:Message-Id:Date:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=h180B5pNtOzbYEBjxwcBboRvZXlnjHO7g27S8UvB6u4=; b=Y
 4ePZDFZx7QriGLq0qn3h9U2GhWpvDO9scpp4mtWQgrpauqHFzBP0/Sx+4eZfbtGihCtkQu7kuCtlU
 ACtAsa/Ytgdx6+hDF87rQMZkji/VHp60DxwVVkhRieQh3RJJz3XK9XyD4sGZG4ZPCdff3W9h4bdyd
 MZFHjYlOOvGZGzsY=;
Received: from mail-qk1-f201.google.com ([209.85.222.201])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1jwFld-00BN3H-Kw
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 17 Jul 2020 02:06:30 +0000
Received: by mail-qk1-f201.google.com with SMTP id 124so5061754qko.8
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 16 Jul 2020 19:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=h180B5pNtOzbYEBjxwcBboRvZXlnjHO7g27S8UvB6u4=;
 b=ELjLl7Vq6Wv4yY35k8D7laIay5mUyA/mDCmNF9Y1UHm5Y/76WtJYAx/iugkyBLF7xL
 GPzIpQBTNRdUkcwnTw16m3C/jktVdbDVOzDbrKhs0XGRaNER0yp5a66lsqLyTMmDIqFJ
 BPQipZO3XktDJp/JrC6s4XmrPO+gGjjHsu5KQjaejvnFaUEEX9Luv8ycJFfHJMftrANR
 6q5sXf1ZWpq/YRNvt4MytlDsV1dYyjoFmUbioMPgqjxclH836oYFThFc7cRj+fH9nAg1
 PAwPX4vN/DarheFPwZnuT8LeMWDFGCnK/ZoXfa6SN8C6eFmmecCMrY3h9ezuXyQG/P5I
 s7qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=h180B5pNtOzbYEBjxwcBboRvZXlnjHO7g27S8UvB6u4=;
 b=QKf+tm2iIbh45xhhy7M9yjbtJr5N//9WpFzyYUbLL5yK0TN6F1SSi5Yk7Set+n4Fc8
 /w6jWSXPwpbhxhU9vsRm0Oqbakv/Z9qlEVqI3FE7lpgf9s7i88nz3Xg7A4sFcinL5Z8M
 z+Ydqx57rC7cKJyi/pTuH8qImsdKqbl0DodHxsKw3FiUErnA27EgLzFXVF69aQB3XOq7
 1cdFZjuB1RsS76zK0hcHQy5YSWgXjXIGTjrrusadxr0c9FBadHf/syuP9PjSwddypR3P
 bIvegGZRPMiXA+OQGbT/wiq1PYN3uV1QXDwoRkM5WRcpQoV9L5wuIRRhLclgZgkdFOvA
 qsAg==
X-Gm-Message-State: AOAM531nJUN5b3a50CKa9Rt1dDBH6cC2g0bfmSrabTz91jyQfzlwXp5+
 3AO8+EhAFvRzKIvIPwTd/qmkXhFMM9g=
X-Google-Smtp-Source: ABdhPJxIB5ldsSrG0e2vKUueYLSna2DbzwU3Sw4Yr1VE1efQAldkODOjxiuQVxlsg1tjNG5UT5PMRTz+qHE=
X-Received: by 2002:a17:902:c402:: with SMTP id
 k2mr5492580plk.185.1594949725585; 
 Thu, 16 Jul 2020 18:35:25 -0700 (PDT)
Date: Fri, 17 Jul 2020 01:35:11 +0000
Message-Id: <20200717013518.59219-1-satyat@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
To: linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
X-Headers-End: 1jwFld-00BN3H-Kw
Subject: [f2fs-dev] [PATCH v2 0/7] add support for direct I/O with fscrypt
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
Cc: linux-xfs@vger.kernel.org, Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This patch series adds support for direct I/O with fscrypt using
blk-crypto. It has been rebased on fscrypt/master.

Patch 1 adds two functions to fscrypt that need to be called to determine
if direct I/O is supported for a request.

Patches 2 and 3 wire up direct-io and iomap respectively with the functions
introduced in Patch 1 and set bio crypt contexts on bios when appropriate
by calling into fscrypt.

Patches 4 and 5 allow ext4 and f2fs direct I/O to support fscrypt without
falling back to buffered I/O.

Patches 6 and 7 update the fscrypt documentation for inline encryption
support and direct I/O. The documentation now notes the required conditions
for inline encryption and direct I/O on encrypted files.

This patch series was tested by running xfstests with test_dummy_encryption
with and without the 'inlinecrypt' mount option, and there were no
meaningful regressions. One regression was for generic/587 on ext4,
but that test isn't compatible with test_dummy_encryption in the first
place, and the test "incorrectly" passes without the 'inlinecrypt' mount
option - a patch will be sent out to exclude that test when
test_dummy_encryption is turned on with ext4 (like the other quota related
tests that use user visible quota files). The other regression was for
generic/252 on ext4, which does direct I/O with a buffer aligned to the
block device's blocksize, but not necessarily aligned to the filesystem's
block size, which direct I/O with fscrypt requires.

Eric Biggers (5):
  fscrypt: Add functions for direct I/O support
  direct-io: add support for fscrypt using blk-crypto
  iomap: support direct I/O with fscrypt using blk-crypto
  ext4: support direct I/O with fscrypt using blk-crypto
  f2fs: support direct I/O with fscrypt using blk-crypto

Satya Tangirala (2):
  fscrypt: document inline encryption support
  fscrypt: update documentation for direct I/O support

 Documentation/filesystems/fscrypt.rst | 36 +++++++++++-
 fs/crypto/crypto.c                    |  8 +++
 fs/crypto/inline_crypt.c              | 80 +++++++++++++++++++++++++++
 fs/direct-io.c                        | 15 ++++-
 fs/ext4/file.c                        | 10 ++--
 fs/f2fs/f2fs.h                        |  6 +-
 fs/iomap/direct-io.c                  |  8 +++
 include/linux/fscrypt.h               | 19 +++++++
 8 files changed, 173 insertions(+), 9 deletions(-)

-- 
2.28.0.rc0.105.gf9edc3c819-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
