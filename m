Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ACFAC56207
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  5 Aug 2026 21:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=183FTiQCMPk6IMt1bO2Hh85MHnEUXwiXGD9pkWNWaR0=; b=SrbsQOgKs7dj31Kcf4mlOIfLuZ
	YqHhlOuHVtBmOPAbTN/17sdgFFNRG+ocFFPCAfVJfXdNu7fp3MfPZbQxlM9kBhwjwUlyXl6TlyXo9
	cbDAtxCxZyh838SryliYzoz6PMUmp30ywh3oiohj/7FdigCzs3I1rQHer706UUCWGgWE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wrj3O-0003E6-Ps;
	Wed, 05 Aug 2026 21:21:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wrj3L-0003Dy-Mn
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 21:21:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wVs5OyaU31crQ2f2MSijF9cXIf5yFZ/8WkVx/f/KyIE=; b=gtNLNbm7GZ3nJ38uGtzxB08tjg
 J8a5UoSvgNuiojK5OLujEkpB2BDipAlIqKuVvrLQhAoOhxHG+bZhg8ImRwhtUdaH7lH5NPMhXJxs4
 eybIcs4MVvDpAuJ5oKsMGY0JeTK9N5/Xxf+d7ptN5rhA/j04PaVNuPJqX9ujgLAljrec=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wVs5OyaU31crQ2f2MSijF9cXIf5yFZ/8WkVx/f/KyIE=; b=VU+O+gZl3OTgGX7b7uF5wZQK6Z
 2SVD/2CBPY3x44zfPGnSgVzviVKFMXDApqzOHuud4IgSVbt44uzU/qPKS8z2RC0YEvOx31xdPkKnn
 jQgrz/8+uz7ogGp2RBsca0439Drwcfwg7ySUTjs/9uhU1fxZ2R+cC8vAOVWHZueijFds=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wrj3J-0007AY-Di for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 21:21:31 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D8C8C60A6A;
 Wed,  5 Aug 2026 21:21:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE1A1F00A3D;
 Wed,  5 Aug 2026 21:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785964883;
 bh=wVs5OyaU31crQ2f2MSijF9cXIf5yFZ/8WkVx/f/KyIE=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=JLwZ4cxdyWeUPlGMHe85aErKl/QexHKhFjpIH5i0LwtY7TMybeK9aAJ4btS3ks3io
 sKXdaVnQC5/1sMKL8vKt9oJ/CRG/AuwZjl7DcPf+7M5W7gk7O0E8KpU627J+sICO5j
 TkirZXdP8BHkS+ntW0VNRW/bVsSqcg1cn2ZrauY+/LAye/+IDdxVrSf+vlvmjMRDif
 UGIvNxdmDMa9gyWJZd2jNisNEEtJUiixxZtQBFLVjrH/+IOSh++mXJOgWIkkigX8cV
 FzaQgG0Gz1+r6X9Wu8BFuCT4VpuG4pYjy4en5U7TZceSnZ+Rfzvec5txf4b1oiXtv7
 pvmsksASoZzmw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 93A6C392FFD1; Wed,  5 Aug 2026 21:20:44 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178596484313.530543.9698147873901986563.git-patchwork-notify@kernel.org>
Date: Wed, 05 Aug 2026 21:20:43 +0000
References: <20260623063428.222361-1-joannechien@google.com>
In-Reply-To: <20260623063428.222361-1-joannechien@google.com>
To: Joanne Chang <joannechien@google.com>
X-Headers-End: 1wrj3J-0007AY-Di
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: dirty directory inodes on
 mtime/ctime update
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 23 Jun 2026 06:34:28 +0000 you wrote:
> Xfstests generic/547 sometimes fail with mismatched directory metadata
> before and after a power failure. This happens because when a directory
> entry is added, renamed, or deleted, its mtime and ctime are updated and
> the inode is marked dirty via
> f2fs_mark_inode_dirty_sync(dir, sync=false). The sync=false flag means
> the dirty inode is not added to the global DIRTY_META list. Therefore,
> subsequent checkpoints skip flushing these updated directory blocks,
> causing directory timestamps to revert to stale values after a sudden
> power failure.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: dirty directory inodes on mtime/ctime update
    https://git.kernel.org/jaegeuk/f2fs/c/9ec09d5f4b31

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
