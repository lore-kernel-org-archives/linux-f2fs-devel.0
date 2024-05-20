Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 091EEC25B7A
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 20 May 2024 21:16:56 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1s9ANL-0000nL-EK;
	Mon, 20 May 2024 21:16:56 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1s9ANK-0000nB-KD
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 May 2024 21:16:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=51Q6Fi8AtnFv26/z4GeFuG/0OQNkEqlI6gZD2t2Lg34=; b=lMR5NpkTZQ6wQKLPM+LQdlHGsY
 TVY4goHfPYl6wEdPvdbKaXolGxeFzg4+nQ0hbusvExZLal3jH1XFng8HBXHPJq1lQLSDKB1maQKkC
 9RBI0fewGma9igXLXz2aKxXPlSbjtgYAsIT0IX9h0NgaLFWBxIibcLTTcu/5+d1P+k4E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=51Q6Fi8AtnFv26/z4GeFuG/0OQNkEqlI6gZD2t2Lg34=; b=f
 c/tItY5bOZCgtbzyCTa7a2iO9nLibHj9vIxn4hNGmiPxH7ObRaqoySVro+N4K63aoINVHZksM5z2q
 EbGhZsP5X404nKe2gN10ePYiG5Z77u6/sDZnNTasFbjQmHVf9wbboHqvdEZGXOqstLhNFp1LC78e7
 tX5MyXsbtoEvauYg=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1s9ANL-0005vz-Os for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 May 2024 21:16:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 3E038CE001D
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 20 May 2024 21:16:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7A16DC32789
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 20 May 2024 21:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1716239806;
 bh=aDnYON7iwZUDF0XE/i8RO+t/XzFsqr0rra7S/QkW3A0=;
 h=Subject:From:Date:To:From;
 b=c1Jp3bPaAwINYuHr9qOK0RkHxAcq4PoMyvqfuaDx06dqTntajs6Fh1exFRhqkfR7L
 Uc2wFdIJHxkIseFVf4Dj7tOnK6sBlM82HY5VPox6/xNAZ/8MBOzgh1GUMr09mYpRf9
 /DJG2EPdTZil9NYK5HowwmF2iTToKNbG+/YZ4mUFTBK4vVV86pS6xPzonHa+MkXG59
 w5pCNav+I1JFsMUdy+QucjDzryObWnF1H4tYKuVnNuDJF2piLrl+9sO1U+4ZXIOWX7
 HjgYr7viWezGmYSqymJ6GhUIPuxCgIBhS/9NDsvI9u5+bXvrN3v5kQjypzKSTn0dw8
 6gegZQ78XmJbg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 66E75C54BB0 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 20 May 2024 21:16:46 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <171623980636.27511.432236257415810905.git-patchwork-summary@kernel.org>
Date: Mon, 20 May 2024 21:16:46 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1s9ANL-0005vz-Os
Subject: [f2fs-dev] Patchwork summary for: f2fs
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

The following patches were marked "accepted", because they were applied to
jaegeuk/f2fs.git (dev):

Patch: [f2fs-dev,GIT,PULL] f2fs update for 6.10-rc1
  Submitter: Jaegeuk Kim <jaegeuk@kernel.org>
  Committer: Linus Torvalds <torvalds@linux-foundation.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=854496
  Lore link: https://lore.kernel.org/r/ZkumXs7POGImbr-k@google.com

Series: Remove page_mapping()
  Submitter: Matthew Wilcox <willy@infradead.org>
  Committer: Andrew Morton <akpm@linux-foundation.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=847221
  Lore link: https://lore.kernel.org/r/20240423225552.4113447-1-willy@infradead.org
    Patches: [f2fs-dev,1/6] fscrypt: Convert bh_get_inode_and_lblk_num to use a folio
             [f2fs-dev,2/6] f2fs: Convert f2fs_clear_page_cache_dirty_tag to use a folio
             [f2fs-dev,3/6] memory-failure: Remove calls to page_mapping()
             [f2fs-dev,4/6] migrate: Expand the use of folio in __migrate_device_pages()
             [f2fs-dev,5/6] userfault; Expand folio use in mfill_atomic_install_pte()


Total patches: 6

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
