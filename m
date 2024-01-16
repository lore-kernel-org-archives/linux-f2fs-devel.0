Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A79CC47DAF
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 16 Jan 2024 19:02:35 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rPohm-0001U2-EU;
	Tue, 16 Jan 2024 19:02:35 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <patchwork-bot+f2fs@kernel.org>) id 1rPohi-0001Tv-44
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 16 Jan 2024 19:02:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:
 Subject:Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VBoN6YIZxyX/Rl4L5AdZQU0/FuYoq6ND8kHr0eCIgJ4=; b=EYx53DNn6L3SwyKNiZrPxHURYm
 KUDqpkalS/YAtQAOVmU/OIW9NnNsMsfHJ9H6+EdnyitLEC1dYqCESq8IaIIAvlRedooISkdi03QVO
 FRKWEvU2haECuqgNkJ1oQeTmheU98dCqv832Yx+YzLAtVqwXJe4Al1jaAqBtm2gW1ehY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Cc:To:In-Reply-To:References:Date:Message-Id:From:Subject:
 Content-Transfer-Encoding:MIME-Version:Content-Type:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VBoN6YIZxyX/Rl4L5AdZQU0/FuYoq6ND8kHr0eCIgJ4=; b=jVrjYnw+L3VC+y4uRzaPOuPkSZ
 lFEl4p3MheTZCHdJKhaRt0ZZ1iReXrigLH8APle+7PoCZYgYrXwrmIgyNhZbINaVA49Z+BQzMj++b
 LTXaObgrAtFTwzrAHA0pFdpglK8m2USkB4hZxetMUPM4JjxoiqWLzxSHZ/UWxhgRIq6k=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rPohg-0000aa-Kl for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 16 Jan 2024 19:02:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id ADBD2CE1AD6;
 Tue, 16 Jan 2024 19:02:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E937FC43390;
 Tue, 16 Jan 2024 19:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705431738;
 bh=mabuVMcKVEOkHrK8i9xi5785IUs7iAevURAwnTbEMXU=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=RvIa/26lwIlbwqqv8SuX6pum1MW/EvyookaPicXgkDVOZiD2IsOwbdpjmQhsNGDKp
 pTPuPgMwE+uDSRIUe9P4ZMwqlQ524EwdY+yCajAU00YKnu9c4OgWIjVeyCygUxw6wa
 RDYJOM2tIuPJ08SHsWgdvSbYLYu4UWHt7rX9ket8d+Ij+iOnGERVJ2+52RsAuUhxvM
 URzH61iLqst9J61zwywCH91bZ2Gp0oHchdoh/86AmLtgobJoRvtgxPLfLhd/dgEZHf
 taCdMQpdoAYfi6AMzUGjOl2Fx6O7Q2QnaYtBy8IodNo5BUL027Y0vnDJdY+rMI6GV4
 diJlaZ5k49OoQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id
 CC827D8C985; Tue, 16 Jan 2024 19:02:18 +0000 (UTC)
MIME-Version: 1.0
From: patchwork-bot+f2fs@kernel.org
Message-Id: <170543173883.30188.3991145453418147928.git-patchwork-notify@kernel.org>
Date: Tue, 16 Jan 2024 19:02:18 +0000
References: <20231227171429.9223-1-ebiggers@kernel.org>
In-Reply-To: <20231227171429.9223-1-ebiggers@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
X-Headers-End: 1rPohg-0000aa-Kl
Subject: Re: [f2fs-dev] [PATCH v2 0/2] Move fscrypt keyring destruction to
 after ->put_super
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
Cc: linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, hch@lst.de, josef@toxicpanda.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Eric Biggers <ebiggers@google.com>:

On Wed, 27 Dec 2023 11:14:27 -0600 you wrote:
> This series moves the fscrypt keyring destruction to after ->put_super,
> as this will be needed by the btrfs fscrypt support.  To make this
> possible, it also changes f2fs to release its block devices after
> generic_shutdown_super() rather than before.
> 
> This supersedes "[PATCH] fscrypt: move the call to
> fscrypt_destroy_keyring() into ->put_super()"
> (https://lore.kernel.org/linux-fscrypt/20231206001325.13676-1-ebiggers@kernel.org/T/#u)
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2,1/2] f2fs: move release of block devices to after kill_block_super()
    https://git.kernel.org/jaegeuk/f2fs/c/275dca4630c1
  - [f2fs-dev,v2,2/2] fs: move fscrypt keyring destruction to after ->put_super
    https://git.kernel.org/jaegeuk/f2fs/c/2a0e85719892

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
