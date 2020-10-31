Return-Path: <SRS0=hdhb=EG=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A00C388F7
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 31 Oct 2020 22:10:17 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82FAE2072C;
	Sat, 31 Oct 2020 22:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="TA1irSop";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="OegOTDqp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8mMgEQt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82FAE2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kYz4e-0005Ey-PF; Sat, 31 Oct 2020 22:10:12 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1kYz4Z-0005Em-Bm
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 31 Oct 2020 22:10:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7KBZORhlEuQFnAO7/rLXio6LJXGJbpArn17NXR/gY3c=; b=TA1irSopZE5zlajICi9umVub4W
 IgnQpQbpOO1sP8U6x15m1gSe43aIG8DEY7kODcYn4OZZ1fqjkzQcjqa0xY5fr/g01/rtZsl96+7Vr
 ykUSM8R38JukEzCUPSKsT6ALaPV+9FitcZfBFBxXd1a0VHOMOAsBGTvHOO/TRF272zVU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=7KBZORhlEuQFnAO7/rLXio6LJXGJbpArn17NXR/gY3c=; b=O
 egOTDqpKhK2FMI7MfY8eelRejpbdDBsaejyYsMLqG3Kj9OCUm6kRZa5Bfi6YaN+SoQIlGiVEAkx02
 CGsq0Gw1Tf9PWXJM1GEurJQZe3rOJmzTaIBIzfxNcwGYGbG+EvBgyiYk1erWFDGdER9s7pBjDXFEt
 vOBPocPO3/iVhLnM=;
Received: from [198.145.29.99] (helo=mail.kernel.org)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kYz4V-004QtO-2L
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 31 Oct 2020 22:10:07 +0000
Received: from sol.attlocal.net
 (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 96A282072C;
 Sat, 31 Oct 2020 22:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604182192;
 bh=S03k1YGXaJQvf3NAsk0rAuPNkYHGojNJSpqWlOKkY6Y=;
 h=From:To:Cc:Subject:Date:From;
 b=a8mMgEQtpZ3jNyytBfAA07mZtl+9vbm6YLLv+FzNDnWsLRWKesdnQyD8DGDQ9NlKo
 NBZjY049c5RkEWrHQHTQiUYaXvEuh5HHjNvlFxn20MOKcGS2hg5wFkYa2cWehnnO0k
 uwKX3GPe/Eyo28ZG698zXqwWlaIL66HoIPdZkgxU=
From: Eric Biggers <ebiggers@kernel.org>
To: stable@vger.kernel.org
Date: Sat, 31 Oct 2020 15:05:48 -0700
Message-Id: <20201031220553.1085782-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
X-Headers-End: 1kYz4V-004QtO-2L
Subject: [f2fs-dev] [PATCH 4.19 0/5] backport some more fscrypt fixes to 4.19
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
Cc: linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Backport some fscrypt fixes from upstream 5.2 to 4.19-stable.

This is needed to get 'kvm-xfstests -c ext4,f2fs,ubifs -g encrypt' to
fully pass on 4.19-stable.  Before, generic/397 and generic/429 failed
on UBIFS due to missing "fscrypt: fix race where ->lookup() marks
plaintext dentry as ciphertext".

This also fixes some bugs that aren't yet covered by the xfstests.
E.g., "fs, fscrypt: clear DCACHE_ENCRYPTED_NAME when unaliasing
directory" fixes a bug that caused real-world problems on Chrome OS.

Some relatively straightforward adjustments were needed to the patches,
mainly due to the refactoring of fscrypt.h that was done in 5.1.

Eric Biggers (5):
  fscrypt: clean up and improve dentry revalidation
  fscrypt: fix race allowing rename() and link() of ciphertext dentries
  fs, fscrypt: clear DCACHE_ENCRYPTED_NAME when unaliasing directory
  fscrypt: only set dentry_operations on ciphertext dentries
  fscrypt: fix race where ->lookup() marks plaintext dentry as
    ciphertext

 fs/crypto/crypto.c              | 58 +++++++++++++------------
 fs/crypto/fname.c               |  1 +
 fs/crypto/hooks.c               | 28 ++++++++----
 fs/dcache.c                     | 15 +++++++
 fs/ext4/ext4.h                  | 62 ++++++++++++++++++++-------
 fs/ext4/namei.c                 | 76 ++++++++++++++++++++++-----------
 fs/f2fs/namei.c                 | 17 +++++---
 fs/ubifs/dir.c                  |  8 ++--
 include/linux/dcache.h          |  2 +-
 include/linux/fscrypt.h         | 30 +++++++------
 include/linux/fscrypt_notsupp.h |  9 ++--
 include/linux/fscrypt_supp.h    |  6 ++-
 12 files changed, 205 insertions(+), 107 deletions(-)

-- 
2.29.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
