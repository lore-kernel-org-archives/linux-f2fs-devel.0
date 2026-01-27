Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4726D25923
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 27 Jan 2026 02:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Wo5+JEDacpHugUNsQexJVYaIWQU95ct0+bH+8dCbRLE=; b=SvONbltMcdUFK5Zhu4wTGN977h
	nkppBMw3JPmEMNOPBBG97QQUeTit9TlCoZjiZ+AuhsCt3tvTPivF0FSlcnBbrXf9Kn8r70Xow5zmr
	StUtHABQX26dKx4eOpthug7nRqG1uAkhSMY2Elc0KccJEWfWZG9mICdHfWxDdzK1ucDA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vkZA7-0004Ki-ON;
	Tue, 27 Jan 2026 02:50:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1vkZ9p-0004KL-Uo
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 27 Jan 2026 02:50:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FaALAjlmxQF15cGCLicBgzUAlDsRpdwLVoWOujBv2OU=; b=BNFuimJ5qyWH2ytn/3vaSaTT9r
 S9fhNokFzP4l5UcQ7UQ2H0KS2aN+7CUAXUuyj5b/C8vLwJmelGxW+UkquAHN6QI5jqhlwECsu7wXt
 xQx0Kc2ilJ2hg03AzltbU6bEH3XsugcONnXeXESzUwnoR8f4jO3LMqfzxe8LHhjKBuMY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FaALAjlmxQF15cGCLicBgzUAlDsRpdwLVoWOujBv2OU=; b=lU+FN1BqbTL7U6+7SQYwE6uYmW
 yGBKSWynGPQH8Pc1idatYE3t0Mv7KdGFV6Gk5CVxng5qKSHFjpFfi7C3SXA2ekL+MN3vTrYa6bdu/
 cedtfqX/AT5sRs4lLptuwls5dWrze6O2hwl1J/FKHDogwQ6mv/5895619dcQRJer8trE=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vkZ9p-0007g9-Bl for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 27 Jan 2026 02:50:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id A81D860097
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 27 Jan 2026 02:50:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D962C116C6;
 Tue, 27 Jan 2026 02:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769482210;
 bh=4LrwhMFkAA5CbcrfmS/njmdQJQ7PdhoFzAj06OVRlfo=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=Vv+jyxy5bTARgjJ9QN/4J+5/UAzEtD6tgj4ZnUBBuzvt6vmRkapBrFBJh/27CQIUX
 NCfnkmtVUfvC+S44vdJWFO3uyg0TsIpFKhhJtB8l1ggTpNL5ypFALFKz7cyRcTM6Kw
 KVhvVlGhNKqoLMflp3KTgpd8rkDMcMpRhyhNJQ7u9lYT++SY/j9UoWEQKGlBiorlOd
 arDt86WIcoj/QMIAiD47Z1Y906sihNfDuPq1lJ2Ukb02ydxxA1OEJ1pvEzY+OxcAV8
 dIEc5q84kOyCkU6/dUqrk7oiBJ1vpxbiapePFRgLsNGON4UmMqBMSOCulKEJfVvPJP
 0k6ElrUB5CL6A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 C8CF8380A95F; Tue, 27 Jan 2026 02:50:05 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <176948220460.657910.7663976493916130692.git-patchwork-notify@kernel.org>
Date: Tue, 27 Jan 2026 02:50:04 +0000
References: <20260126063203.1508295-1-chao@kernel.org>
In-Reply-To: <20260126063203.1508295-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1vkZ9p-0007g9-Bl
Subject: Re: [f2fs-dev] [PATCH v3 1/2] f2fs: check skipped write in
 f2fs_enable_checkpoint()
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

On Mon, 26 Jan 2026 06:32:03 +0000 you wrote:
> This patch introduces sbi->nr_pages[F2FS_SKIPPED_WRITE] to record any
> skipped write during data flush in f2fs_enable_checkpoint().
> 
> So in the loop of data flush, if there is any skipped write in previous
> flush, let's retry sync_inode_sb(), otherwise, all dirty data written
> before f2fs_enable_checkpoint() should have been persisted, then break
> the retry loop.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v3,1/2] f2fs: check skipped write in f2fs_enable_checkpoint()
    https://git.kernel.org/jaegeuk/f2fs/c/ab59919c8a04

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
