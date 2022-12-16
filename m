Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C26C4332F
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 16 Dec 2022 20:42:17 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1p6HX4-0005sD-Es;
	Fri, 16 Dec 2022 20:42:14 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1p6HX2-0005s7-L2
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 16 Dec 2022 20:42:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Uvz+e1S5VIyj/HthbB4tgG7tBcBhu+th6YJE+Wrw8U4=; b=bzU3l3Ma509q3CSTE+yI5dV3tl
 4+NXzt1A9NsuQPAYN4xy8LW+OQK68lf95Bjz6rX4mngABbkR4aCp4AK/92FhK10OibJqNcryfiIIq
 yXwW4Yz53HG7EaaOzE5gOmmnt03sYU1oGf5dD2r23snEsNLDTdVSZ7rAQqAaxLIiQzgo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Uvz+e1S5VIyj/HthbB4tgG7tBcBhu+th6YJE+Wrw8U4=; b=EbcP+qqyrx4btlp/uoH6U8WNze
 lea8QxH/3I3HYtWA5mucMX60vMlyo5XIRCp6I+AM/qbSZp9UvKNDUIODvx1XfVDAgF1biTfPd8D3p
 xdU7zfrRwxe24i7jwTCTmDM2iYtidC+8QSQDEy3sptED+OCzLUWV0cxsMkLjJvLhf+WE=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1p6HX2-001khj-1K for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 16 Dec 2022 20:42:12 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 8242EB81E27;
 Fri, 16 Dec 2022 20:42:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 058C9C433EF;
 Fri, 16 Dec 2022 20:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1671223324;
 bh=EZFmYusjJ/sEsZTKMldpp4cUqNdEDMv0lVSg7WwxolQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pro/xyn5yiR4ycCanHRL+SgLaHAqpiTsjcwVn5yMdwyL3mV2muumSrSukX2XyeSM8
 WwulXIs9qLSwoXVeVhj4QYILoFz3nfA/GRokQPE3dgyhJE0MZfJuxKPDz39bvbfBgu
 TJ4oW00bPtqT5/7NCDAdEcsdXT7hmk2AdEICn8EngifDo5LuTxr2Aq9wikzCMGkDh1
 hNKIdiJUU1OsGWVBBHXLSY/rsyAeoWOh/03mha9ZNrNiBUzexdO0xap66TrSL8JKVX
 0c3a/N/QpVHx+Ayaglv4jgv+96H44zjPWfbnTbqeKus0geZh021kQL1PVnHV5YgJkF
 gS8Q0cuAoiyrQ==
Date: Fri, 16 Dec 2022 12:42:02 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Chao Yu <chao@kernel.org>
Message-ID: <Y5zYGsBZDZ9101zU@sol.localdomain>
References: <20221216155000.3204-1-chao@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221216155000.3204-1-chao@kernel.org>
X-Headers-End: 1p6HX2-001khj-1K
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to avoid potential deadlock
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
Cc: jaegeuk@kernel.org, syzbot+4793f6096d174c90b4f7@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Dec 16, 2022 at 11:50:00PM +0800, Chao Yu wrote:
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index cad4bdd6f097..4bc98dbe8292 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -2336,6 +2336,7 @@ static int f2fs_ioc_get_encryption_pwsalt(struct file *filp, unsigned long arg)
>  {
>  	struct inode *inode = file_inode(filp);
>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> +	u8 encrypt_pw_salt[16];
>  	int err;
>  
>  	if (!f2fs_sb_has_encrypt(sbi))
> @@ -2360,12 +2361,14 @@ static int f2fs_ioc_get_encryption_pwsalt(struct file *filp, unsigned long arg)
>  		goto out_err;
>  	}
>  got_it:
> -	if (copy_to_user((__u8 __user *)arg, sbi->raw_super->encrypt_pw_salt,
> -									16))
> -		err = -EFAULT;
> +	memcpy(encrypt_pw_salt, sbi->raw_super->encrypt_pw_salt, 16);
>  out_err:
>  	f2fs_up_write(&sbi->sb_lock);
>  	mnt_drop_write_file(filp);
> +
> +	if (!err && copy_to_user((__u8 __user *)arg, encrypt_pw_salt, 16))
> +		err = -EFAULT;
> +
>  	return err;

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
