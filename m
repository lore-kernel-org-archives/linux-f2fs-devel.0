Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58424C761AF
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  5 Apr 2023 16:20:41 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pk5sG-0001dm-0S;
	Wed, 05 Apr 2023 16:20:39 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1pk5s2-0001dd-P8
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Apr 2023 16:20:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=L1mJE0CJ3udTfc4KM+3kbMH+u/yDlCvLWVOCIykPizs=; b=EDu7D33fMV4poUOei9dmKkoczP
 Wb0oJ3yIfzDW+Jwby19/LKl7EOJAqUYnJuGCFijgV1mGcobLt5Frm5WvN9pXSH6hEdN7IixXdmb9r
 Kj5o9DMDl80K5b5PqoQ67mySMWMfMIz+2MADN9cw3Xg0Ni/wkq97P4lcXckeI7KHSJTA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=L1mJE0CJ3udTfc4KM+3kbMH+u/yDlCvLWVOCIykPizs=; b=P+SxpQC45LtrhWFhPVjgS12AYm
 mvgqWvqaxLZgKDAHDWKP/drVyCNaYRaAC8XzXeOFVylFA5clVSAyxS30iticnSxxgolBshkTkMqH+
 Eg/JVku6+H+wB+nmbfOUVLv2KM8d3uvO2PSUPER+Kr3wrVWDGFnU3icJQfEJYhJkLUxo=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pk5s1-00G8Pu-DD for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Apr 2023 16:20:25 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 09AEB63F97;
 Wed,  5 Apr 2023 16:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 907E0C433D2;
 Wed,  5 Apr 2023 16:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1680711619;
 bh=aZWL0zcs3q9581Ru8j7YepShZdC8rcoI7ccdq3wCk7Q=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=Ev6VZsHiFwhR6SZiZ1go6umII/WSNGCYiKRdwjHVDNVrq8coT/DwXUOIMPH3GMovB
 6OvhWBQUNMVOZ00ktWyJRzZzI62QyMLn76WDRBasoX0VL0FfOw/qZtIY6pnx9gP7wA
 tDvQJ0BlYKC0SfxwT1C4OQVGnyDrZar8QO1VNGCmI3H7aaT/rAQ2iB1X3V99+BA4BE
 ounUHEFza5GwcP81/r9BmLVwPOuYgstezHyT3DTTx7I9XDqTE4pNhcWFGzVeO7QUZw
 hTBJ1fBsQ4HuJUJY7CQNYqPN5xSdz4EEyfvVxjHIMRqbANa3uIUIIZ6zvMEBTjrGYL
 6DgX4YmlsPbEA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 6EAEBE29F4C; Wed,  5 Apr 2023 16:20:19 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <168071161944.13885.1835796747309052831.git-patchwork-notify@kernel.org>
Date: Wed, 05 Apr 2023 16:20:19 +0000
References: <20230124153346.74881-1-frank.li@vivo.com>
In-Reply-To: <20230124153346.74881-1-frank.li@vivo.com>
To: Yangtao Li <frank.li@vivo.com>
X-Headers-End: 1pk5s1-00G8Pu-DD
Subject: Re: [f2fs-dev] [PATCH 1/4] f2fs: fix to check lz4hc compression
 when CONFIG_F2FS_FS_LZ4HC is not enabled
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 24 Jan 2023 23:33:43 +0800 you wrote:
> f2fs supports lz4 compression algorithm and lz4hc compression algorithm,
> which the level parameter needs to be passed in. When CONFIG_F2FS_FS_LZ4HC
> is not enabled, even if there is no problem with the level parameter, add
> the level parameter to the lz4 algorithm will cause the mount to fail.
> 
> Let's change it to be the same as other compression algorithms. When the
> kernel does not enable the algorithm, ignore this parameter and print msg.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/4] f2fs: fix to check lz4hc compression when CONFIG_F2FS_FS_LZ4HC is not enabled
    (no matching commit)
  - [f2fs-dev,2/4] f2fs: introduce f2fs_set_compress_level()
    (no matching commit)
  - [f2fs-dev,3/4] f2fs: set default compress option only when sb_has_compression
    https://git.kernel.org/jaegeuk/f2fs/c/338abb312bb2
  - [f2fs-dev,4/4] f2fs: merge lz4hc_compress_pages() to lz4_compress_pages()
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
