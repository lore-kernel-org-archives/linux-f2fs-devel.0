Return-Path: <SRS0=Htwq=6V=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64EA1C47247
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  7 May 2020 08:02:17 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29E7020753;
	Thu,  7 May 2020 08:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="Ijj9jVUx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="V63Pny0N";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IU4KDFFn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29E7020753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jWbTz-0004W6-Ow; Thu, 07 May 2020 08:02:15 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1jWbTy-0004Va-Nq
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 07 May 2020 08:02:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3YJzPBm6IYFDloMYW7IxomYb64yom6inso4U8I7pbBE=; b=Ijj9jVUxq4L3K8gGdUXemmTlWZ
 VR5kiJEc91MqjYr1OCFLZ/IMV0N+J5XiHmq1ihLnjBDYGv7queLa1DAt/1V9rLM5Q4u7HJgVLHrgf
 XY3+KRc5dU699hBu+wdpPlhYVPRlje3ggB4A2DRYztQuQwDlUO3lRp39JcYpiRQair3c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=3YJzPBm6IYFDloMYW7IxomYb64yom6inso4U8I7pbBE=; b=V
 63Pny0NaYawLB/I8+OmM9USwn17ZoCwK19jb56qDCGjd/XudjGDMqFJtmKylgsvRwU8yXvUo9ie9F
 4/1O35z04zPJ41wHoX3gluuKhWu45A7X5fYutyOdQm9s3bh952arjO1IPm2qpb+Wg4uC3aSm34MX+
 f4X5md2rOKOCN3+8=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jWbTv-00AsGG-22
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 07 May 2020 08:02:14 +0000
Received: from sol.hsd1.ca.comcast.net (c-107-3-166-239.hsd1.ca.comcast.net
 [107.3.166.239])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2E55D20753;
 Thu,  7 May 2020 08:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588838525;
 bh=8lxPu1GJKKrJRy1UQ0dnX2QT0LRqToRw9cNPct9sjzk=;
 h=From:To:Cc:Subject:Date:From;
 b=IU4KDFFnoexDsKP4WOWlZEb7iBX27h0ePrYPQ6zhAYK/UEQxP4R5NDjaEMXfrGnrQ
 z13uPdrFA3/0DYgUkfGM6LW/AHQXyC3ooKXZf6WX4N3xNP4PyxjxBuLc99f8b4CGom
 OHSum1KEDBr1tX4L9OJ5SIY65QHyJQM+jIejr3bs=
From: Eric Biggers <ebiggers@kernel.org>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Thu,  7 May 2020 00:59:01 -0700
Message-Id: <20200507075905.953777-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Headers-End: 1jWbTv-00AsGG-22
Subject: [f2fs-dev] [PATCH 0/4] f2fs: rework filename handling
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
Cc: linux-fscrypt@vger.kernel.org,
 Gabriel Krisman Bertazi <krisman@collabora.com>,
 Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This patchset reworks f2fs's handling of filenames to make it much
easier to correctly implement all combinations of normal, encrypted,
casefolded, and encrypted+casefolded directories.  It also optimizes all
filesystem operations to compute the dirhash and casefolded name only
once, rather than once per directory level or directory block.

Patch 4 is RFC and shows how we can add support for encrypted+casefolded
directories fairly easily after this rework -- including support for
roll-forward recovery.  (It's incomplete as it doesn't include the
needed dentry_ops -- those can be found in Daniel's patchset
https://lkml.kernel.org/r/20200307023611.204708-1-drosen@google.com)

So far this is only lightly tested, e.g. with the xfstests in the
'encrypt' and 'casefold' groups.  I haven't tested patch 4 yet.

Eric Biggers (4):
  f2fs: don't leak filename in f2fs_try_convert_inline_dir()
  f2fs: split f2fs_d_compare() from f2fs_match_name()
  f2fs: rework filename handling
  f2fs: Handle casefolding with Encryption (INCOMPLETE)

 fs/f2fs/dir.c      | 415 +++++++++++++++++++++++++++------------------
 fs/f2fs/f2fs.h     |  85 +++++++---
 fs/f2fs/hash.c     |  87 +++++-----
 fs/f2fs/inline.c   |  49 +++---
 fs/f2fs/namei.c    |   6 +-
 fs/f2fs/recovery.c |  61 +++++--
 6 files changed, 430 insertions(+), 273 deletions(-)

-- 
2.26.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
