Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F27D25924
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 27 Jan 2026 02:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Date:Message-Id:MIME-Version:Sender:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=40T73MeHRQhhNGD3HHCpIvKXpFkzfrX+ic2QMhdYZcQ=; b=db6iBgtq+nIIRFAUUJeEXpa3xr
	pk2jJ85NsOVYe5o4bAoHMSEptTkV7gpCH2eZkho36qi/t9VigkNIadPqup/RJhBd7f3EPuBmj+xG/
	nLweH0e53btzmt3qCyvSpbVZ6Sa/YC2+snlRbZaSbqS/v1WPOi8fWBn424QsytSvpbok=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vkZA8-0003Kw-B9;
	Tue, 27 Jan 2026 02:50:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1vkZ9o-0003Ke-7F
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 27 Jan 2026 02:50:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=To:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xqNlaLQe1cDkgMgB8FEhqpyqPg//p5O2fI7xGq610vA=; b=hw/nGX7YlbfpgTV3MCZ8w7lE7T
 nDPgcm5UY/E0uDBpNXclOFFoG+pPuYntVQb4ZW4fJtwk5v1ji9qDPtXg5rzqAvbhU0fz3lnqw/AJC
 66zRtqLL1NlLUdTGMvpjuvZAJPC0evREmXbWNhN11bRnW4MGe3FIRqap+AcXmLrQ0BSg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=To:Date:Message-Id:From:Subject:Content-Transfer-Encoding:MIME-Version:
 Content-Type:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=xqNlaLQe1cDkgMgB8FEhqpyqPg//p5O2fI7xGq610vA=; b=d
 ZTaqQzWXqZo7oN+KS7Yt/n7w70UAHJmoTgTMnYg6N4HDwugl1JY3f4h1nx4bQGeE0UvH3O4LiUpna
 VhbT8kt1M2s/sBdjXYxgshtTQrq1XVuwHNw0xso+jFHWUgH8tRGWpeVDmn8WlCIAmvfh4o9SV0NcU
 iWkbjrTiQKdv0hjA=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vkZ9n-0007g8-MC for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 27 Jan 2026 02:50:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4E0A441865
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 27 Jan 2026 02:50:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E25EC116C6
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 27 Jan 2026 02:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769482209;
 bh=bSgbEkAxEF94xW16xer8rMEwZ7HRNj8CjfcyzyZDRC0=;
 h=Subject:From:Date:To:From;
 b=Sbcp17kAyZMwosNPpnIFYdT1WiEiAXtQ5BpElS3yRBjoIZsmTTZbQme8vJg0mlmfs
 qwSUABVNEYVHlYFl4pXMlLeiO21bGG5L9D0wSaE76QQjTwJEU8umYYXubV7yZufjPz
 iAD/fYmdo6LdhB0sg5InhMGsyhBe2qNJg9aqZp0D9eMWVfxF6J7i44o8V4RpjJi5mW
 +n15yARwMdEUrjLxKmSP3JyCNSjOmfNmhHyFHJGDXWiBTjM/JporwcjnieGz4oCHod
 894mwEHiJ0T/1oZkCclLkEBC/S2reH9BGiHk/LJeIAz/hIqn2FT3Fb41b+wDcY2p5h
 JQrJAEVskOzDg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 8E2D2380A95F for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 27 Jan 2026 02:50:04 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <176948220320.657910.959297017758320862.git-patchwork-summary@kernel.org>
Date: Tue, 27 Jan 2026 02:50:03 +0000
To: linux-f2fs-devel@lists.sourceforge.net
X-Headers-End: 1vkZ9n-0007g8-MC
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
From: patchwork-bot+f2fs--- via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: patchwork-bot+f2fs@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

The following patches were marked "accepted", because they were applied to
jaegeuk/f2fs.git (dev):

Patch: [f2fs-dev,v3,1/2] f2fs: check skipped write in f2fs_enable_checkpoint()
  Submitter: Chao Yu <chao@kernel.org>
  Committer: Jaegeuk Kim <jaegeuk@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/f2fs/list/?series=1046932
  Lore link: https://lore.kernel.org/r/20260126063203.1508295-1-chao@kernel.org


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
