Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ADA9C7EE2C
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 25 Aug 2023 10:41:54 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qZUGF-0002IQ-MM;
	Fri, 25 Aug 2023 10:41:52 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1qZUGC-0002IJ-IS
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 25 Aug 2023 10:41:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NMEgiR8AW/gh86cW3G/eSrTv5j2OJVThwJez45gZSvI=; b=fs5FnQzxb4YgCY4TO/Twl9EbyB
 LvSJjGYucCSVp7hF15C2OyKTEC0w1Pty/AzHAfqTdEMfxTdhzpURANGkiTPP+S0UjE1Y3uppzEcaX
 QDtjytbCMw8Q7s/gI77QeNqI4Tk7ikggpuvuLUlFt7jk/bUBwgrMVAznvBW4+11DxzZ8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=NMEgiR8AW/gh86cW3G/eSrTv5j2OJVThwJez45gZSvI=; b=gwq3otR14eqnBKU8AZNTDDn7Np
 xSUFK8HnL6zVOdF/nkq9G6IZAgCdLDxeKPgkZuui8r2QxsmKsSw5qFaqjnsMbykGTPuTdiwmzT7Ds
 AakRcuMrY5BXKzA+ToO1aWaZs1PO99Eww1gRpx4Bx4QaeKpcbevdzmc+OPZxybmvIH6w=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qZUGB-0000YA-T3 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 25 Aug 2023 10:41:48 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 48C91631D8;
 Fri, 25 Aug 2023 10:41:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2B84C433C8;
 Fri, 25 Aug 2023 10:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1692960101;
 bh=C+23fD72ZNSqdBsS5bGjW78zBwwoHToxHQsJuw/KJN0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=WXuDL+Dm3ljWrCV0Zq03WyDGNcM27U7ChI6JYaZo16suJvxIOvNbKKBoVFLjIEiLC
 qFDGkg4xU4Nk2ANiPt9Bq67OaS3mvZbXfw4LveHu8/h57bfzdknZSI61aK8LAlTDkp
 6ZRlkckYEgpFQTpfCPj31ueJ4Pi3qAevi2dbLHWj6am/YHKicn5xH9NeomAqm4kYs6
 tfHCyVQ9uBTWd723eCN/wc3afQJIa8K34VbQHMj/97brtnlZb3yElmw+fJoufyEKdI
 4m49uq3n1RRyCBysKllqqSG+3IicUfyke4xqI2Q6qG8Bt5lNP6I1kBlE0KMri9HFum
 X6Sg7fWhXRcNQ==
Message-ID: <517380b7-77e6-3b79-5156-234b51dbb104@kernel.org>
Date: Fri, 25 Aug 2023 18:41:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: Lizhi Xu <lizhi.xu@windriver.com>
References: <0000000000000f188605ffdd9cf8@google.com>
 <20230825053732.3098387-1-lizhi.xu@windriver.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230825053732.3098387-1-lizhi.xu@windriver.com>
X-Headers-End: 1qZUGB-0000YA-T3
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix deadlock in f2f2_add_dentry
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/8/25 13:37, Lizhi Xu wrote:
> There are two paths:
> 1. f2fs_add_dentry->f2fs_down_read->f2fs_add_inline_entry->down_write->
>     up_write->f2fs_up_read
> 2. f2fs_add_dentry->f2fs_add_regular_entry->down_write->
>     f2fs_init_inode_metadata->f2fs_down_read->f2fs_up_read->up_write
> 
> Force order lock to read->write.

Hi Lizhi,

Thanks for the fix.

Can you please check below patch? it has fixed reported issue.

https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev&id=5c13e2388bf3426fd69a89eb46e50469e9624e56

Feedback from syzbot:

https://lore.kernel.org/linux-f2fs-devel/0000000000001ba17a0603b5871e@google.com/

> 
> Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> Reported-and-tested-by: syzbot+a4976ce949df66b1ddf1@syzkaller.appspotmail.com
> ---
>   fs/f2fs/dir.c    | 4 +---
>   fs/f2fs/inline.c | 2 ++
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> index d635c58cf5a3..022dc02c1390 100644
> --- a/fs/f2fs/dir.c
> +++ b/fs/f2fs/dir.c
> @@ -736,12 +736,12 @@ int f2fs_add_regular_entry(struct inode *dir, const struct f2fs_filename *fname,
>   	f2fs_wait_on_page_writeback(dentry_page, DATA, true, true);
>   
>   	if (inode) {
> -		f2fs_down_write(&F2FS_I(inode)->i_sem);
>   		page = f2fs_init_inode_metadata(inode, dir, fname, NULL);
>   		if (IS_ERR(page)) {
>   			err = PTR_ERR(page);
>   			goto fail;
>   		}
> +		f2fs_down_write(&F2FS_I(inode)->i_sem);
>   	}
>   
>   	make_dentry_ptr_block(NULL, &d, dentry_blk);
> @@ -780,9 +780,7 @@ int f2fs_add_dentry(struct inode *dir, const struct f2fs_filename *fname,
>   		 * Should get i_xattr_sem to keep the lock order:
>   		 * i_xattr_sem -> inode_page lock used by f2fs_setxattr.
>   		 */
> -		f2fs_down_read(&F2FS_I(dir)->i_xattr_sem);
>   		err = f2fs_add_inline_entry(dir, fname, inode, ino, mode);
> -		f2fs_up_read(&F2FS_I(dir)->i_xattr_sem);
>   	}
>   	if (err == -EAGAIN)
>   		err = f2fs_add_regular_entry(dir, fname, inode, ino, mode);
> diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
> index 4638fee16a91..7618b383c2b7 100644
> --- a/fs/f2fs/inline.c
> +++ b/fs/f2fs/inline.c
> @@ -628,10 +628,12 @@ int f2fs_add_inline_entry(struct inode *dir, const struct f2fs_filename *fname,
>   	if (IS_ERR(ipage))
>   		return PTR_ERR(ipage);
>   
> +	f2fs_down_read(&F2FS_I(dir)->i_xattr_sem);
>   	inline_dentry = inline_data_addr(dir, ipage);
>   	make_dentry_ptr_inline(dir, &d, inline_dentry);
>   
>   	bit_pos = f2fs_room_for_filename(d.bitmap, slots, d.max);
> +	f2fs_up_read(&F2FS_I(dir)->i_xattr_sem);
>   	if (bit_pos >= d.max) {
>   		err = do_convert_inline_dir(dir, ipage, inline_dentry);
>   		if (err)


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
