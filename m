Return-Path: <SRS0=qeLJ=7O=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CFFC433DF
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  1 Jun 2020 06:32:01 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D1F62074B;
	Mon,  1 Jun 2020 06:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="f/t1h9HF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="PU8bON8P";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="CSFPCFQ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D1F62074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jfdzM-0005nZ-Pg; Mon, 01 Jun 2020 06:32:00 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1jfdzK-0005n7-De
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 01 Jun 2020 06:31:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
 From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lEOoO6wRVduQYyCrJVVLsQppTeR18HR8WiWFXP/VekU=; b=f/t1h9HFuGOD5tc81h2eAk4on/
 P5C8VYmaAW5fsYC0krOsxPqL+YjuABBKwYMou3tML8UKMsHrZQt4MqU4FmjUw7siGylvmk/lt2k/J
 w83+2TCb0jat76iGObyToEChj4vnMv30fRRvcvvXAZkjWUB3F/Ca8Or3fOs5byyw3Eko=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=lEOoO6wRVduQYyCrJVVLsQppTeR18HR8WiWFXP/VekU=; b=P
 U8bON8PAoNU/PqNOBbpfyF32spB3apPPLEXggRrY5/6XMcBYETLTIGkZjgiBXBs3xRyGqn3nKxYzt
 V2CxF2EsMannAxlhlCNXthAB84qd+fOu80drCo8jI6ZiN9vhW7C9ZRqlS7YJdrH/8MRwdeV7dXL9v
 nw8MT4UyOkSiAKzM=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jfdzJ-0067ix-3U
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 01 Jun 2020 06:31:58 +0000
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net
 [107.3.166.239])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7B1612074B;
 Mon,  1 Jun 2020 06:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1590993111;
 bh=zAUnY41Sgc7xpNLHu9M0CHlSS/dkDaYIV+HRhlmWnpY=;
 h=Date:From:To:Cc:Subject:From;
 b=CSFPCFQ3+RJAVJDO4ksMLGmjHP29cVIclWcjuK6+F4Ot2xJRz4+VzIz7cME+w5T/k
 XKMGsKBtOlf3e9DVbH1EixVTg6hzJY4FtRDZP/N1ybdBVTd9ZqER4G6mJR6DHs9xlo
 hFDZw+49i6TGMILwmJq3J6QlRd/w3rKhBecJHFjI=
Date: Sun, 31 May 2020 23:31:50 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <20200601063150.GB11054@sol.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
X-Headers-End: 1jfdzJ-0067ix-3U
Subject: [f2fs-dev] [GIT PULL] fsverity updates for 5.8
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
 linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

The following changes since commit 2ef96a5bb12be62ef75b5828c0aab838ebb29cb8:

  Linux 5.7-rc5 (2020-05-10 15:16:58 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fsverity-for-linus

for you to fetch changes up to 9cd6b593cfc9eaa476c9a3fa768b08bca73213d0:

  fs-verity: remove unnecessary extern keywords (2020-05-12 16:44:00 -0700)

----------------------------------------------------------------

Fix kerneldoc warnings and some coding style inconsistencies.
This mirrors the similar cleanups being done in fs/crypto/.

----------------------------------------------------------------
Eric Biggers (2):
      fs-verity: fix all kerneldoc warnings
      fs-verity: remove unnecessary extern keywords

 fs/verity/enable.c           |  2 ++
 fs/verity/fsverity_private.h |  4 ++--
 fs/verity/measure.c          |  2 ++
 fs/verity/open.c             |  1 +
 fs/verity/signature.c        |  3 +++
 fs/verity/verify.c           |  3 +++
 include/linux/fsverity.h     | 19 +++++++++++--------
 7 files changed, 24 insertions(+), 10 deletions(-)


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
