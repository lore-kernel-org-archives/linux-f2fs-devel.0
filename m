Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC90C61DC4
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 25 Aug 2026 15:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tptLyn1IjbNxC0dRX3kmSO0RVxw9OQCBTarHrsNLku8=; b=a7SiWkXQijsjw07kOxu2s3/Au8
	+RlPlOsrvGOiP+aDrvALCnxFX6m/2KjNCg6xFQOtA0uYRVnpPnwkGDBh2+Ftz+qRTZ+AJhLOKHrum
	kaUZADFZThvwd5NbL1CXxPYHHlEGT5mf4olPYQdpbgsMVrmAGnyndCVxZ7Cqw0BDMG7I=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wytGv-00018B-4h;
	Tue, 25 Aug 2026 15:41:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wytGt-000185-QW
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 15:41:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rbJ84W6tWDUKStY1FZU2kjP51571p0eDKeLfqpheWms=; b=MIsYkBBTYtZqxCxKsrNXmpB+gF
 j4PuNRbFtsKc2iQjYBvuxwtZQZw1GjtxXPua1u81/XQArpsBGDSh7yj3sFLeyNfgq80yqRzmIBh8O
 2rZ/WpihYU9I6rAtTMC9bDXM2VK+3ZmNV9a4U0NhRYW4Ru0lPloVtoGl+r5cQ0dKh7ao=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rbJ84W6tWDUKStY1FZU2kjP51571p0eDKeLfqpheWms=; b=bpGcRpETPE+isIlZpwhHGeKAeC
 zX7tuYzjn5kXWKjKw7yB9uM32sKwNIziXw/cmnAWLDQHeNHJ8jMoqRf0KJqYEnPN4mbLt6U4SGSpX
 HAILs/qjtSUi7rn3LIweEVSQQ2BzChGeHdWnZgssXU9t+YIGSRQyYDEl5IUXWCrIcUdE=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wytGp-00017U-TZ for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 15:41:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8A8B7401B2;
 Tue, 25 Aug 2026 15:40:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF511F000E9;
 Tue, 25 Aug 2026 15:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787672458;
 bh=rbJ84W6tWDUKStY1FZU2kjP51571p0eDKeLfqpheWms=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc;
 b=npAlK5DIIwnYoThg2RryWtT5VBJDkHyovFZL8u+vmYnO/lF5FqrF61Fz59zdyoYww
 Cn47VDTIKAOFrv9Ia8gVeKDNTv9GGnFIgvbr8ZLF+x300LHvf96fUJ4pNLS04O/cVm
 Gra/lI/qGCOVR9Z682r+SLxCtck9rZ5k1BwI/gaw487emW5E7qc35JtO3yZdruAPPi
 kUvoLZMwyk8wt4UKkigYGnrlUKSipLfHgNp4FcLAaI0e8C5Y+hUUrTTOqUmA0aj7/a
 3VXZeUrYzr5zLh/FMG8IKUh8IXszpUc62UflkTqtBR8a182X40C1Briavb+nrwEcdp
 3IihdaRYwbz9A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 93A9E3924FEE; Tue, 25 Aug 2026 15:40:06 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <178767240514.3943858.5716693691312332057.git-patchwork-notify@kernel.org>
Date: Tue, 25 Aug 2026 15:40:05 +0000
References: <20260824023231.24616-1-jsjlee1020@gmail.com>
In-Reply-To: <20260824023231.24616-1-jsjlee1020@gmail.com>
To: Seongjae Jeong <jsjlee1020@gmail.com>
X-Headers-End: 1wytGp-00017U-TZ
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: use adjusted write range after
 f2fs_write_checks()
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
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 daehojeong@google.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 24 Aug 2026 02:32:31 +0000 you wrote:
> generic_write_checks() in f2fs_write_checks() can adjust iocb->ki_pos
> for append writes and truncate the iterator to limit the number of bytes
> to write.
> 
> In f2fs_file_write_iter(), the pinned-file overwrite check currently
> uses the position and count saved before f2fs_write_checks(), so it
> can check a range different from the actual write range.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: use adjusted write range after f2fs_write_checks()
    https://git.kernel.org/jaegeuk/f2fs/c/3b2c5d35cf43

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
