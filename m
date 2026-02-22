Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE3AEC636B6
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 22 Feb 2026 20:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:To:Date:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=D/COm3zDueq6+liYqhLFt1761hhdC0RZfNoakKt/cVc=; b=EhAgPAjnmqCrMGQRE9mgQoC4SL
	F+XqcWdKDJRqDCz8pIogqc4zHxsFw2uqFyWQQhYGfImAgTzw687Py156+OsA5NgyDgodjeUfhvReY
	XxOf/5Pofc9TCVEfkkZOOI2ubS/0rEd0wbatHruCxdjK3L8wINAyG06AWZ/L2ytDZmoI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vuGEK-0006cF-3N;
	Sun, 22 Feb 2026 20:39:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1vuGEI-0006Xp-Rf
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 22 Feb 2026 20:39:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
 From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tITGXWaHDhS9NxGlCFuNugW7CXU04OjXlhw4L8QC110=; b=a476EYsTH7UxqxoJsc4c8BKtzx
 ImmR8b5AtSqRyUyvXjNqO4Ha6h4hy39AID2QXSNCVDXUw4aNJ26MDKCw0s77nlRp+sx0QSKQAIk0a
 Ck8GxnTrk8bfqcCDaaKhRFFno+ZnCLL3g4vUV22AC2icNvyQfQq/W4W+mi5KRpiAlVIM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=tITGXWaHDhS9NxGlCFuNugW7CXU04OjXlhw4L8QC110=; b=L
 T8maYqJrVB3O4OLArMnzYWKYZRdsuNjRS5+Yrn+XwA1+9b+WNmVC61KFVITpbjocDvwJHC3FsJbmH
 8VeX1sfxY18/Ie/RBDSp3ppb8Y7lKz6AxS8174XyRZc35VbfAihMsZL6mE7Ea5QPdg8bYogJV/RIQ
 G991xRrUxiRVB29E=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vuGEI-0007zC-BT for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 22 Feb 2026 20:39:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id AD9496001D;
 Sun, 22 Feb 2026 20:38:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA1DC116D0;
 Sun, 22 Feb 2026 20:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771792731;
 bh=+VxpXalskdd5orPNOTRrMLvQxCitqFrTilFoz+NHPRg=;
 h=Date:From:To:Cc:Subject:From;
 b=nOVdqvPrwtqMJNAYhI3q+GFdqnM4+n7jyx3YNmTfIa+rOJ0hsNqEIQ0wGvR0OGqId
 brop4oxi6YegxJZEBwejT9LYjhRyySFMFy2iunIpjF+0vOtuWpd1xlpeSldrns22D8
 kfihpwEQGJ3SCg3RubDkoQ1yjLV4Rpl3AAb6QJ18sKix4RKhINK8RVHWd8k+H6zl3Q
 vy/H3TNZu2+Ke5tnyI5YVzcUAL2QeoK03O6z0Tw3Zs3BFIwgBTjK8dtJ8C3VZ7KcdT
 Cp8QPtrAIRckd5juwVsy2hoX9PJNjWB+EFYTSCJNvuMwkqxG4JADt4IPFmmi9ktIa/
 mZ70i8GjK9xyQ==
Date: Sun, 22 Feb 2026 12:38:43 -0800
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <20260222203843.GD37806@quark>
MIME-Version: 1.0
Content-Disposition: inline
X-Headers-End: 1vuGEI-0007zC-BT
Subject: [f2fs-dev] [GIT PULL] fsverity fixes for v7.0-rc1
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
From: Eric Biggers via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Eric Biggers <ebiggers@kernel.org>
Cc: fsverity@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

The following changes since commit 64275e9fda3702bfb5ab3b95f7c2b9b414667164:

  Merge tag 'loongarch-7.0' of git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson (2026-02-14 12:47:15 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/fsverity/linux.git tags/fsverity-for-linus

for you to fetch changes up to 693680b9add63dbebb2505a553ff52f8c706c8c0:

  fsverity: fix build error by adding fsverity_readahead() stub (2026-02-17 23:11:40 -0800)

----------------------------------------------------------------

- Fix a build error on parisc

- Remove the non-large-folio-aware function fsverity_verify_page()

----------------------------------------------------------------
Eric Biggers (4):
      f2fs: remove unnecessary ClearPageUptodate in f2fs_verify_cluster()
      f2fs: make f2fs_verify_cluster() partially large-folio-aware
      fsverity: remove fsverity_verify_page()
      fsverity: fix build error by adding fsverity_readahead() stub

 fs/f2fs/compress.c       | 11 +++++------
 fs/verity/verify.c       |  4 ++--
 include/linux/fsverity.h | 15 +++++++--------
 3 files changed, 14 insertions(+), 16 deletions(-)


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
