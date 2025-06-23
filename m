Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52402C7115B
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 23 Jun 2025 18:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:To:Date:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4OssZHkgn5vARIW/j8fDt/E1/P7RHqOVDGZ/3IUwHto=; b=eJdEsMoZNabqVSEdLGPwUZzgNU
	aabgmwyF0voU08kj2q6hFt9qafmM6lTBTtOpMNcBy1p6oMJajVW8kVE9IT6/ZtsCEl9cL0H9A6Q9Q
	p0BI9l7Buq1Aut2wHhKs0PuEXUSVtqciNjH04GmDdc0/4KuktbyZ5XKPNz+zHLwbLVhw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uTlfJ-0002v9-95;
	Mon, 23 Jun 2025 18:13:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1uTlfH-0002v1-Iq
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Jun 2025 18:13:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
 From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rj4qUtZvFDj99Fa0+YNbSfUAT8XV3GxXnJQtEv884tA=; b=Gn3uQJCFbziIcebwYXY9F9rPoC
 AJdAqAZkvTkJXLXcJ7Ic0Um9YZVJs0/5K76d3Jb5e1W7IIlbKXae8Eu9gXLqI1U4N0aqS85U/m9No
 aH04K+c2YeyA8SJ3MZSjEt+pe7g8mX7sbnq+YQ3IhmPVzB7miqLtiOexqAZnWU7CUKjU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=rj4qUtZvFDj99Fa0+YNbSfUAT8XV3GxXnJQtEv884tA=; b=O
 7mhI9KPRfAUAUNEC3T0M6gCvKdlN5IKLvte4yy7zCVNTfQE0NKEOODIEC0xzF1pUPH5MnRn+iXIdS
 dDUnLwrBwcTIh90813Vn+SI8hpvL3pQlvFsQ6SMVpIZNrhGAZR2sPFmA7/dBVTgANW4V/s9prF5XW
 6zNYxfko0mTGC1Yc=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uTlfH-0005bu-6O for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Jun 2025 18:13:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 7F00AA50D35;
 Mon, 23 Jun 2025 18:13:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F28C9C4CEEA;
 Mon, 23 Jun 2025 18:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1750702381;
 bh=2r8AGEzml7dStSkWcA1RXhJHy+aLxMei4ZIiS1vWtV0=;
 h=Date:From:To:Cc:Subject:From;
 b=t+AwncckHlFw3XBGjdJZ8h206BNMFKf5xm3qTgA2hsZS7cXHnNgeabs7XqohYTtWG
 swhlmD5ag4erhJfCPfQVWAhLRfKsOdE0LLWoP+ltytioqLCDBM97CLstEzbJUojhIJ
 LQWp298elsTPp/pF4Z+ZZ3g/ezCBVOZCLjHzzR69cws6G3QmIFMUxoPKmlMZ3vEVsg
 //60oYTAiNfOHfowteBAJ/+9VAQknF76CEh6pB7Rkl38wQmJc2PGH+WnIaPm3wgY/0
 z6UpfAutV5Ac9+4K0e8hYotys7PgDkZbhXXP3OUoxCHq10Bly1pCyOx97tJXXr8RxP
 HByclmhfDsMpQ==
Date: Mon, 23 Jun 2025 18:12:59 +0000
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <aFmZKyrDBDzTzs4Q@google.com>
MIME-Version: 1.0
Content-Disposition: inline
X-Headers-End: 1uTlfH-0005bu-6O
Subject: [f2fs-dev] [GIT PULL] f2fs fixes for 6.16-rc4
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
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Linus,

Could you please help mergint this bug fix series?

Thanks,

The following changes since commit 19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/f2fs-for-6.16-rc4

for you to fetch changes up to ba8dac350faf16afc129ce6303ca4feaf083ccb1:

  f2fs: fix to zero post-eof page (2025-06-18 21:35:29 +0000)

----------------------------------------------------------------
f2fs-for-6.16-rc4

There are two bug fixes: 1) double-unlock introduced by the recent folio
conversion, 2) stale page content beyond eof complained by xfstests/generic/363.

----------------------------------------------------------------
Chao Yu (1):
      f2fs: fix to zero post-eof page

Matthew Wilcox (Oracle) (1):
      f2fs: Fix __write_node_folio() conversion

 fs/f2fs/file.c | 38 ++++++++++++++++++++++++++++++++++++++
 fs/f2fs/node.c |  1 -
 2 files changed, 38 insertions(+), 1 deletion(-)



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
