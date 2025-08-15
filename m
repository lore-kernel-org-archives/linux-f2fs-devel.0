Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38EDBCA0EEC
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 15 Aug 2025 16:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xq0Uc4vDi/UFESCG/WXA/zmZi89DUNyZfUfz7tZ/Ud0=; b=edMHCKDnmmhoAGM/24Mkah0MAp
	QcdWqpWhJompgQlcVkVfENVYeHjt7g6XTotttFZOYcolBho2DIJgpapmET/CBxdI4xH2lyPrLWpdc
	Tr93zNqBmibAcUv1BFMKgMve2C8cld2cdU0Scm4wGwPx3hEk7G/3BFp2M1wJsZyF+euw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1umxTV-00013f-SN;
	Fri, 15 Aug 2025 16:40:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1umxTU-00013N-Tw
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 15 Aug 2025 16:40:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9v704Ke7+lC7jKZhRS8JgUh/27Rl8HiPmJz6HVJROFg=; b=Daa+8nG9b3UVs4DUqPKlWWcWwM
 NmgIHI/UJUF+7DsV6vp/+e3/zGjlDJaLFCbxyW8G25y5t2qamkTof4V3PQPKF7nCWxIMR4CSeRdDe
 EpuWs9puESV3qU8TBMvuJm3v1DV3JNqzZ8bNlpPRwlzc5oFjySNvD9+rulM4jMwGGKG4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9v704Ke7+lC7jKZhRS8JgUh/27Rl8HiPmJz6HVJROFg=; b=QW0Ma430NJSXw6mpmZo0iqQewk
 DqOTLNlWIPmDSNtKXhGiXNqEmp4rT7tjQA7o/iFjNImDarvE0BWe7nHYGdY05OzEvrr90Vs0FplRl
 GZZigRLLyq7iijKaa5i1dePZqZz0Mt1XJqZEqeagBJYBEuro631eY4PGIhoTfXUeqxtE=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1umxTU-00018f-Bk for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 15 Aug 2025 16:40:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 130B541889
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 15 Aug 2025 16:40:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB160C4CEEB;
 Fri, 15 Aug 2025 16:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1755276006;
 bh=a95RvXhj76wg4j8/YlXy+Y3TsKNaDGJmw+oSsJ8lrVs=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=XUPh+IHfb/68GPiml32CuObsiWqtPV8V7wlrrCqcAoChJTi4Z8/94TEvm60VpOnfD
 YU6i/ab9wLgm1mt69FaOvPXeDXcPQoSxqZBDwH1srpNx8wzwgfhdjaErv+dM3qXOZU
 MJhxKrh9Lf4g5sRetifcG9SSUSfq0FgaMha3mEzcv+PxTpvKq0bvHiRWIRo0zbaKI5
 WmkZDSnoHUKgSbhNY6JEkDRMlsckfQtiLU4YFVuTT9+d/ghxHPexHyd1IgWiOmfedR
 fpG63pfUlNJ/PQsIRE1vL6sdj8/gnBKyN6TvTc2I0bs2GJx4GCM87g9d5YTjM8Nack
 s/KddtQVkA+4w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 33A2139D0C3D; Fri, 15 Aug 2025 16:40:18 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <175527601673.1161945.11812358458954256363.git-patchwork-notify@kernel.org>
Date: Fri, 15 Aug 2025 16:40:16 +0000
References: <20250806061106.3445717-1-chao@kernel.org>
In-Reply-To: <20250806061106.3445717-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1umxTU-00018f-Bk
Subject: Re: [f2fs-dev] [PATCH v4 2/3] f2fs: fix to zero data after EOF for
 compressed file correctly
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

On Wed,  6 Aug 2025 14:11:06 +0800 you wrote:
> generic/091 may fail, then it bisects to the bad commit ba8dac350faf
> ("f2fs: fix to zero post-eof page").
> 
> What will cause generic/091 to fail is something like below Testcase #1:
> 1. write 16k as compressed blocks
> 2. truncate to 12k
> 3. truncate to 20k
> 4. verify data in range of [12k, 16k], however data is not zero as
> expected
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v4,2/3] f2fs: fix to zero data after EOF for compressed file correctly
    https://git.kernel.org/jaegeuk/f2fs/c/0b2cd5092139

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
