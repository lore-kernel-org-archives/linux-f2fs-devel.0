Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 066CDC79F89
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  7 Sep 2026 10:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kjZzXin/Jal6/5JoFUUtl5AFgDWp86cn9e2jkA9Iwus=; b=PfAG/j3TO1OIQ/cICr570YYZ0p
	GenzaYEWT0lM6ZHtnbSTUJcR4442U/lyH+1YbtDtr07Y+72k0Jm0PvupYLsHR7xZrzKduShAXDwfk
	HBrK5z6WoNCZRUdHDM+TzEqbP1Gnn6/GZce3RERK7fw8rj5DbuvVrG7/Xtxt7oFu05SY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x3WVN-0006Pa-Ce;
	Mon, 07 Sep 2026 10:23:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x3WVL-0006PN-VF
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 10:23:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=s6i5gTlzacx4tlzxnVzf43YuXi8+VX8VultCr/Bh7jY=; b=OtGc4ZzNIuCLFQNCGpwRUisG06
 hlQxtNsevf4dWSCWebSGevtEpfHCjLX4iKFverkdRw0/CEQDyJ75KfMH2enc2EYCDcDHfJ5XIqikV
 Np0kyG6rTmqx9F3to+T+rta/vx3ASL3blGIhPBWxPfCL3PCI2tHGx7NMisjuKr0SevDg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=s6i5gTlzacx4tlzxnVzf43YuXi8+VX8VultCr/Bh7jY=; b=X8hL15pYsjV1OhLR2e6m4MEfJA
 g0d7R4dJ/eWtKrgOe2+tgZSwZ1Jyp4h/du/iMTaDq03Ztc6du4wegOtnnWkOqP2BqPwtFAYjy9Pgg
 kB8mfDQyGQu4CFJ5JrDJhqoLga+BokzGhFKlYgvNcCtixBgxeSC0JdQA9nXzDAMtSC6E=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x3WVL-0001N8-A2 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 10:23:12 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A57DE601F9;
 Mon,  7 Sep 2026 10:23:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60BDE1F00A3A;
 Mon,  7 Sep 2026 10:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788776585;
 bh=s6i5gTlzacx4tlzxnVzf43YuXi8+VX8VultCr/Bh7jY=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=bjfVB5YA+9bBQbOCfv5RYwcgTL5DOHs9/KcA8It6jg6fiobBGR6cG3UJmoOmlJf5p
 GOElVkZMTkpdjigW/9SQFo+cavKq7NBDHE47kckEX69fIV7KU/xuo66K4fMkYwfOxv
 JKDBF8xwOIRB/DIHhHzqFv0UZ/x/aatIKeK7JRtlCdYrpn4viJvZFQGckAgeAGu94Y
 Naz6z2v4ivSlkmabt5FZiftdu4rcFaDhLjKKs7psgjMFmOmo+DayAvjosneJNxZajp
 h8lhMMeNwvBOGh6v07NS2GHaISzJ/SYq0DU9DU+94/rIezR9KyMUN/quUHv3RF2YJK
 PjzR1d56//SyA==
Message-ID: <90c7fbe0-3f06-48a1-a9df-6b9ae6a3d9d1@kernel.org>
Date: Mon, 7 Sep 2026 18:23:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20260904145923.1936598-1-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20260904145923.1936598-1-daeho43@gmail.com>
X-Headers-End: 1x3WVL-0001N8-A2
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix livelock in f2fs_sync_inode_meta()
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 9/4/26 22:59, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> During checkpoint, f2fs_sync_inode_meta() iterates over dirty inodes in
> the DIRTY_META list. If igrab() fails on an inode (e.g. because it is in
> the freeing state), the loop continues without moving the current inode to
> the tail of the list. As a result, subsequent iterations pick the same
> inode repeatedly, preventing other ready dirty inodes in the list from
> making forward progress and leading to a livelock.
> 
> Fix this by moving the current inode to the tail of the list
> (list_move_tail(&fi->gdirty_list, head)) before attempting igrab().
> 
> Additionally, if igrab() fails, the freeing inode may be waiting for its
> pending writeback data pages to complete during eviction.
> Submit any pending merged data writes and yield the
> CPU with cond_resched() to allow the eviction to make progress.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>   fs/f2fs/checkpoint.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index ef22692cef0a..5597033533b0 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -1460,6 +1460,7 @@ static int f2fs_sync_inode_meta(struct f2fs_sb_info *sbi)
>   		}
>   		fi = list_first_entry(head, struct f2fs_inode_info,
>   							gdirty_list);
> +		list_move_tail(&fi->gdirty_list, head);

Seems fine, if so, do we need to do this in f2fs_sync_dirty_inodes() as well?

>   		inode = igrab(&fi->vfs_inode);
>   		spin_unlock(&sbi->inode_lock[DIRTY_META]);
>   		if (inode) {
> @@ -1469,6 +1470,13 @@ static int f2fs_sync_inode_meta(struct f2fs_sb_info *sbi)
>   			if (is_inode_flag_set(inode, FI_DIRTY_INODE))
>   				f2fs_update_inode_page(inode);
>   			iput(inode);
> +		} else {
> +			/*
> +			 * We should submit bio, since it exists several
> +			 * writebacking pages in the freeing inode.
> +			 */
> +			f2fs_submit_merged_write(sbi, DATA);
> +			cond_resched();

It uses the same implementation from f2fs_sync_dirty_inodes(), after git blame on
it, the implementation was introduce long time ago, I suspect we don't need this?
because in .writepages, we will submit cached bio anyway, right?

Thanks,

>   		}
>   	}
>   	return 0;



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
