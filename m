Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9CA9F99C95
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 18 Apr 2026 22:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WEsOpaM05O+eOzsQApYwRTsnhA2ATvHuYtW31exR8hE=; b=CeT9gSjcLp+IlhHDN8Lhd0U8x+
	pKqerk5i1qsV8bSnsTwEtQjkIMKlI4poqHzUgwK2Pngw4wGhJEm0s5tEaK/nhOJm5jLutheP9/Ek7
	DwYhZu9NAeLg3d+XQ8r/jbml8E4y/S0TjrpAmN/uxtkcpnbJKeqNJwGsC79OkSePdVFI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wEEV2-00024Z-I0;
	Sat, 18 Apr 2026 22:50:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wEEV0-00024E-HV
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 18 Apr 2026 22:50:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kd6a70d742IYeLHX4GpJhXqhYBFvTOAIhD/mSqz1mgI=; b=VJtyalLD36uAb0jxaVTXUlQhHQ
 T66gu52zAJ91HMATycCGgEQW+CxejyPMlndWfn8jGNKqGynvvl+gziyPQHpcLxKE/liuRsVwa/Z2r
 YvhK6/W2yRNepkHcoeoGlDtB5WcgDL5c7I0c9sGCoBXpjTeE4UHrpOcCmKX4NqBfkRug=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kd6a70d742IYeLHX4GpJhXqhYBFvTOAIhD/mSqz1mgI=; b=l7ph42dkZmoa5w0swoJHpab/te
 P2EvcMXPhGxrpeohDGXhP5zV+VhX7SlWZtkEtA/MrCm9J19fIRJiT8tWtGvZzybM5477gStH69aNb
 sDW5NvWL5XCBRQHAtAcdLnXd4dqkSThjRTde+gLRoFWU0ealqEAxTUqT783Kn/MyMzJA=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wEEUz-0006m8-UV for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 18 Apr 2026 22:50:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 4BE226013B;
 Sat, 18 Apr 2026 22:50:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F11F7C19424;
 Sat, 18 Apr 2026 22:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776552639;
 bh=jno+LesxmhXMDfdFirsiGBJqQ1+fgGx4Imve8IpFhdQ=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=XGzqZq5ASNy9bEhL4AE+Hkhnm+dHIbsOhZr6tDDzHuUfUFEUw3+YtiDefFeBXbFGG
 kyMv998hNZTy7JaVQirXtHBCIbqlizRN4tQc+Y5mBOSAzOrI8lLT//Yh3m1mX3NysQ
 IRhzVjPc+g70Q1XeJGrnmhCGQ0uZElIOFuVNxPbXxJ5qsXw+aN9PSVDDHKMQx5/3G3
 Sq/Zu36YyfO4E7pm7dwbQz6d2qDUQ7GQJHgzoF9kSSF54YPWcQ1Yf7BmkNnrQ5GQhR
 JuClAW7c7z9Y6Tu3OD4+Lc8+/mUyeW16s9uz5/VJmVjGHQV6ZnV5tqyCQJdQ7i3Xh3
 /U1FcnYGj8Irw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 7D051380CEF4; Sat, 18 Apr 2026 22:50:06 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <177655260530.555759.715286792001862165.git-patchwork-notify@kernel.org>
Date: Sat, 18 Apr 2026 22:50:05 +0000
References: <20260417175040.3562355-1-chullee@google.com>
In-Reply-To: <20260417175040.3562355-1-chullee@google.com>
To: Daniel Lee <chullee@google.com>
X-Headers-End: 1wEEUz-0006m8-UV
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: add page-order information for
 large folio reads in iostat
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri, 17 Apr 2026 10:50:40 -0700 you wrote:
> Track read folio counts by order in F2FS iostat sysfs and tracepoints.
> 
> Signed-off-by: Daniel Lee <chullee@google.com>
> ---
> v2: use array size 11 instead of 16
> 
>  fs/f2fs/data.c              |  4 ++++
>  fs/f2fs/f2fs.h              |  3 +++
>  fs/f2fs/iostat.c            | 38 ++++++++++++++++++++++++++++++++++++-
>  fs/f2fs/iostat.h            |  4 ++++
>  include/trace/events/f2fs.h | 21 ++++++++++++++++----
>  5 files changed, 65 insertions(+), 5 deletions(-)

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: add page-order information for large folio reads in iostat
    https://git.kernel.org/jaegeuk/f2fs/c/cb8ff3ead9a3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
