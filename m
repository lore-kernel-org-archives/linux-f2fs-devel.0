Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4114C88E50
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 14 Sep 2026 06:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pUHJZm0SgeSDFmb0fcs2d5uSQECESbLdAMmQgk0KsOo=; b=aOj8zdFG3PygGM4Ku7DrWoDbUx
	033wJNjIerILwcjEMStsOfyoZv8GXU4Pk+qS9QZ59Ww+xnxt2g03YscNG4fLx0R8bHAqylh2cLyv9
	LoPn6BxLfjb/oGY4lbVqyPqj4/2x0PHLrbx69NlEsKaDddxS37r0syLL58S/ri1sVBjs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x5zs3-00065F-N7;
	Mon, 14 Sep 2026 06:08:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <joseph.qi@linux.alibaba.com>) id 1x5zs2-000652-Fc
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 06:08:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DGCUqYpSgp6dwqHfummvsIu0f3GHTB/sFbpAB8I2TaM=; b=Tt2eoVUoROAnqVTBAWCBvHMUC0
 aGLKnqTh0ALcfHewTreav5P2wfCNrM2GC/dCBYSKuyHpruPzNLZqhp80I8FeG+8kawmGfUgRWFHfY
 omITclTXA5HqNFb2gHEEiVcpe6jQTlAJm/JUSr50WZa5MbTsdKGiHQ0ei2uWgSicFaho=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=DGCUqYpSgp6dwqHfummvsIu0f3GHTB/sFbpAB8I2TaM=; b=Dhbrlb10XQVNnB4EqG4jhFL1a/
 k5lFdXznysrZC/fMpYWjVHYOPChSmGae7vofFDnxDA/DNxx7RYfku/1a8930Bk9fJ6wJics+GzAzv
 35KUACen2S+fktvwZdcbyF07efDxYmQeQ9+WTIM4wjoRY73PDag94o6/eZW7MAGGhkqY=;
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x5zs0-0003yZ-9J for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 14 Sep 2026 06:08:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1789366120; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=DGCUqYpSgp6dwqHfummvsIu0f3GHTB/sFbpAB8I2TaM=;
 b=pWS8KWISct1yncqfbYEhgHMHcg03YP/XKVTNJaq6reZBK/WbRpV4MWoJPNctM6wUDN2t4nPEaTOXmBZf9g9IfHlGDpCrMBK8L1RYjfuZ3pNgR1TwYIsbo6N59GOmhbmWgPf/5C1LZyRE38oi20Sr1TtvhKN8dL3oiL0JGTviRTM=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037033178;
 MF=joseph.qi@linux.alibaba.com; NM=1; PH=DS; RN=12; SR=0;
 TI=SMTPD_---0XAqpvuP_1789365183; 
Received: from 30.221.129.199(mailfrom:joseph.qi@linux.alibaba.com
 fp:SMTPD_---0XAqpvuP_1789365183 cluster:ay36) by smtp.aliyun-inc.com;
 Mon, 14 Sep 2026 13:53:03 +0800
Message-ID: <c11b5a78-a1d7-4618-beab-dda967863f50@linux.alibaba.com>
Date: Mon, 14 Sep 2026 13:53:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Farhad Alemi <farhad.alemi@berkeley.edu>, Mark Fasheh <mark@fasheh.com>,
 Joel Becker <jlbec@evilplan.org>
References: <CA+0ovChT6BRXp0kntaJ_Eiw-2-z=fpofsvyALiwdORe3zG_YWA@mail.gmail.com>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <CA+0ovChT6BRXp0kntaJ_Eiw-2-z=fpofsvyALiwdORe3zG_YWA@mail.gmail.com>
X-Headers-End: 1x5zs0-0003yZ-9J
Subject: Re: [f2fs-dev] [PATCH] ocfs2: don't let the root inode outlive a
 failed mount
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
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, ocfs2-devel@lists.linux.dev,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-fsdevel@vger.kernel.org, falemi@asu.edu
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net



On 9/11/26 5:47 AM, Farhad Alemi wrote:
> ocfs2_init_global_system_inodes() installs osb->root_inode before the
> second ocfs2_iget() runs, and when that iget fails ocfs2_initialize_super()
> jumps to out_dlm_out, which sits below out_system_inodes, so
> ocfs2_release_system_inodes() never runs and the kfree(osb) that follows
> makes the stranded root inode reference unreachable.  ocfs2_fill_super()
> strands the same inode a second way: nothing drops the reference igrab()
> takes on osb->root_inode when an out_dismount path ahead of d_make_root()
> is taken, so the ocfs2_release_system_inodes() call inside
> ocfs2_dismount_volume() cannot free it and the root inode stays hashed on a
> superblock whose ocfs2_super has already been freed.  The reported KASAN
> slab-use-after-free write hits an ocfs2_inode_cache object that
> ocfs2_release_system_inodes() freed during teardown, so an ocfs2 inode
> reference that survives that call is a lifetime error on those same objects
> and not a bare leak.  Release the system inodes at that failing
> ocfs2_iget() and drop the igrab() reference on out_dismount, clearing inode
> right after d_make_root(), which consumes it on success and on failure
> alike, so it cannot be dropped twice.
> 
> Closes: https://lore.kernel.org/all/CA+0ovCjAKQMn7iF8BJR-3+G9_HBRnRFtJxjr-9P9GuKSxFj+3Q@mail.gmail.com/
> Signed-off-by: Farhad Alemi <farhad.alemi@berkeley.edu>
> ---
> --- a/fs/ocfs2/super.c
> +++ b/fs/ocfs2/super.c

Seems it is a corrupt patch?

> @@ -450,6 +450,7 @@ static int ocfs2_init_global_system_inodes(struct
> ocfs2_super *osb)
>  	if (IS_ERR(new)) {
>  		status = PTR_ERR(new);
>  		mlog_errno(status);
> +		ocfs2_release_system_inodes(osb);
>  		goto bail;
>  	}
>  	osb->sys_root_inode = new;
> @@ -1110,6 +1111,8 @@ static int ocfs2_fill_super(struct super_block
> *sb, struct fs_context *fc)
>  	}
> 
>  	root = d_make_root(inode);
> +	/* d_make_root() consumed our reference, on success and on failure. */
> +	inode = NULL;
>  	if (!root) {
>  		status = -ENOMEM;
>  		goto out_dismount;
> @@ -1163,6 +1166,7 @@ out_dismount:
>  	atomic_set(&osb->vol_state, VOLUME_DISABLED);
>  	wake_up(&osb->osb_mount_event);
>  	ocfs2_free_replay_slots(osb);

Please rebase on top of the latest linux-next.
The above 'ocfs2_free_replay_slots(osb)' is removed.

Thanks,
Joseph

> +	iput(inode);
>  	ocfs2_dismount_volume(sb, 1);
>  	goto out;



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
