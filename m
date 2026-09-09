Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0214C79FB6
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  9 Sep 2026 11:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f9vaOEzVKBCe8+huWYCT7+YUsrXIecgkZN2iIHhihgw=; b=C48WeJao+4P5SuVa/WYgM3TFqk
	WQ1raCpiyPzQrIHp4Ya1XqUBVLcdHshiZ1ik58vcuu8eivfossczbwWepFeAgKQmYDINGGRB28FMw
	IiWVHW/v3zYhATVaxNr1QIelR2EYkjrS+2y0i3uvHuG/rfLESbKZGlMuQTG+E7qxo2E0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x4GHY-0005V6-3N;
	Wed, 09 Sep 2026 11:15:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x4GHW-0005Uz-LH
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 11:15:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kzsodF5Nsot7Y0PHwdjnqA443YA97pVezXspWWQVw5g=; b=MI5lj0xaFrIA+IUjvjvrvVv4KJ
 1oz5INi+OkhPbc8QxJ5EK5kviO8Ytg/nmpIwMDp5gmB4jWA9/91E6GzF+qQL1L7erduS1z3rPVbK4
 ktLPdI1mT12CwM7tQF7rKZPV1QJMj/OnnPWxKIMmSM0lBGH5yoNGFmZ9YtXlhDSTrwOk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=kzsodF5Nsot7Y0PHwdjnqA443YA97pVezXspWWQVw5g=; b=LNSIyrfRXC/+XH9zxLpr8G2XFp
 Nyfzp8DHDtGIO029t+GnhKFKj+UsMOnOi9YZXmkiCXYmV2pRpTjHdGgsqQvbjc7vXUcGB2C3S0V2d
 YlB0F6PMT0b6CqfkE999M3FX2QNze5eWu8L2HfWcyzqzhIeqiJPn3a8+wmBeLfUwgD+E=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x4GHT-0006z8-8E for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 11:15:56 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5AE48601FE;
 Wed,  9 Sep 2026 11:15:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 644421F00A3A;
 Wed,  9 Sep 2026 11:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788952549;
 bh=kzsodF5Nsot7Y0PHwdjnqA443YA97pVezXspWWQVw5g=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=W//omHMRrw3ntFwbtmS4iHRrZ63LZkcnaTDAqgFgs3Q3y4m67tFu9EARlvFBrh0LQ
 Hy3fun0lLiUCZ1H1J5IgJnWhc6arr1z+VRsF7gg4ZGcMee4ILX4lji0B7H5ZbRpQBR
 zL/g9LXBPWOrdsaaSCXKn6KSBuwyJNYHT9flS2Lsc6Pyx0DQUPI0hB9Q3u7wwebQfT
 MDVmIe1kdmQ7No4H5ZHwXw/DDrBnTfmItnyR6fVyybKj+caBRT/Fg0xg9ieSC9fNJg
 QK+Ix86UHxjkUCyU4wx2EM2Rh1pSaY8sF4SmSy0Guju92QOG4lAGeDKygx5QegUFvO
 GI0eSJ4kAZUlg==
Message-ID: <9c971fe8-1f78-44a6-94a2-786555da6a05@kernel.org>
Date: Wed, 9 Sep 2026 19:15:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jianan Huang <jnhuang95@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org
References: <20260908034630.615415-1-jnhuang95@gmail.com>
Content-Language: en-US
In-Reply-To: <20260908034630.615415-1-jnhuang95@gmail.com>
X-Headers-End: 1x4GHT-0006z8-8E
Subject: Re: [f2fs-dev] [PATCH] f2fs: quota: fix stale lock holder on
 remount failure
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 9/8/26 11:46, Jianan Huang wrote:
> F2FS remount can fail while duplicating a journalled quota file name.
> 
> f2fs_remount()
> - sbi->umount_lock_holder = current
> - kstrdup(F2FS_OPTION(sbi).s_qf_names[i])
>   : fails
> - free previously duplicated names
> - return -ENOMEM
> 
> The direct return leaves umount_lock_holder pointing at the failed
> remount context.  A later checkpoint may then wrongly treat another
> context as the s_umount lock holder.
> 
> Clear umount_lock_holder before returning -ENOMEM.
> 
> Fixes: eb85c2410d6f ("f2fs: quota: fix to avoid warning in dquot_writeback_dquots()")
> Signed-off-by: Jianan Huang <jnhuang95@gmail.com>
> ---
>  fs/f2fs/super.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 1314b6ccced9..e249ea19beaf 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -2864,6 +2864,7 @@ static int __f2fs_remount(struct fs_context *fc, struct super_block *sb)
>  			if (!org_mount_opt.s_qf_names[i]) {
>  				for (j = 0; j < i; j++)
>  					kfree(org_mount_opt.s_qf_names[j]);
> +				sbi->umount_lock_holder = NULL;
>  				return -ENOMEM;

How about adding restore_holder label, call goto restore_holder here?

Thanks,

>  			}
>  		} else {



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
