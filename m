Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A24A1C3ABAC
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  6 May 2025 15:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n/eJdl4bx2DwBh22/XrA8Q6BAG+RRjO+VBpd2zAQ1lI=; b=b2rkeIdtL4EFoMzlNYdZC3+7eu
	8HBA3XW/MJ/uYxZOG33xsx3lymxsuwNbVN3em75lzXfl1eQ06wRoNfMRGjpeAaZkppUDgZdFSRjaD
	hxvAAlRcl2mrRN0F8lHgeqcie03E/263YUiayVvViczqb5HkGM/Ht0D699qUiHvoFesc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uCKYj-0004Q5-Rl;
	Tue, 06 May 2025 15:50:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1uCKYj-0004Px-EP
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 May 2025 15:50:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FOwpGfsS7D4JwPcjVV+llhwESaTtsJmtlq1a9ML1LFI=; b=SGSguBuOVkL8LBMnfjY41JcEOj
 twMu22ilj8BI48nAj+VvphA0VxbkS1L2yY4f69AeullY6XpVSITaD3VNYUPsFcCPhIa2PfGL6aCk1
 F7vcne032NVB8sXeCou/O7Vz4lXCieImtdNauvLPWx8fMr6jHdXIUVMwychKd0AbC97o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FOwpGfsS7D4JwPcjVV+llhwESaTtsJmtlq1a9ML1LFI=; b=eckhmeEIwABSpdlWBQlUHIvm8P
 UATyCBQMCB301rxxg0r5s2or7bPd5N65hChrtNPDN1ErKiRrqN2ij8i3FXmVkonVi45zfqJYd7/Nh
 OVihpNvQOy6/GO9rMk2wJsr+PZX+LfsIryle2QlJmtRtDOFW3b7Dmsou7Z6lrWKEJPZE=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uCKYS-0001jb-Gv for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 May 2025 15:50:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 3B724629DD
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  6 May 2025 15:49:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2E0BC4CEE4;
 Tue,  6 May 2025 15:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1746546589;
 bh=eZ12zjHqBDv3Di0J7CrGXIw28xIk1srLukArWBz7LOI=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=MPUk0Vu3hFq3XQM2HP84gvHrZ71GqT8bbdRmrdHy6mBsNviIicbHmMElcDoXKzxB8
 P3KL3zWM5FbV4p2UU4twxSrIyF7kneMvPxfEp4sU38YCf2po0CCQdEfQMCAihxQUI8
 YHcE+9UzF+0/z+Y68EOvaK05x96H4zVKlcaBPJFbvxFl8svJ+Qf6ppn+nsyaviKxbg
 Fne4urRU3T8RivPE6q2/km+6Y1Jl/4KZqe99R1d9Ha7ARjPhxmdCczEnVbm4l3jprB
 PxdaXa0mRMfSbIOAK8S9j1pbRXNdk82eQNjp8slt85OO1FwUPMX/fwnnMcSIySNHaM
 65EoRguffqF4w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 33B77380CFD7; Tue,  6 May 2025 15:50:30 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <174654662900.1568197.9643895525173017879.git-patchwork-notify@kernel.org>
Date: Tue, 06 May 2025 15:50:29 +0000
References: <20250506074725.12315-1-chao@kernel.org>
In-Reply-To: <20250506074725.12315-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1uCKYS-0001jb-Gv
Subject: Re: [f2fs-dev] [PATCH v2 1/2] f2fs: sysfs: add encoding_flags entry
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

On Tue,  6 May 2025 15:47:25 +0800 you wrote:
> This patch adds a new sysfs entry /sys/fs/f2fs/<disk>/encoding_flags,
> it is a read-only entry to show the value of sb.s_encoding_flags, the
> value is hexadecimal.
> 
> ============================     ==========
> Flag_Name                        Flag_Value
> ============================     ==========
> SB_ENC_STRICT_MODE_FL            0x00000001
> SB_ENC_NO_COMPAT_FALLBACK_FL     0x00000002
> ============================     ==========
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2,1/2] f2fs: sysfs: add encoding_flags entry
    https://git.kernel.org/jaegeuk/f2fs/c/3fea0641b06f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
