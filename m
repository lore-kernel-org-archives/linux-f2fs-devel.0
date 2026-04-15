Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F8FEF4385A
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 15 Apr 2026 16:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JDScdvcZZTAkfpMGs/OMNPWnlvaPQf21cBwW7unac/M=; b=dV/YfxteOf3vgjvYT+jqO5vdOI
	hDT4Y6DwZvVOFYbh7upIMcTv58GMG8lYzsEyZhCgT/aLiaOF6T9o7rvXKVDPLfYZyrti73RzROEoP
	iuGjkKEr5jlJHqe3q27mDJnCp/oq6Hv6HLBnHk7UmsiQaDnmsg30YCzRJbp5m/IVCs0o=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wD3ST-0007s8-2C;
	Wed, 15 Apr 2026 16:51:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wD3SQ-0007ri-RY
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 15 Apr 2026 16:51:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mqKB7NzmogtGKZTWmde1PoC9YX6WAWwacQPGt4rNQc0=; b=Pds29Iz+y4v94KteJl/N1erDQl
 bgPSoVJHv16KnNvlJyDnzWNf7AcUbQLs0H0zZTLc2i3qhNQYGJ3N4Bt02g0sIoYB1qPYzn2CdNLBb
 V8ITD/qDtuO4blT6u55d4uirf4E2Xg3QOdGqsvBlDX3HLWt3aS/7Dv8VQzEgytDnVSLo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mqKB7NzmogtGKZTWmde1PoC9YX6WAWwacQPGt4rNQc0=; b=VqHH4/H4Ncs8JyQe1gXn5Lt1IT
 ABBIevB3tq8NdIrsDsbycRHjLyaHOsf+AP7aGS/ryYEKI2M2nrXEKKc8I1f0U/quBFesVagicbi4B
 zhvzYV+91YELfpSI57U8OtO7O/5YQiHuAYdWvPFfpdTb3+kCYPRXwciyTR+ZT30S+IeQ=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wD3SQ-00019C-CT for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 15 Apr 2026 16:51:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 1E49141817;
 Wed, 15 Apr 2026 16:51:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F176FC19424;
 Wed, 15 Apr 2026 16:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776271868;
 bh=RA4k+nacALW64Qpgyul1RIM9M5oMRL9OXhrdVtb9T+Q=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=fIaKy36Dsycl6i8U5S64aaDar5Mr0+/mq1zT7GlPO3RZdfUVujqfMXCR6F1u0CT82
 IlfflI0RCU+Z2xLaxb/LAP88js9GEAfC/zXyuxUGNrkAenWUyT5l3KN0Ga6u1oTTHg
 7J/8XX8pBp0zhfAEuPHgGMVDQ33J9TaMzcEIWoPDQ18fqT5xX7ZxXWB/hoziqwdzrp
 +7ubmvrlcVbJSochw7Sm9WFtq4yGLjW+yMmGmsfD1q/3Z45spFjCqhzmPLd+N/jnaW
 6MmQ7FrLv6MxCZ00FYkG/2qG8pHivD7q73jgNBciOicsFVpQzom7RTa/2zVk5k4sF6
 iw1sDkzQeAiBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 B9F30380A963; Wed, 15 Apr 2026 16:50:38 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <177627183769.2303073.7362996361597300412.git-patchwork-notify@kernel.org>
Date: Wed, 15 Apr 2026 16:50:37 +0000
References: <20260410124726.2035729-1-lgs201920130244@gmail.com>
In-Reply-To: <20260410124726.2035729-1-lgs201920130244@gmail.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
X-Headers-End: 1wD3SQ-00019C-CT
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix uninitialized kobject put in
 f2fs_init_sysfs()
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

On Fri, 10 Apr 2026 20:47:26 +0800 you wrote:
> In f2fs_init_sysfs(), all failure paths after kset_register() jump to
> put_kobject, which unconditionally releases both f2fs_tune and
> f2fs_feat.
> 
> If kobject_init_and_add(&f2fs_feat, ...) fails, f2fs_tune has not been
> initialized yet, so calling kobject_put(&f2fs_tune) is invalid.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix uninitialized kobject put in f2fs_init_sysfs()
    https://git.kernel.org/jaegeuk/f2fs/c/b635f2ecdb5a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
