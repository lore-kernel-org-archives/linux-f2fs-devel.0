Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C66F7C5DF7D
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 19 Aug 2026 02:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D9PL0TLXKBAxkTzMFZ/nmW4ksdLcMHmfHx71ksRz/pc=; b=SgZLCAahYr8Qom6pWefumw9jtW
	OCLRDAU4bXlG8jNfyiJVt1kiaD1Z/+vpUo55vzlgf36U32nTkZKP1NNggeAD2KR6tqeCDo1rgrMcw
	O8VEgVpfSVkouTB2FcyV7Vo1D+Z5boOOw1t6ker7ou5qahI+lpCA9hvpUua/B3M8Xn+k=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wwWU7-0007Z4-I1;
	Wed, 19 Aug 2026 02:56:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wwWU6-0007Yw-4S
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 02:56:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xLwKJgu85Wnk2KX65yrhATcj9Q4UfxUVdXevuIpfB0M=; b=JHt4wXWTkcpMJVh42h+zs4xr50
 Ay/y3hX7BfV6Pm36MEeK0u1AES1sCOpbgzH7DPPLabYwS7YngnmwY++kvYSH9LdYG2Hklj0cZ4crJ
 ADA60MvY1/PSzF2iup7cVPMeRbHNhZLtKx9h9xx8cNXtkxO1uVJO9EK6m2ObAYu2OaRc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=xLwKJgu85Wnk2KX65yrhATcj9Q4UfxUVdXevuIpfB0M=; b=TUfNiLraZcu56WHFuNeZdIzZeo
 Lifie8Qj6GShaCJri4RDsfEawVUeK1ci6y/Xuy0xRdwjaadVBY7PgDbcMf2HNTZbKA5QlxepGJSgU
 a1joEUWaaJaCrgyrO0fhJzpCLNeEUmsIMMGXRKRGoBrb/Vdbj+CsycrjBiwqE6jMZDAw=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wwWU2-0002iR-7R for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 02:56:55 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D1CCE601FB;
 Wed, 19 Aug 2026 02:56:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C01321F01558;
 Wed, 19 Aug 2026 02:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787108207;
 bh=xLwKJgu85Wnk2KX65yrhATcj9Q4UfxUVdXevuIpfB0M=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=H6mRy30qMzG8evoDYfFQT5j+F9MMXq3xjhSHHrNm6vGuFkdTIyigpfkB8AZTYamC9
 iBYv+tSAg/wtwWUBOsB+ZEbn4tpBuaUk6chObKjK8OAem0MnLXGnJwzOmJhQFzcUfg
 o9eL91vI4UkgSj1Hh6Moe+2fBj9Vthv7SvIIhm/ou8WpauS/VBsaby0OnxTsUjaZzI
 +1RCs3Pqw4XsN93WBJv45YRywznw7lgLaaG2o0UWBnxRZOKvreVrFetX6x78nh1AXp
 VpgBefoHay4jjX4g7KX4Gez3Bmpi3+g15o4JuKRKr+D6yZ/cn3JTayezotId5Ss8IH
 eeFuv4AACCO+A==
Message-ID: <4f8e32e7-be61-44f0-9bc7-10eefe1cad94@kernel.org>
Date: Wed, 19 Aug 2026 10:56:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jaegeuk Kim <jaegeuk@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>
References: <20260818200121.2684318-1-jaegeuk@kernel.org>
Content-Language: en-US
In-Reply-To: <20260818200121.2684318-1-jaegeuk@kernel.org>
X-Headers-End: 1wwWU2-0002iR-7R
Subject: Re: [f2fs-dev] [PATCH] f2fs: don't leave the hashed inode while
 it's unlinked
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/19/26 04:01, Jaegeuk Kim via Linux-f2fs-devel wrote:
> f2fs_symlink()
> 1. f2fs_new_inode
> 2. f2fs_add_link
> 3. page_symlink
> 4. flush dirty pages and or checkpoint
> 
> Step 4 is nice to succeed, which doesn't become a reason to roll back
> the created symlink. OTOH, if we get an error till step 3, let's roll
> back and remove the cached inode.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/namei.c | 26 +++++++++++---------------
>  1 file changed, 11 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
> index 37897f4321c0..7b318cee2ed6 100644
> --- a/fs/f2fs/namei.c
> +++ b/fs/f2fs/namei.c
> @@ -704,14 +704,16 @@ static int f2fs_symlink(struct mnt_idmap *idmap, struct inode *dir,
>  	f2fs_alloc_nid_done(sbi, inode->i_ino);
>  
>  	err = fscrypt_encrypt_symlink(inode, symname, len, &disk_link);
> -	if (err)
> -		goto err_out;
> -
> -	err = page_symlink(inode, disk_link.name, disk_link.len);
> +	if (!err)
> +		err = page_symlink(inode, disk_link.name, disk_link.len);
>  
> -err_out:
>  	d_instantiate_new(dentry, inode);

IIUC, Al means we'd better not call d_instantiate_new() before every thing is
done? IOW, do not call d_instantiate_new() if we're in error handling.

Let me know if I missed something.

Thanks,

>  
> +	if (err) {
> +		f2fs_unlink(dir, dentry);
> +		goto out_f2fs_handle_failed_inode;
> +	}
> +
>  	/*
>  	 * Let's flush symlink data in order to avoid broken symlink as much as
>  	 * possible. Nevertheless, fsyncing is the best way, but there is no
> @@ -721,16 +723,10 @@ static int f2fs_symlink(struct mnt_idmap *idmap, struct inode *dir,
>  	 * If the symlink path is stored into inline_data, there is no
>  	 * performance regression.
>  	 */
> -	if (!err) {
> -		err = filemap_write_and_wait_range(inode->i_mapping, 0,
> -						   disk_link.len - 1);
> -
> -		if (!err && IS_DIRSYNC(dir))
> -			err = f2fs_sync_fs(sbi->sb, 1);
> -	}
> -
> -	if (err)
> -		f2fs_unlink(dir, dentry);
> +	err = filemap_write_and_wait_range(inode->i_mapping, 0,
> +					   disk_link.len - 1);
> +	if (!err && IS_DIRSYNC(dir))
> +		f2fs_sync_fs(sbi->sb, 1);
>  
>  	f2fs_balance_fs(sbi, true);
>  	goto out_free_encrypted_link;



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
