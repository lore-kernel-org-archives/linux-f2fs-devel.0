Return-Path: <SRS0=TvYq=ES=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CEF5C388F7
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 12 Nov 2020 23:16:53 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B905216C4;
	Thu, 12 Nov 2020 23:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="dvdNi/h8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="bIkXBY3R";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="t7JqnwPq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B905216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kdLpi-0003BT-MY; Thu, 12 Nov 2020 23:16:50 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1kdLph-0003BL-G6
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 12 Nov 2020 23:16:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
 From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mgnpl4oy6Exwg8X0Nv9GoGCpWZa7m5rh7fmrV0UeA+Q=; b=dvdNi/h8/atl44q/2nK7dOeBvz
 nisvSf8raGSpn3OcpUZ+U0TOlzpHpAA2Wv7aFGXi35Qd8hObetAHEux0GlE6MSYpASaxNbwyb8SaL
 fA9lkHKUlVFfidRl6sRpSyP1N1KSXjM1ZjkrnsaZSBjH7H3inV8aRHfB2W7RufPXq9xM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=mgnpl4oy6Exwg8X0Nv9GoGCpWZa7m5rh7fmrV0UeA+Q=; b=b
 IkXBY3RO+K3iqOJ5kT+rjfmNVTxwvEaq4oxbWfzs5nTx4JqsrZzWzyUzneQY9VnuC9VYsvaGIGFuQ
 hwEpYQ/u74vte+4hhGSeJj0UodqESVDiZB0C1Av4ehx5deHGJtvzjiYH0cgvoi9YEggfV9quWHwno
 9yUS2g38/fraCCb0=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kdLpb-001LRl-34
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 12 Nov 2020 23:16:49 +0000
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net
 [172.10.235.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 349C020B80;
 Thu, 12 Nov 2020 23:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605222992;
 bh=5CBboKzeplTZn92nfZnKQYbgmTlfqZIgtii4GyCvwZc=;
 h=Date:From:To:Cc:Subject:From;
 b=t7JqnwPqchlO+5f9VjAw6RLfBHPrw0zW7UgTwGnOMuzsXDLy/93klQV8HPwI+fEkB
 jJxiPUcdw27MGZvGx/R23U/+OavrojB30phAEedYNPIeODkK30Zw67JkHSGuRiCRlo
 jqW61uJnn1R7e+c+MlwDJvIIr6orzAKFgr4I0lx0=
Date: Thu, 12 Nov 2020 15:16:30 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <X63CTrVsH3WD+xcE@sol.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
X-Headers-End: 1kdLpb-001LRl-34
Subject: [f2fs-dev] [GIT PULL] another fscrypt fix for 5.10-rc4
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
Cc: Satya Tangirala <satyat@google.com>, Theodore Ts'o <tytso@mit.edu>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fscrypt@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net


The following changes since commit 92cfcd030e4b1de11a6b1edb0840e55c26332d31:

  fscrypt: remove reachable WARN in fscrypt_setup_iv_ino_lblk_32_key() (2020-11-06 09:48:55 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fscrypt-for-linus

for you to fetch changes up to d19d8d345eecd9247cbe6cbf27aef271bd88aba7:

  fscrypt: fix inline encryption not used on new files (2020-11-11 20:59:07 -0800)

----------------------------------------------------------------

Fix a regression where new files weren't using inline encryption when
they should be.

----------------------------------------------------------------
Eric Biggers (1):
      fscrypt: fix inline encryption not used on new files

 fs/crypto/inline_crypt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
