Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B548FCFD34F
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 24 Nov 2025 18:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=943WLoH9mzBA5RuldDKE6+WPwd+9IPeRdxyUJN4xjDg=; b=lzJTRC24d3VNYWvaYEtdPmdfdG
	lt8e8nTOBJJMxikmuChjQhxGSYnUo1wo13ST/1ITUz8XzBLKIWIC/zPTaj+tWfqycRXCnRvHsCYBM
	4avNXlvDn2rjf8a1yxKVtch6HXxF+k9zihfWZkb2qtbzjL85V6yaI5FQaaFV8EHL8UwI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vNbeP-0003lh-J2;
	Mon, 24 Nov 2025 18:51:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1vNbeO-0003lT-MO
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Nov 2025 18:51:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NfkTMyNMJhmRhNOWUyOt2+CAd2RmzrbSAEBiuNkZjMc=; b=DF/N4lp/SeLpF6+6+LqW3R0TVu
 JgMLcZeHIL0+7I/8cDCxEos5hVFBkXqm2R6CpRCtvjgm+9YtrmDiqOwmjl8ZdHwbSBsaZRnqb3cMx
 H4HCF6VMvlMeK4im1hytNiVFcH9qSlRoTwlD0QgdChPwl0z6VT7oqU+FGbveMSf526Rw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NfkTMyNMJhmRhNOWUyOt2+CAd2RmzrbSAEBiuNkZjMc=; b=F3Vm2/SQwkRQD2okUehkz2+QG5
 NuTpncFwUk9/Gbf6ex/FWIRSUfan/OMzGlDIOhBVWbA1osPDQ5RanGhYKh8RTHJuhfTDAFJN5xFWL
 3SGRxbmPTq10r8Kre0j2H6DfadkaijFvidzECQP1NQVs/Hx6AXSt/eOH7aiW8IqW4E78=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vNbeO-0002fT-Oj for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Nov 2025 18:51:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 1B55360199;
 Mon, 24 Nov 2025 18:50:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C21C16AAE;
 Mon, 24 Nov 2025 18:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1764010249;
 bh=JodGyJVAuTMIaTL+Pe3dZHLFpnKeoveKGQwrMbmUs94=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=U/bpXGM19oVp1ItoS/U1u14OQL21vk6RbL4ULUZFBWxgsmbUKArtbjXL/xYVfBgZ9
 nlUoN7p2NdYKI/hs6/S24dS4bpQMuioOmKdK4pOyAiD7kKsBgWCiwJNcxPJjGIp9q/
 fuu8i93CLIBmr2UI4sXffpI8Z16WjBZ+Z2z/cxceNvYt5Cwo0OQroGT24rJdwUATLQ
 RVy7wx35qhMa3hWLwG+DVa2xBddHVCNAgSklWLmRnAfX0kQox/COwvomGEGRC9qgfb
 ThfEKCy/2IiupjgFYrod9YDiHTxjDHGWcxDvIcOrZ1FVfTx1MmiH+yNgGle4HuR8AM
 FxNhB+4+wdijA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 EAFBC3A86296; Mon, 24 Nov 2025 18:50:13 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <176401021249.42009.11472621798052596767.git-patchwork-notify@kernel.org>
Date: Mon, 24 Nov 2025 18:50:12 +0000
References: <20251111175246.17202-1-daeho43@gmail.com>
In-Reply-To: <20251111175246.17202-1-daeho43@gmail.com>
To: Daeho Jeong <daeho43@gmail.com>
X-Headers-End: 1vNbeO-0002fT-Oj
Subject: Re: [f2fs-dev] [PATCH v7] f2fs: revert summary entry count from
 2048 to 512 in 16kb block support
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
Cc: daehojeong@google.com, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 11 Nov 2025 09:52:46 -0800 you wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> The recent increase in the number of Segment Summary Area (SSA) entries
> from 512 to 2048 was an unintentional change in logic of 16kb block
> support. This commit corrects the issue.
> 
> To better utilize the space available from the erroneous 2048-entry
> calculation, we are implementing a solution to share the currently
> unused SSA space with neighboring segments. This enhances overall
> SSA utilization without impacting the established 8MB segment size.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v7] f2fs: revert summary entry count from 2048 to 512 in 16kb block support
    https://git.kernel.org/jaegeuk/f2fs/c/9434e14d36ce

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
