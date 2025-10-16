Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85D61CCD199
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 16 Oct 2025 18:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TV11V/RspN4IgRoAdi4C7HsuXeFxePkyHNkFw05rK2o=; b=eY9M93yCcCI0yemHNYQSVWVKQL
	EDU4rWDFpJE4l3Q4VkL+tau0DcqenVXwDyLelECVqn21SKvHuL3yIPgNbFf6YIoyWG0cTeX/58R6h
	XxzGpq2L4yEaNgw22Iz/p5LMJX3Ox9ifGd0LncRZ70UbIsBLZ1QRHVgZ+7q71QUUq8AA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1v9Seb-0004MS-Bd;
	Thu, 16 Oct 2025 18:24:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1v9SeZ-0004MJ-Jn
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 16 Oct 2025 18:24:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GybxCwNpugbHBDhumWCSvFJgeIEGadeP9fFsa4grFFM=; b=PYj70JETW4LyHHjmbJvj+96yX+
 2EyN8VYoTHTTIFF2NyvA5ZHw54PK0MhXnGfVKc/VYpGYjxyQu5nc90zGLfKd6zZYSFVYIw/45ASAH
 naeEB3VR02/GMkWPJ906hYkhp8spvwk8ZBuYSlpjQUkEv4U/EwfeSHHDlj2rVrOnVWJU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GybxCwNpugbHBDhumWCSvFJgeIEGadeP9fFsa4grFFM=; b=SYLk6wH/vS5iUIq1lmn1F83voU
 odE0Puq13NsoSZC6mEeynTbR+k5HIySfTMRNEMXSqUrc8Z4zwrjKHp1lX32ZGFMu4HaXIhqLtkNLs
 Mc+iTqdVE1y4Z8ujeFtjhVK+v4sknQ4oz7n5Ot4vBbYRm52LdF2G0vC8EizmkluEtJ4o=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1v9SeZ-0001yN-Mm for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 16 Oct 2025 18:24:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 64C7944547;
 Thu, 16 Oct 2025 18:24:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A8A2C4CEFB;
 Thu, 16 Oct 2025 18:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1760639078;
 bh=uzY7QbZ8CrzW7pubjL/Qa8fDMy2uC8toqiGjslYwHCU=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=sb4HYadLP5bflziqd0jzlztvEDxzI3kLxyX5GbpyEnuka4Y98ptacMqBcrhaBcSCO
 XPRyR++XZMhsyIsa8P/QDkBJHQvrR8ZVfilRwu01NlE6m88wuc0saC+gjmNxYBhm9F
 IEZLw400CSVcpPtikxtlWA13Rg9/N97ihNISIReE09o0xsbVtB3iSTrEt6T4qoVc9B
 PpVmjMhS0KXtiQUVBIzMMNJXF2Pi8E2F4Y/vn5I6LCkfXg8ntxaFvADf/suslfCRUm
 +oU9zKnq6HA6dzPRLZFLpjv6YR8bggMa7BTnX0IWU0Ul4TRzNEz3peFHlRkyYeDOYA
 /3uSzbgz6j85w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 ADD6B39B167A; Thu, 16 Oct 2025 18:24:23 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <176063906224.1852182.4367810623044827631.git-patchwork-notify@kernel.org>
Date: Thu, 16 Oct 2025 18:24:22 +0000
References: <aPEt2-u8J16L9Xnk@google.com>
In-Reply-To: <aPEt2-u8J16L9Xnk@google.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>
X-Headers-End: 1v9SeZ-0001yN-Mm
Subject: Re: [f2fs-dev] [GIT PULL] f2fs fix for 6.18-rc2
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
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This pull request was applied to jaegeuk/f2fs.git (dev)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Thu, 16 Oct 2025 17:39:39 +0000 you wrote:
> Hi Linus,
> 
> Could you please consider this pull request?
> 
> The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:
> 
>   Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,GIT,PULL] f2fs fix for 6.18-rc2
    https://git.kernel.org/jaegeuk/f2fs/c/98ac9cc4b445

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
