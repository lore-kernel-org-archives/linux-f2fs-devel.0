Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C83A7C47DB3
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 29 Jan 2024 20:29:46 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rUYGH-00063D-6w;
	Mon, 29 Jan 2024 20:29:46 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1rUYGF-000637-8d
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 29 Jan 2024 20:29:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=loRevBtUL9WJtl1Gc98MPTvxU4RRtm2Yc6Ms7PKUt8A=; b=Z1s838Ed8cy/sP5T9MuNCNxJPE
 KRlMK+qMjx4qyO4hb2HqYfdo88psgJERJr+mX0etl0Z8ljJ8c+YZuxM6PI6eM5zh0pl1F9+rEmKJd
 kcXzaDVmKhg2aJUcaz67ZkDtacKM41PjhTLy+aWYuKvToMc31bgQz0Oq1YMyKoqzjfWY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=loRevBtUL9WJtl1Gc98MPTvxU4RRtm2Yc6Ms7PKUt8A=; b=eBJBqtDmOQe8+knkoiEz1chz7b
 kwjj77q1xzPO5uKmrt6bqeOAGsiRFh4RSk7rG0DXPr+2DIJpuw8ETXHPa+KeuIq+mNcoS+3L8Lazu
 sB9mJBHB5STc7ZcAmsKIXLKyp5m2IjyF3J2Dt94XTtYNmOoIk+LvkARWHLcz8VzZQGLc=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rUYGE-0008Pm-R8 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 29 Jan 2024 20:29:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id AA21ECE1771;
 Mon, 29 Jan 2024 20:29:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB98AC43394;
 Mon, 29 Jan 2024 20:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1706560171;
 bh=g89ct8LZtexls713Tf32nFxe7xzSJiRvadNHPxIicWM=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=FBEHjpqWS9qGj+DyJdcX9eYqH8PmOWWttK19x159DgXF1ykISdOS+UsRH0iT63Gnk
 rTip+4MKApnoafJoBmKZJ3N16Q8tSmPdfMs8ve/5+2IQ7uKgHB2qG5wDKR8pTMsXBD
 qne3APCSOJALXnU4fSGjsXdhVsQ3ekFwnpXqDRho6zKIQdFD4BsjGq9mfcl3tXRqcj
 9bk7W2HAtvrNfi3N0uPthtC038olY1lyc0H0SdGrKf+8++/8ysah3riKl8hPWoh52t
 lNeHspbjwEYlWhb3sz2Muia5GBHvqzw/2XPVQcq/zA8cW4U/A8lsNKxMPw/S/yMebZ
 W94ICKv4Rzd8A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 C9DF5C00448; Mon, 29 Jan 2024 20:29:30 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <170656017082.16041.17585819028221577977.git-patchwork-notify@kernel.org>
Date: Mon, 29 Jan 2024 20:29:30 +0000
References: <20240112171645.3929428-1-jaegeuk@kernel.org>
In-Reply-To: <20240112171645.3929428-1-jaegeuk@kernel.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
X-Headers-End: 1rUYGE-0008Pm-R8
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove unnecessary f2fs_put_page in
 f2fs_rename
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
Cc: linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Fri, 12 Jan 2024 09:16:45 -0800 you wrote:
> [1] changed the below condition, which made f2fs_put_page() voided.
> This patch reapplies the AL's resolution in -next from [2].
> 
> -       if (S_ISDIR(old_inode->i_mode)) {
> +       if (old_is_dir && old_dir != new_dir) {
>                 old_dir_entry = f2fs_parent_dir(old_inode, &old_dir_page);
>                 if (!old_dir_entry) {
>                         if (IS_ERR(old_dir_page))
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: remove unnecessary f2fs_put_page in f2fs_rename
    https://git.kernel.org/jaegeuk/f2fs/c/fb09ad63d798

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
