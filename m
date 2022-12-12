Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A738C4332F
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 12 Dec 2022 04:46:16 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1p4ahg-00052R-FJ;
	Mon, 12 Dec 2022 04:46:12 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1p4ahf-00052F-K7
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Dec 2022 04:46:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
 From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=h3u27pM1KdReLMKP7YcpwMjlxkY/BHSbHp2QG5ymXbE=; b=Bx6610Cmtb3xEbra/l5tJW0WjX
 ek23ETcniS0O1sLzWCZ7LHHuOS8KgIQMzV3SlC5J74BmRKC73nhfwfaUGUbYWiGvlz+ANmgD7atrG
 o2eewqIKm2kSOxzXJtg7oTRGlo2Up0uVddlo8LIQ3x83oQogeUBPr7acMjwrZaw5BKTs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=h3u27pM1KdReLMKP7YcpwMjlxkY/BHSbHp2QG5ymXbE=; b=e
 c0JE5RELYXyKRyt2plDWnNCw+aGHw3jfFTkR3Os3dGVqX982w6Xsd1vmyyoKAJuphFs97eY/la0hU
 F34ccGpem1yLv4upy77M+uzF/dRghQyAxSJ9r2zSYsDApd9jpgyr37m9ImsC98W+zeTPsUjsvDVcx
 AEt105pBzuXnlMc0=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1p4ahb-00EPiW-9E for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Dec 2022 04:46:11 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id C8C14B80B72;
 Mon, 12 Dec 2022 04:45:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4021DC433D2;
 Mon, 12 Dec 2022 04:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1670820356;
 bh=ZiPqywrfVYJKyTMOBz5ADrSOCtd+XOKFfeu5S1nMah4=;
 h=Date:From:To:Cc:Subject:From;
 b=HHl82Mya2ZR0wKm/58rpz/ANETzs4T9/LlUcAtG6Jj/kdDcSPMy3nUSluiVp8JwXG
 5Zx/BL/ckxlDkCXUPLL9ML9luXQVYAs6fZ+ytcqXBYsADAqzIE7i3GKmkbTrSW/Kw2
 3XWKMbBePAmK7rN4+xXQ8ZaI0tsddiJh0pnmP8PZueq0XoVAbGF6TIgTBuagMf3cb6
 Lct0ctXRuaxw6z9+1GJaxO70Dsudj2HbinzikLEoff2C/Ux+gZAKDKEfXZsivs/eKS
 MgwgMj5QowZcxObgBI0FlnIbym4sDn6ocMgkng+dpntHP+WBUO09whZTmB+UJ6+foK
 l2I392lOG5/3w==
Date: Sun, 11 Dec 2022 20:45:54 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <Y5ayAsXkTF3jK13s@sol.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
X-Headers-End: 1p4ahb-00EPiW-9E
Subject: [f2fs-dev] [GIT PULL] fscrypt updates for 6.2
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

The following changes since commit f0c4d9fc9cc9462659728d168387191387e903cc:

  Linux 6.1-rc4 (2022-11-06 15:07:11 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git tags/fscrypt-for-linus

for you to fetch changes up to 41952551acb405080726aa38a8a7ce317d9de4bb:

  fscrypt: add additional documentation for SM4 support (2022-12-02 10:43:00 -0800)

----------------------------------------------------------------

This release adds SM4 encryption support, contributed by Tianjia Zhang.
SM4 is a Chinese block cipher that is an alternative to AES.

I recommend against using SM4, but (according to Tianjia) some people
are being required to use it.  Since SM4 has been turning up in many
other places (crypto API, wireless, TLS, OpenSSL, ARMv8 CPUs, etc.), it
hasn't been very controversial, and some people have to use it, I don't
think it would be fair for me to reject this optional feature.

Besides the above, there are a couple cleanups.

----------------------------------------------------------------
Eric Biggers (4):
      fscrypt: pass super_block to fscrypt_put_master_key_activeref()
      fscrypt: add comment for fscrypt_valid_enc_modes_v1()
      fscrypt: remove unused Speck definitions
      fscrypt: add additional documentation for SM4 support

Tianjia Zhang (2):
      blk-crypto: Add support for SM4-XTS blk crypto mode
      fscrypt: Add SM4 XTS/CTS symmetric algorithm support

 Documentation/filesystems/fscrypt.rst |  7 +++++++
 block/blk-crypto.c                    |  6 ++++++
 fs/crypto/fscrypt_private.h           | 13 ++++---------
 fs/crypto/keyring.c                   | 14 ++++++--------
 fs/crypto/keysetup.c                  | 17 ++++++++++++++++-
 fs/crypto/policy.c                    | 12 ++++++++++++
 include/linux/blk-crypto.h            |  1 +
 include/uapi/linux/fscrypt.h          |  4 ++--
 8 files changed, 54 insertions(+), 20 deletions(-)


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
