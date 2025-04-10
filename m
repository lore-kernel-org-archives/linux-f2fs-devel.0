Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 517C4C369A2
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 10 Apr 2025 04:10:35 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1u2jFK-0004SZ-Vv;
	Thu, 10 Apr 2025 04:10:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1u2jFI-0004SO-9D
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 10 Apr 2025 04:10:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Itb9S2i4xI+OP8s3mLNv+Fe7yyZzFjVI1iwsTnZlL4o=; b=DvFGvVYSkjVJCso8SR2/UnF1y+
 DgHY/Kk2sSjkj9LPcC77WuP/NE7qFU2BC9ESJ+ZbCGcxcGMrpDuIIzfmrcoods7F6YVihitIkiAfR
 NcKpZf7aJwfMT9+eEQlQDATVoexq8AXrUOtD74GcqzlNxsIEB07lhWmx3udKsjtYzgg4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Itb9S2i4xI+OP8s3mLNv+Fe7yyZzFjVI1iwsTnZlL4o=; b=OEzvD6NOSHzwXbquRGHXHs+fQu
 5+8K7n7EkhQmhVKVm7KIttFb6jolWrak/w0LLqkLsYQhreMnajf6V961incil9MCtTrPXHJKF8+Er
 AMl74nURmRj3n7QScgUL+jWgahRIZLy0A7xvAGZf6v3PKPHMhQUUx16ssU8dSsSQGag0=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1u2jF2-0001BE-Lj for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 10 Apr 2025 04:10:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 4734D5C4839
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 10 Apr 2025 04:07:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01550C4CEE7;
 Thu, 10 Apr 2025 04:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744258206;
 bh=4p3yZGio0+JmEDeC3I1vg0WzBBGpTFEUG+ffAl8vBHY=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=XzOkXQ+OczmzYOhLU4GZE0Enlu4obPFA0t/CqPOZCtbWcVhXoUarYfHbIYrNnlned
 exVxyO3/i1RClIcg5TxqgpV0GY1uj3sQYklQGla1B3V2TXd6XN1upm3d6WUYGn2YDJ
 dxMtssQ4iBjGwNM9XjblaPU0kN+pH4OFQadIV+BwiRRS1MJJmYTp1bChz2Akc2SIdL
 iVqfZpCukAYnYsC7DwrFaHFaMZGtsFRZedRiaQQ5cbM2QDxyDvnWSsdExujlfVhqi2
 mRXfs6ziZH7oMMt9vd3w29CrJk/nwRJKq/3GSDdk8qrDtAnobqVpWJS+pCbvUzT1AF
 wyNzfsOIdSn6A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 AFEE2380CEF9; Thu, 10 Apr 2025 04:10:44 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <174425824324.3146257.5905240460714241390.git-patchwork-notify@kernel.org>
Date: Thu, 10 Apr 2025 04:10:43 +0000
References: <20250404195442.413945-1-jaegeuk@kernel.org>
In-Reply-To: <20250404195442.413945-1-jaegeuk@kernel.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
X-Headers-End: 1u2jF2-0001BE-Lj
Subject: Re: [f2fs-dev] [PATCH] f2fs: clean up unnecessary indentation
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri,  4 Apr 2025 19:54:42 +0000 you wrote:
> No functional change.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/segment.h | 40 ++++++++++++++++++++++++----------------
>  1 file changed, 24 insertions(+), 16 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: clean up unnecessary indentation
    https://git.kernel.org/jaegeuk/f2fs/c/05d3273ad03f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
