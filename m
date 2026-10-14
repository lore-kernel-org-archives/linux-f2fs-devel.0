Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB45CCC6B1F
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 14 Oct 2026 09:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kSYXkws7hGPErBD8QIYbFja+L9torTWIIF+S+93BJHo=; b=Aej8gPlTTK6p+iSlP0j4nDmfz6
	ZW4y4oLtgjDW5tUIlXom026yTg2v7EwAldhjIo0Ij2PRXf3OI+4X4wXDYJehgMf9YeBgTbkAaLgwB
	U6zjzyIz+WdkJ/Q3r3gkQaLeyJX4vFjsjGlLlid53ueNOulHgrAU9d4x1fLZRo1Hm6K8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGvAI-0006Ep-EN;
	Wed, 14 Oct 2026 09:20:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xGvAD-0006Ec-Kp
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 09:20:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kGHGHp6QNa0VgAuTAZKA8hMvVARdIUWRZNdMkI4zE9w=; b=KxU/zuCjaVZkZa/vyUuJ+ORILG
 NvqYkb8ZB2zmYDb6uljnzGa9CpsKFpgnUSQC3yUkZFbcQ/AuqA/vtIHqHU4c/TVnyT2Sm7lHlYR4o
 IkuXSmhEMkXjQU00sh2FR0gqF5EVnpJCy+bmFgAUd8Xt9VrLC1e4bJKnoE4tIWMyCBg8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=kGHGHp6QNa0VgAuTAZKA8hMvVARdIUWRZNdMkI4zE9w=; b=KB1A8r6sBYvbp0GaJpG8YLFavG
 xMEphgF5yZFHueqjaj1xX8WAsJIKzsokJON190yO7EnCmdN7lkHhnARz07OxMOmMT7OvQD19EHYbS
 4SqzuBglTZo3sKiBdDIf9QEG0rcQwAyStBv/1NzvTBo0f93NFykZ/rmW1cibflb9IxMY=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xGvA9-00042q-IM for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 09:20:43 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 24E7C4074B;
 Wed, 14 Oct 2026 09:20:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01A3F1F000FF;
 Wed, 14 Oct 2026 09:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791969636;
 bh=kGHGHp6QNa0VgAuTAZKA8hMvVARdIUWRZNdMkI4zE9w=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=WyNtmhJ1kvaMlhpaLWGRuGs/8S88Nzc5h2hQzkYELHdkrO5Ka0RI/68uUete9zxWI
 kZPdy9to4Oea/Fm6SB5pLQ1AXAjF/2u8L10RAkZ05CtBm8yBbcVbpF3vi8IUMyiO75
 jURreAiQ0ydw53a0iVxhWNFyzvDvflX441dC2DbKSpAqoB20/yYTCddzIx/lQt2Rds
 8nu5PhzYLtyh2Ej0L1qT9jr0TbKJvZ93TU+Luzi6OFftolE91AAgFhnZ447hZemAfd
 Hbji1vKoqTseZYtoXjwaih1Pi8w7871fzSM9p6pZN5GhUa0sf+Qh8xB7gkzSo+flEY
 GTlxLUgM23qlg==
Message-ID: <9acd8294-bc37-4053-b411-abeb455d11cb@kernel.org>
Date: Wed, 14 Oct 2026 17:20:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20261012182233.2685282-1-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20261012182233.2685282-1-daeho43@gmail.com>
X-Headers-End: 1xGvA9-00042q-IM
Subject: Re: [f2fs-dev] [PATCH] f2fs: return -EIO for a lost inode block
 after cp_error
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 10/13/26 02:22, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> After cp_error, dirty node caches are dropped without being written.
> If such an inode was never written, its NAT entry is still NEW_ADDR,
> and reading its inode block returns -ENOENT.
> 
> f2fs_get_dnode_of_data() passes that -ENOENT up, and callers take it
> as a hole. Since the inode block is missing, the next offset can only
> advance one block, so fiemap walks block by block up to maxbytes,
> about 2^30 blocks, while holding the inode lock. It took hours in a
> power-off recovery test after shutdown and blocked unlink and umount
> on the file.
> 
> Return -EIO instead of -ENOENT when the inode block itself is missing
> after cp_error or shutdown. A missing direct or indirect node is still
> reported as -ENOENT.
> 

Cc: stable@kernel.org
Fixes: 28607bf3aa6f ("f2fs: drop dirty node pages when cp is in error status")

> Signed-off-by: Daeho Jeong <daehojeong@google.com>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
