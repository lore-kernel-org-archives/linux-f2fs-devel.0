Return-Path: <SRS0=U42b=WH=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94C0C0650F
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 11 Aug 2019 21:37:26 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CC6C20818;
	Sun, 11 Aug 2019 21:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="X4IOuulJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="KKUkPgVb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1Uu7QZwb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CC6C20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hwvWo-0003CG-7x; Sun, 11 Aug 2019 21:37:26 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1hwvWn-0003CA-LB
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 11 Aug 2019 21:37:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jYDs594wnVspGZKIS2pgzBVlC65m3cejq3h86Wp374c=; b=X4IOuulJTbOPBTX79rz26V8LHt
 nj1TAZUIAB7Y3GziYEgTwt70YzsKJPhPfuC9yq5qGHqXEoiavYD3+7cdKsmV4U6W0WKSykVawKbq/
 cWXgq6lcnqYWRNBP+BFRJS+TRv03DLe7g15AUG0ApfAgN6j3N7OrO4/XOwpJQEywafJ4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=jYDs594wnVspGZKIS2pgzBVlC65m3cejq3h86Wp374c=; b=K
 KUkPgVbRl1iNojHIVbAk7ZX718Bz7AuI7sR7f+BbTytOmLYbwJU2q6PouIg+N85e1fyHqsManPc7+
 UXGpJGZKqtbecnBAKTSFGpb/UKUXdfz4Gelsg/fM5n81NWxlNA9sFhW+h1ihvjp8W29G+dNi7X6AE
 qAUfZUDYkI9Bxddc=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hwvWg-0009g6-03
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 11 Aug 2019 21:37:25 +0000
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net
 [24.5.143.220])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2C4332084D;
 Sun, 11 Aug 2019 21:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1565559432;
 bh=M5OO0DAuM0LyMiWiAitlxQ1KgWp1hgxg7lV0HmBjAzE=;
 h=From:To:Cc:Subject:Date:From;
 b=1Uu7QZwbKglvie2v3Mu15XkOb3jsT8kJ2qcgpC7QaCRTFHn0D6ojqNFFMwovEZYXA
 1oIU5mXMWyju0Xfp4QxhNpuvHKtzyNnAODDXuttxUaiEF2iqP4U867di7+PWESxY+q
 hnmDWTYRGPfxheR6V0VpqsRVMIz/EkS8hqRxlnXM=
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fscrypt@vger.kernel.org
Date: Sun, 11 Aug 2019 14:35:51 -0700
Message-Id: <20190811213557.1970-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
X-Headers-End: 1hwvWg-0009g6-03
Subject: [f2fs-dev] [PATCH 0/6] fs-verity fixups
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
Cc: linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

A few fixes and cleanups for fs-verity.

If there are no objections, I'll fold these into the original patches.

Eric Biggers (6):
  fs-verity: fix crash on read error in build_merkle_tree_level()
  ext4: skip truncate when verity in progress in ->write_begin()
  f2fs: skip truncate when verity in progress in ->write_begin()
  ext4: remove ext4_bio_encrypted()
  ext4: fix comment in ext4_end_enable_verity()
  f2fs: use EFSCORRUPTED in f2fs_get_verity_descriptor()

 fs/ext4/inode.c    |  7 +++++--
 fs/ext4/readpage.c |  9 ---------
 fs/ext4/verity.c   |  2 +-
 fs/f2fs/data.c     |  2 +-
 fs/f2fs/verity.c   |  2 +-
 fs/verity/enable.c | 24 ++++++++++++++++--------
 6 files changed, 24 insertions(+), 22 deletions(-)

-- 
2.22.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
