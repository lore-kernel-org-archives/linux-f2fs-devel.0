Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57551C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 13 May 2022 23:21:13 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1npeat-0004d8-3p; Fri, 13 May 2022 23:21:11 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <ebiggers@kernel.org>) id 1npear-0004cl-6v
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 13 May 2022 23:21:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vlD9eKMwNOBwH4f6wvnarH/8FOSO+KrytMeUF2ZLOyE=; b=dXWJyNI66SpY4JqLGyFGTnFcn1
 Nla1ShKuy7DnLiGBbhHew5aH5O7Bf4qw8FqJ2hhNQdg1D7Vpc2lxK5h6Wqd0fSZOnhAeNzj1T8uIn
 5FkfjWnR4gxn5LX3H3yOZ5WoIQbIfFIz+xIIVuQle2xTouf5RYilFjrc3SoEqijJjDnQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=vlD9eKMwNOBwH4f6wvnarH/8FOSO+KrytMeUF2ZLOyE=; b=V
 qS8m6qdmYVN/cF7d/iK7FWp+rf+ktqdzq0EXzwav5l/e+IMIzMZuvf2txYg5jqDjwSt+oikjB+xw2
 1WUgVVpjFO7FsOIsT76McSS+6ASV9r8tUN8pkms2oHPLRhID5B8O/9//gVuzuKBia/Wke6clTtoO7
 MCHkrnR0cYgjxmWA=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1npeap-00BPOo-6t
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 13 May 2022 23:21:09 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 2258AB830E3;
 Fri, 13 May 2022 23:20:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EA8BC34100;
 Fri, 13 May 2022 23:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652484054;
 bh=FJqchHCORnLCNFnQpFOuuMgpj/VDBAVWYv8RiIVneO0=;
 h=From:To:Cc:Subject:Date:From;
 b=gYGehX9LGVfhole35UbJ26ARVUHQYtRlY1+6KlmRG7N80f4WNYdPxXYJsxLL7Rn2V
 mK7q4szQ3es5vfA5XLEtTUVXb9xgpbfvnRGeXD3YtoDqYam9kWJdTyJ6sddcNKN0Jh
 hUDpONKGKacqn9m+j6QvXmDZikJp+02XXYizcVmxWIDkhM/xdPaSMIoCntBYn1S9TB
 fgW5oT/wh2wuxHJekrufFjNVypS/tG6Uqwy29pj0hyDVA/1UbaQob+pszeB1/XmBZe
 TvlWQ/K3o6jkkIyh24tjAnPndxcqELqp5QeAbm0liNWvY8/1QahvOtrfQRTj9kRXpb
 aCwXDQTgK9kAw==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Date: Fri, 13 May 2022 16:16:00 -0700
Message-Id: <20220513231605.175121-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Headers-End: 1npeap-00BPOo-6t
Subject: [f2fs-dev] [PATCH v3 0/5] test_dummy_encryption fixes and cleanups
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
Cc: Lukas Czerner <lczerner@redhat.com>, Jeff Layton <jlayton@kernel.org>,
 Theodore Ts'o <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This series cleans up and fixes the way that ext4 and f2fs handle the
test_dummy_encryption mount option.

Some patches from v2 were already applied to the fscrypt and f2fs trees.
This series just includes the remaining patches.  Patches 1-2 can be
applied to the ext4 tree now.  The remaining patches will need to wait
until their prerequisites get merged via the fscrypt tree.

Changed from v2 (besides the omitted patches as mentioned above):
    - Split the parse_apply_sb_mount_options() fix into its own patch
    - Fixed a couple bugs in
      "ext4: fix up test_dummy_encryption handling for new mount API"

Eric Biggers (5):
  ext4: fix memory leak in parse_apply_sb_mount_options()
  ext4: only allow test_dummy_encryption when supported
  ext4: fix up test_dummy_encryption handling for new mount API
  f2fs: use the updated test_dummy_encryption helper functions
  fscrypt: remove fscrypt_set_test_dummy_encryption()

 fs/crypto/policy.c      |  13 ---
 fs/ext4/ext4.h          |   6 --
 fs/ext4/super.c         | 180 +++++++++++++++++++++++-----------------
 fs/f2fs/super.c         |  29 +++++--
 include/linux/fscrypt.h |   2 -
 5 files changed, 124 insertions(+), 106 deletions(-)

-- 
2.36.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
