Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04DCEC6FD1D
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 27 Mar 2023 16:00:41 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pgpGz-0005qA-CX;
	Mon, 27 Mar 2023 16:00:40 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1pgpGm-0005pt-GW
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 27 Mar 2023 16:00:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/ZTMZTTQnj911vqwZ0VWMDF1ArJLIunZaKY8pHGkVEk=; b=OtUzTfwxNekgP62EvbVYZ+3pMf
 KGdU83JNTjownLLn8ibK+caVHha7xiWXr2cpbgrdDYlvd38SRUGv4dDkPYvIhUtKOqcI9iNFD0gyK
 4brHhJ80+p98R4C3QMclbr5a2lXhyYF4qOvS6ozEQQ8lAZDZmwOenOYGicTtULLA2rRk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/ZTMZTTQnj911vqwZ0VWMDF1ArJLIunZaKY8pHGkVEk=; b=b1wPOAHwTcDsEpdXASkAXkWdsi
 R9F76PPIz9Sj2EZPhkEZCcT0d1HG6phTKNzm6DccyEehjCzqAQj9pNIVmzS3cOScDULj+7vXY2q9A
 9WDtnoFeU18wOGcYoxl6J5k1hNJYJHSg3iCSTr+uTjPozl/yyLjCZsiK7/5/whCJ8SI0=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pgpGj-00038N-VP for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 27 Mar 2023 16:00:27 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 92EA961363;
 Mon, 27 Mar 2023 16:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0719BC4339B;
 Mon, 27 Mar 2023 16:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1679932820;
 bh=mQ6KWLsxV9NormSx/+1aGLy0yqMY0E4Re/2j1dGBNnc=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=mqwVoAo7jLqQX5r8RxYTCgUELJXI9Uni/abxE6og5FLdlLH8DesMAKHPxrhxjbNWt
 pVxM0Q6MNebwaNxZMX7Jr6XSTBJXy8QiG9imW1HaxMOeRjNEFNWkcSjdZrkoMcOLHz
 Lhr9DF8W3QZYecndjbX4/ew20qw/yTB9klYeo5JJpMeeEgYtRoOqwE32YLDwE9Ob2y
 CGpfcxhnprHdpWgOZXWn9hnX6/JQv+ptmHC4pWrARcpEhMHhfuxw+roYc06wgkfLni
 wjd2O1Ss8fOAZZsrNvOuK32TAdzEbdf8UjdkPlSna4dP4iLkB8Pa/bvSg2qbg0DVGQ
 g0XaqGxRyzxKQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 DB154E2A038; Mon, 27 Mar 2023 16:00:19 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <167993281989.32120.7782788067831740553.git-patchwork-notify@kernel.org>
Date: Mon, 27 Mar 2023 16:00:19 +0000
References: <20230320173137.64413-1-frank.li@vivo.com>
In-Reply-To: <20230320173137.64413-1-frank.li@vivo.com>
To: Yangtao Li <frank.li@vivo.com>
X-Headers-End: 1pgpGj-00038N-VP
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove else in f2fs_write_cache_pages()
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

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 21 Mar 2023 01:31:36 +0800 you wrote:
> As Christoph Hellwig point out:
> 
> 	Please avoid the else by doing the goto in the branch.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/f2fs/data.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: remove else in f2fs_write_cache_pages()
    https://git.kernel.org/jaegeuk/f2fs/c/d2afb3f006dc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
