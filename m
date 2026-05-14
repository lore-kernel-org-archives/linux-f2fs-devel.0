Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DA50CD4F39
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 14 May 2026 23:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Date:Message-Id:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fOecIjTpb459EFPveyi1iuABYI2aBLf9RaFmx0KKKtY=; b=g/zMkXXyi2tnA6ex1YodjwDiVc
	vyk1qy9hO13Ksi1Yyr9LgoZja+9AYrHxICc+iNx7iUkTC7/3932Xb/M1iTN9ZlivWIXe0swEc0mPr
	uqs1A/Y2zUpyUXm8Sb7AIbx8noS8QV4+lMdbcT0j35AQyu44XyTSOpE8P0+Sg5rQkl5A=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wNfWO-0004Sb-PN;
	Thu, 14 May 2026 23:31:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1wNfWN-0004SU-1a
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 14 May 2026 23:31:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DZLqVviwA6u83Ef9dmYjjvF12wB8FvHMipCTRm0SijQ=; b=B5gW04eaNWiWopX6Y4zpZM/zc4
 ZwqevDKN8jCwttGxBjdcrARbBttg6eL4wIlj37JhGrDCLfLF+ZvPa/FVdiG7dQc3xFUpwyTqIATFB
 nuVdCIZ8aPYA9lAUOxNoILbYpS3woKu3usuoOX63bs/xUMkuoYkTsQx1m9d295Oe85zk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DZLqVviwA6u83Ef9dmYjjvF12wB8FvHMipCTRm0SijQ=; b=YrEjPvc1Pxdy/qgWZ6vhrB8oMX
 AwtucmkbFjWKE1EXpy0aMuK2hDcV0ojY2RjKwmLs8lSD0EyXVMXO9H9wCei7O4w7enUAkIB8YTC64
 XBPG5j1SpzEkN6V8306BswKx67pKWPF6OG0RVsl69mXYZkAQIp0IMDrrVJsbXhHbyLPc=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wNfWI-0003X2-Iq for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 14 May 2026 23:31:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 36D3B60008;
 Thu, 14 May 2026 23:31:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE930C2BCB3;
 Thu, 14 May 2026 23:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778801459;
 bh=wKoY/Q5JQwc/3CahBN8P8WJGfZjwq89iaj6tdGfqlrI=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=L3XEkfwXA0hSrc1gtg1e7fkQZ93jNUjQ6Wt4RPlmd3Fsxght3mX6PUmJo7lEwzF8m
 ZskgJqacsEWMUP0fBw+sOeIs1bDcMZzniRX/gOl4WHF5pReQVF+3buJhgLGI7CnbFQ
 DMyN/hCEDT6dgGYgcka78QiOFFuwDqmnsdiaevx4Q+RrpcZsEwhYKjgqdpCAxz61Pj
 R/68yxwnRqzBoA2Gwh5NWmdGnpUxAUT0wKwB7TbZdFBF0CeITveGQO/Kbn00YQ7JRO
 B8st+nFfgD9LV9zfNLhOpkI9k+UmcIIVooLTqHoA9DcT4yNQGGACgq+0ncVhVteoZi
 rHdrL7wXLEGjA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 B9DE439E4DB3; Thu, 14 May 2026 23:30:05 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <177880140455.123857.24496031393456526.git-patchwork-notify@kernel.org>
Date: Thu, 14 May 2026 23:30:04 +0000
References: <20260514205513.1464863-1-daeho43@gmail.com>
In-Reply-To: <20260514205513.1464863-1-daeho43@gmail.com>
To: Daeho Jeong <daeho43@gmail.com>
X-Headers-End: 1wNfWI-0003X2-Iq
Subject: Re: [f2fs-dev] [PATCH] f2fs: optimize representative type
 determination in GC
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

On Thu, 14 May 2026 13:55:13 -0700 you wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> In large section mode, do_garbage_collect() previously determined the
> section's representative type by looking only at the first segment of
> the section. However, if data was fsynced into an area previously used
> as a node section, and this area is recovered during roll-forward
> recovery after sudden power off (SPO), GC would incorrectly assume the
> section's type based on an empty or obsolete first segment. This caused
> the recovered data segment to be misunderstood as being stuck inside a
> node section, triggering false inconsistency panics (Inconsistent
> segment type in SSA and SIT) and subsequent mount failures.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: optimize representative type determination in GC
    https://git.kernel.org/jaegeuk/f2fs/c/f8f9d0045df5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
