Return-Path: <SRS0=DrP0=44=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B99FC0044D
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 11 Mar 2020 19:48:56 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0556020737;
	Wed, 11 Mar 2020 19:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="Ny2KJdcF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="hz87opTC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="v/jab1Mt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0556020737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jC7LZ-0002a3-GP; Wed, 11 Mar 2020 19:48:53 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1jC7LX-0002Zq-RJ
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 11 Mar 2020 19:48:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
 From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OrId9KCjmGjUXLdxmPHUp/Q/wou5a/mcd5X6jSO0xps=; b=Ny2KJdcFYBfPFnO9swNRZLtDA0
 C+ddUtrAo6aCfEpQMbGWsaioZhyO4dANiJoSTyyCiIGy4HS8NNhKJgcd4ny4Z98KSsZMVRmWBBjsK
 NuZVSTaIDiEmbnVjBhK4wEIDKP74dN5Q5JAT6FzZLapnGlJoH9y4vg+ZlJuv6YpNx4MI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=OrId9KCjmGjUXLdxmPHUp/Q/wou5a/mcd5X6jSO0xps=; b=h
 z87opTC0kCR8Fb0RieJpU2BI/L58X2IN9hDtjMP4WtfkL74Dc0CFI9+Y4gFPy9A3JGhOAE+OWH8by
 OMocCfp7JXcfDRVehtxZNk7mWS5TyTgSPtnQAmL1WZ1KTK4fydJrF53ySOkXDMaO2UrbosEna/hSi
 tg8O7ZAKs/YJHADs=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jC7LT-00FuUz-Ph
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 11 Mar 2020 19:48:51 +0000
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net
 [107.3.166.239])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5F6A020691;
 Wed, 11 Mar 2020 19:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1583956122;
 bh=NTCCQBA/qngUM9vruihaGQpLvV8cowQXBnlryjh7duc=;
 h=Date:From:To:Cc:Subject:From;
 b=v/jab1Mtz7GdBG9uHSDV6k2H9A5ugStqAz7qXsT5oSvLW0R8a6a71HOmgfCea5clU
 G66Us11UI+4tNO3Dj0FH7tIcAgD6G5vzcw6dOTDobm5SYL6M1oFXxg7KIYICRZtMGR
 9CaWX6LC7nIdux3wMMCMyiTs0f5kOJR5zRFuyh0M=
Date: Wed, 11 Mar 2020 12:48:39 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <20200311194839.GB41227@sol.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
X-Headers-End: 1jC7LT-00FuUz-Ph
Subject: [f2fs-dev] [GIT PULL] fscrypt fix for v5.6-rc6
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
Cc: Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-fscrypt@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

The following changes since commit 98d54f81e36ba3bf92172791eba5ca5bd813989b:

  Linux 5.6-rc4 (2020-03-01 16:38:46 -0600)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fscrypt-for-linus

for you to fetch changes up to 2b4eae95c7361e0a147b838715c8baa1380a428f:

  fscrypt: don't evict dirty inodes after removing key (2020-03-07 18:43:07 -0800)

----------------------------------------------------------------

Fix a bug where if userspace is writing to encrypted files while the
FS_IOC_REMOVE_ENCRYPTION_KEY ioctl (introduced in v5.4) is running,
dirty inodes could be evicted, causing writes could be lost or the
filesystem to hang due to a use-after-free.  This was encountered during
real-world use, not just theoretical.

Tested with the existing fscrypt xfstests, and with a new xfstest I
wrote to reproduce this bug.  This fix does expose an existing bug with
'-o lazytime' that Ted is working on fixing, but this fscrypt fix is
more critical and is needed anyway regardless of the lazytime fix.

----------------------------------------------------------------
Eric Biggers (1):
      fscrypt: don't evict dirty inodes after removing key

 fs/crypto/keysetup.c | 9 +++++++++
 1 file changed, 9 insertions(+)


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
