Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8484C636CC
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 19 Feb 2023 20:37:37 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pTqRC-0004D5-WF;
	Sun, 19 Feb 2023 20:37:35 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1pTqRC-0004Cz-9Y
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 19 Feb 2023 20:37:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
 From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=k4rUAT2JB6kFeiMzluK+qAQ50rByNIQ65Bvf4IUysLQ=; b=LikdTiw9AygknFSoPvbi7WtwVI
 mm28zcILt76fD8UhaD/lQLyo/Y/nu79uz24htmP9Iwp/2+txcI+u4flhz0QJOwCXKQS1yfxSMiFJx
 PAKd8Vl6CrlSCl7Y5VksjY22zzT08M/Ta86wqVqodf7XoZVpnR+kMQiiQffFvZV2PxDA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=k4rUAT2JB6kFeiMzluK+qAQ50rByNIQ65Bvf4IUysLQ=; b=F
 IK3ezKaabKiBkH7RQZEJclKUKeH5Y8lh4qM/EUigr1LqR2nhd2Au28Gh4a0CI94osLKvpQCnRjFGr
 8WSqMG3EW53K3swbobHvwqkmQkMCFGOdmQjqM22G9TmDHhY+M9yF3DhV8sO0WcG7KgzUld1PAviyz
 SZFt+UGxcinU3X4Y=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pTqRB-00ANxL-NK for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 19 Feb 2023 20:37:34 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 662A9B80A0A;
 Sun, 19 Feb 2023 20:37:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C34D8C433EF;
 Sun, 19 Feb 2023 20:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1676839046;
 bh=iTe0OcSqwl6lEg6Ylv8otlLHv1N+efZfZXNkztSLoIE=;
 h=Date:From:To:Cc:Subject:From;
 b=hmU/ReWdkFwW0Ws8IuBgL9dlSbZiG8GOMovVLCe1VgSrgTw2eVfp3YdZh5LygaKk/
 e7cELOsXMXNURB5X0TzI9uKhx9m5AYwcvTnicERhaoh37Ahb/8B4nbxxMqOD6zuJsB
 i2qIqQo4292V+2TtJNFoHwvEfq93Zf4T0nBfBRjVlSgNaAJ5m7a06myTDlhqB2GvaC
 WnBvBaKkr0P1NatSWar24NbVNrymCicJKUowWm0hp4wJyDwYBE/0vDy7kRR6xinKry
 NeVbEaQnp199+109ajvjgJgVZ+YKPhokDF6YsX4Vrxafyv7Zmb4CPV9vcRZzN8caiU
 RKHIj0H2G1sYA==
Date: Sun, 19 Feb 2023 12:37:23 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <Y/KIgw8gAI/gtN8E@sol.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
X-Headers-End: 1pTqRB-00ANxL-NK
Subject: [f2fs-dev] [GIT PULL] fscrypt updates for 6.3
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

The following changes since commit 6d796c50f84ca79f1722bb131799e5a5710c4700:

  Linux 6.2-rc6 (2023-01-29 13:59:43 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/fs/fscrypt/linux.git tags/fscrypt-for-linus

for you to fetch changes up to 097d7c1fcb8d4b52c62a36f94b8f18bc21a24934:

  fscrypt: clean up fscrypt_add_test_dummy_key() (2023-02-07 22:30:30 -0800)

----------------------------------------------------------------

Simplify the implementation of the test_dummy_encryption mount option by
adding the "test dummy key" on-demand.

----------------------------------------------------------------
Eric Biggers (5):
      fscrypt: add the test dummy encryption key on-demand
      ext4: stop calling fscrypt_add_test_dummy_key()
      f2fs: stop calling fscrypt_add_test_dummy_key()
      fs/super.c: stop calling fscrypt_destroy_keyring() from __put_super()
      fscrypt: clean up fscrypt_add_test_dummy_key()

 fs/crypto/fscrypt_private.h |  4 ++++
 fs/crypto/keyring.c         | 26 +++++++-------------------
 fs/crypto/keysetup.c        | 23 +++++++++++++++++++++--
 fs/crypto/policy.c          |  3 +--
 fs/ext4/super.c             | 13 +------------
 fs/f2fs/super.c             |  6 ------
 fs/super.c                  |  1 -
 include/linux/fscrypt.h     |  9 ---------
 8 files changed, 34 insertions(+), 51 deletions(-)


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
