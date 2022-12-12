Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF95CC4332F
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 12 Dec 2022 04:49:06 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1p4akU-0000Ca-7J;
	Mon, 12 Dec 2022 04:49:06 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1p4akF-0000CB-Ma
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Dec 2022 04:48:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
 From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=j/fs7VMWPZeRXSGt3VEbQ/vYccxgN/NgVB0x6PdebXw=; b=MN2KzdyfvwVr8ZmW+e3/WBF0nk
 eFH/EbtfOjl2Z1HWpdCqkRIRGoSpE6ySNWgPtCWlXaKJHbkFnL4V/W5AqQ5Xj4eU66ug6j0r76hkw
 8cD1QHxve9QPQBseiT4rTOb1MB41aZ33J/29zUmteOJCsYltzQSPcSVn8JD48xcPpK7k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=j/fs7VMWPZeRXSGt3VEbQ/vYccxgN/NgVB0x6PdebXw=; b=g
 liMSUE/CUm7FYSdRGTV1y7riCS7rkB6e2t89zfWK3P1Uyn/1pWsbBnZ4kADJpLHHBRCi1itaw2S5q
 trfua8Ok8Ho2R8sH7X6hgt6ViEd267LMF0wRcj3PMvtP/DxWiTNLqxJ0HW51CZvxRgDtYHi2Im/0J
 O/MeNwBZVlb8bXjQ=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1p4akA-0005bV-QB for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Dec 2022 04:48:51 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 326D260EAB;
 Mon, 12 Dec 2022 04:48:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B1BC433D2;
 Mon, 12 Dec 2022 04:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1670820517;
 bh=P8vfT0mshHozuGK5w2ZRZj2IsGSxzeJ1hYUPDymSUpA=;
 h=Date:From:To:Cc:Subject:From;
 b=oRfLPsbhhzn6jLWFdlSW5/taJKYumF3eyRG6EcL4YW6sqOLFj4LLaHj6VXSSK40pr
 Hv/+9C6Os/u8mW4Ko5Rx8JyzQBryXRoTVcGRN1TyF68EbgPW2fE6j4NG9PfMLQs6Ce
 Fa2RwGYuDTemB8vFMLZdS4aYYJPJKlbvPQaJEOJc/MJvHvlQ0ewBVY5XQg6+7qe9Qr
 39D8WQ2euxHusx0zuZJE52IRL6NtNBwZPc9aQiC2Jb0AeLMaz9KQCvZdrswp07u3ez
 J+jKuIuPrkG8E4cf8B1YiU2uSQP8a23eQ4W2ELRPkHSt8Whx7ilNFj96Ji/7n4kaFF
 UbIBpi6gYmeIA==
Date: Sun, 11 Dec 2022 20:48:35 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <Y5ayo48TtNrPgU9D@sol.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
X-Headers-End: 1p4akA-0005bV-QB
Subject: [f2fs-dev] [GIT PULL] fsverity updates for 6.2
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
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

The following changes since commit f0c4d9fc9cc9462659728d168387191387e903cc:

  Linux 6.1-rc4 (2022-11-06 15:07:11 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fsverity-for-linus

for you to fetch changes up to a4bbf53d88c728da9ff6c316b1e4ded63a8f3940:

  fsverity: simplify fsverity_get_digest() (2022-11-29 21:07:41 -0800)

----------------------------------------------------------------

The main change this cycle is to stop using the PG_error flag to track
verity failures, and instead just track failures at the bio level.  This
follows a similar fscrypt change that went into 6.1, and it is a step
towards freeing up PG_error for other uses.

There's also one other small cleanup.

----------------------------------------------------------------
Eric Biggers (2):
      fsverity: stop using PG_error to track error status
      fsverity: simplify fsverity_get_digest()

 fs/ext4/readpage.c           |  8 ++----
 fs/f2fs/compress.c           | 64 +++++++++++++++++++++-----------------------
 fs/f2fs/data.c               | 53 ++++++++++++++++++++++--------------
 fs/verity/fsverity_private.h |  5 ++++
 fs/verity/hash_algs.c        |  6 +++++
 fs/verity/measure.c          | 19 ++-----------
 fs/verity/verify.c           | 12 ++++-----
 7 files changed, 85 insertions(+), 82 deletions(-)


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
