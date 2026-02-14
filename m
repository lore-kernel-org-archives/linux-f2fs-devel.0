Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D69BEF5852
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 14 Feb 2026 20:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=aS05l7D30LImbv6GBzyZmn5FLJlJYBrEmRidno8LB3g=; b=iXSfew/tSPbkcYrYKdyvNwe7PK
	PAl+95RMCmRBP3ZgAQartRJ9OVttfNUwoYzFrF5W2GufGyCD2mDLyf4Fbt+rO1QEwSdkCBUcBLc4i
	SETMs4FPGspGJfoIKPqav3eBfqxhhb5CLjXYY182pCgJZ6+UoUvgfKFD6eUilpykyn0E=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vrMKd-0002kr-Nb;
	Sat, 14 Feb 2026 20:33:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1vrMKc-0002kj-KV
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 14 Feb 2026 20:33:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hXwdVdBeZ+DXNsbEc0m95U0fjVMo6/kx9hqz+HLc+Hs=; b=TNX7r3Y6wf5aVDzYZB30nlNvDc
 36U8ox/dGaKipLkUvqwyGVjIqSKkFBHU3dWjjIw0eV5DKZteA5UHdAGO8eFx3Lguq19rYBsDnkVO2
 1FX6N59x1LXOvM0sZeXaYlFie6kdPAAw9YYwUjv3P8Aflo8FU/z9pdlUl9tSG5qsDTh8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=hXwdVdBeZ+DXNsbEc0m95U0fjVMo6/kx9hqz+HLc+Hs=; b=T
 C5Yty14CsZ5J6ZGkE0kiDiHtMdwOskR9hTcGEVHsIuUb7dvh4mhjVplbCK2Jcv8w9yg/THwsgBisx
 GECledD1068DGIoLO1yh10cU3qGhTdIx64gBqvcPqzeiRfbnG+eQhIcj/yWJOjra8KVpQbm0ShvEJ
 UbbHcGp9xszEjAzA=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vrMKc-0002z5-9m for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 14 Feb 2026 20:33:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E829C40B8F;
 Sat, 14 Feb 2026 20:33:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE1CC16AAE;
 Sat, 14 Feb 2026 20:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771101203;
 bh=kRPpSvRaO+9nsvBsobRozgVCjKXJBokYXSaSEJg70SQ=;
 h=From:To:Cc:Subject:Date:From;
 b=tEN2nk+/b059Wf20VW+ot/GZyrA1zVrUfxsKIeaIa/mgAmY9dCWzquGtg2Ksepxi8
 JyDn+eJs5eZnKtG6E+68xiSpSPeCzZzard5d/g33/IpwvJc6+tEidPaaKTIUYwXGx9
 0UgXNK0/wyPIlraEAoUcTSUAVm2fZI7UPRWSi1WOfBlqHtK8E/JopXavJoOQ4enOiA
 QUn4GFoFf4GtttaVJIEQ2I39V+q5gkMAZTTmTOVeGoxQC/VEou1/9fqA8cPd73jUxz
 htk51nB7rCU6ly1XLBPi29x11IQAm7UhYDZul70SDrsIcv2z1OQr1vLWY48qAIWiPu
 fvmXGT0Oxat5Q==
To: fsverity@lists.linux.dev
Date: Sat, 14 Feb 2026 12:33:09 -0800
Message-ID: <20260214203311.9759-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Headers-End: 1vrMKc-0002z5-9m
Subject: [f2fs-dev] [PATCH 0/2] fsverity: remove fsverity_verify_page()
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
Cc: linux-f2fs-devel@lists.sourceforge.net, Eric Biggers <ebiggers@kernel.org>,
 linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This series removes the non-large-folio-aware function
fsverity_verify_page(), which is no longer needed.

Eric Biggers (2):
  f2fs: use fsverity_verify_blocks() instead of fsverity_verify_page()
  fsverity: remove fsverity_verify_page()

 fs/f2fs/compress.c       | 3 ++-
 fs/verity/verify.c       | 4 ++--
 include/linux/fsverity.h | 6 ------
 3 files changed, 4 insertions(+), 9 deletions(-)


base-commit: 3e48a11675c50698374d4ac596fb506736eb1c53
-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
