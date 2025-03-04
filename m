Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E47C021B8
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  4 Mar 2025 17:10:26 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tpVmj-0006Hj-Ld;
	Tue, 04 Mar 2025 17:10:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1tpVmg-0006HZ-4C
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Mar 2025 17:10:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=O0JSyIuWE+u6XHXR8gkDeAm5XglbkciKsgNW99//JY8=; b=m2mOwcZEKm88Aqb/s4KiPpXDCc
 XFu7f6NWuxaoYWA5S0MpwA7UTtiayrD4HPEevlpxkzJpVnQKveBtdw5NFCqQQvxtLnOTW6oJWUGj9
 RCnfDeFYJBpOWl1J7Kv0MOTU1AsRBIxOElx52Q5f0vHvD5zcjRicoTuJYTAUo3JY7cls=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=O0JSyIuWE+u6XHXR8gkDeAm5XglbkciKsgNW99//JY8=; b=UUPxbUdbRYGyDSWNrbocNXwuwx
 PDtx7A9KaGL/TLfFJN0QfwmGeuJHwZDAsshCxXa1m+RkoF3AAE5zUQLoesUP612UxZPZBJh/7y7Tg
 plSzcqjqaPwYjUJfavhhndWSQgy/tcjoeo+45PAW/9vIx1jR6EBSrkMr16feP+kaVtWQ=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tpVmf-0004nv-R4 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Mar 2025 17:10:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 15E32A459ED
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  4 Mar 2025 17:04:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FFC5C4CEE5;
 Tue,  4 Mar 2025 17:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1741108215;
 bh=o43ff7R4e3i7w6mMMmeiN5+e4slUZu+u/De0cuXcQOg=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=hfjNTE+eToFjy7+bAUje04CdMveohZzVgbytFafuHToqn3jeT9uemTB+93vHWPLk/
 DeZGSkHmw1huQ/PhYeFkhrQvJN/GS7uSPXhaxOGz9W7cDrQhvueQ3optJ6MbFKi35r
 2K1O5W7s9pKkoFzcH+HrLcQnt/0YJ9AoKf6c0SSX4HsENdODfuNb3H3XBMez3RNNlB
 4bMv9WGtdRqo1JBVYSTCpIAkVsTLmXO951Sj64/bjS5dLpwiytIyqpArYBBxox+/sm
 0CSMBbxNPkVZwQpgrS8utkkvqlqCdPYJy/coaurn4QQvxQxAzz+y/O5z9Oiaz3xFmG
 SM99zlZ7q6ekg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 ADF79380AA7F; Tue,  4 Mar 2025 17:10:49 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <174110824849.224349.8255576653519442579.git-patchwork-notify@kernel.org>
Date: Tue, 04 Mar 2025 17:10:48 +0000
References: <20250303035423.1357211-1-chao@kernel.org>
In-Reply-To: <20250303035423.1357211-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
X-Headers-End: 1tpVmf-0004nv-R4
Subject: Re: [f2fs-dev] [PATCH 1/3] f2fs: do sanity check on inode footer in
 f2fs_get_inode_page()
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

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon,  3 Mar 2025 11:54:21 +0800 you wrote:
> This patch introduces a new wrapper f2fs_get_inode_page(), then, caller
> can use it to load inode block to page cache, meanwhile it will do sanity
> check on inode footer.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/data.c   |  6 ++---
>  fs/f2fs/dir.c    |  2 +-
>  fs/f2fs/f2fs.h   |  3 ++-
>  fs/f2fs/file.c   |  2 +-
>  fs/f2fs/inline.c | 22 +++++++++----------
>  fs/f2fs/inode.c  |  4 ++--
>  fs/f2fs/node.c   | 57 +++++++++++++++++++++++++++++++++---------------
>  fs/f2fs/node.h   |  6 +++++
>  fs/f2fs/xattr.c  |  4 ++--
>  9 files changed, 67 insertions(+), 39 deletions(-)

Here is the summary with links:
  - [f2fs-dev,1/3] f2fs: do sanity check on inode footer in f2fs_get_inode_page()
    https://git.kernel.org/jaegeuk/f2fs/c/770648dd6abc
  - [f2fs-dev,2/3] f2fs: do sanity check on xattr node footer in f2fs_get_xnode_page()
    https://git.kernel.org/jaegeuk/f2fs/c/1078ec609e0a
  - [f2fs-dev,3/3] f2fs: introduce FAULT_INCONSISTENT_FOOTER
    https://git.kernel.org/jaegeuk/f2fs/c/4116a6f1172c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
