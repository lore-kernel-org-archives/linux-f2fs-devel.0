Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4709C55165
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 30 Jul 2026 13:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mjC13uBA1SqyDBltIBqHFXETGmeabTYDVq9v9dnMzao=; b=EN96LB+Okg0SjYwHPT6FV90WF6
	3x7a5zNL/qsqCx/nilD10aSVPgtEKPr7vfU3rZiVokzpol4QKq3rXXT1fuP+/vo3tPG/828yCYRn7
	8/W1WCfha16Nu/KCSsAURG/GwHy+bZnWx00hHqq378heFwGOSBYsYlVwaAg0J/T/P7vY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wpR5F-0008SB-AP;
	Thu, 30 Jul 2026 13:46:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wpR5D-0008Rx-OP
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 13:46:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aUxZbDwdjoyd5VTpayjmuzIZ12zq8bCBYHyNHhSWyZI=; b=mac63O7ZIDDOYdEqxIe/pPQf5k
 yABpyDMm8m/bZtlmX5qwmUM5lehUYLVUSHJV+mD25IlFfJOng+poFHFM3d2icvwb6AtXj1+EV8e3C
 4i8yZV/+IES8X8jTu5JAEcxUdIYMlo4ieq+fqqt3553zt+cIbvJYFxevZ9GoaQQ3DyfY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=aUxZbDwdjoyd5VTpayjmuzIZ12zq8bCBYHyNHhSWyZI=; b=MTBgZhJ6dAyRxaladKZWG5PS8B
 T918KXa/G+XwRwKj9vwOByRVs/7SrTVeLpZwuNQJXSzW45WhO7FaPcbrIeuM+5I8YesPHLhRJr+L2
 Y3um+wkFEtUCblGSIpm2jUHTgZPco/hg8/gFT0BRH3oLmI2TxQRcW1pGfNzbRKeqWEzw=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wpR5H-0000wV-Bw for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 30 Jul 2026 13:46:00 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 69E8942E94;
 Thu, 30 Jul 2026 13:45:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABD951F000E9;
 Thu, 30 Jul 2026 13:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785419154;
 bh=aUxZbDwdjoyd5VTpayjmuzIZ12zq8bCBYHyNHhSWyZI=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=kAvwrM4W/jloRc8TkIfKcBEUj08BTMAcAkeldpq1OnApkbNucNaPIW4JN91RqXGeC
 6/gHO0V/nD//+AiPj00tOYPyyUhqhHzK/qQXbYVdsQrdDrIn8UzqhufsR5ykUlBCYB
 jD0i4IKxW/RN56eaWmvJhFvYiGri3IB2YxnVDkW5sJ818IrPhxpuCZufEvTcVWsJ5W
 Oludk9//N2R9epUNIjigVDmVhby9H3swqKKjTeN/xfkLDguQz5WuJS82P5MbNmUVfq
 6RU//QBh/tc5eA6JTdfV9dhcNpEDC1XM+OXHK+nCrE/y6vbrhOwBSCk50toEyGs3N+
 qcP73KDZc4Wag==
Message-ID: <f1fece0c-6951-4c69-a681-344acfe1f62b@kernel.org>
Date: Thu, 30 Jul 2026 21:45:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260729002827.303608-1-zhaonanzhe@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260729002827.303608-1-zhaonanzhe@xiaomi.com>
X-Headers-End: 1wpR5H-0000wV-Bw
Subject: Re: [f2fs-dev] [DISCUSSION] f2fs: compatibility between compressed
 files and large folios
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
Cc: Pengfei Li <lipengfei28@xiaomi.com>, Barry Song <baohua@kernel.org>,
 Bo Zhang <zhangbo56@xiaomi.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Nanzhe,

Thanks for the proposal.

On 7/29/26 08:28, Nanzhe Zhao wrote:
> Hi all,
> 
> Chao Yu and I discussed the compatibility between compressed files and large
> folios.
> 
> The main race scenario is that f2fs_new_inode() creates an inode without the
> compression flag and enables large-folio support for its mapping. Later,
> f2fs_setflags_common() can set the compression flag while large-folio support
> is already enabled for the inode. Neither f2fs_iget() nor f2fs_new_inode()
> can prevent this for an active inode.
> 
> Here are the two approaches I am considering.
> 
> 1. Reject setting the compression flag on a large-folio mapping
> 
> We can reject setting the compression flag in f2fs_setflags_common() if the
> inode mapping supports large folios:
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -2250,6 +2250,9 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
>          if ((iflags ^ masked_flags) & F2FS_COMPR_FL) {
>                  if (masked_flags & F2FS_COMPR_FL) {
>                          if (!f2fs_disable_compressed_file(inode))
>                                  return -EINVAL;
>                  } else {
> +                       if (mapping_large_folio_support(inode->i_mapping))
> +                               return -EOPNOTSUPP;
> +
>                          /* try to convert inline_data to support compression */
>                          int err = f2fs_convert_inline_inode(inode);
>                          if (err)
>                                  return err;
> 
> Another implementation is:
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -2250,6 +2250,9 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
>          if ((iflags ^ masked_flags) & F2FS_COMPR_FL) {
>                  if (masked_flags & F2FS_COMPR_FL) {
>                          if (!f2fs_disable_compressed_file(inode))
>                                  return -EINVAL;
>                  } else {
> +                       if (IS_ENABLED(CONFIG_F2FS_LARGE_FOLIO))
> +                               return -EOPNOTSUPP;
> +
>                          /* try to convert inline_data to support compression */
>                          int err = f2fs_convert_inline_inode(inode);
>                          if (err)
>                                  return err;
> 
> The concern with this approach is that new files trying to set compression
> through the ioctl will be rejected, so compression will not be available. I
> think we can document that enabling large-folio support in f2fs disables
> compression.
> 
> 2. Keep the compression flag and restore order 0
> 
> If the compression flag and compression functionality need to remain
> available, we can restore the mapping order to 0 after set_compress_context()
> successfully sets the compression flag in f2fs_setflags_common():
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -2268,6 +2268,10 @@ static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
>                                  return -EINVAL;
>                          }
>                          err = set_compress_context(inode);
> +                       if (!err &&
> +                           mapping_large_folio_support(inode->i_mapping))
> +                               mapping_set_folio_order_range(
> +                                       inode->i_mapping, 0, 0);

I prefer this solution, it keeps f2fs compression functionality available, rather
than just disabling it after we enable large folio. I suspect there is existing
users: applications are using it, I don't want to break any userspace use.

>                          f2fs_up_write(&fi->i_sem);
> 
>                          if (err)
>                                  return err;
> 
> Under normal Android workloads, a file whose compression flag can be set by
> f2fs_setflags_common() has no data blocks. Also, an application will not read
> a newly created file with size 0 and fill the page cache with zeroed large
> folios. Therefore, setting the mapping order to 0 here is safe.
> 
> A theoretical sequence is: create a file, use ftruncate() to extend it to a
> non-zero size without allocating data blocks, read the file holes so that
> zeroed large folios are left in the page cache, and then set the compression
> flag through the ioctl. If truncate_inode_pages() is not called before the
> mapping order is reset, the existing large folios remain in the page cache.
> Also, since mapping_set_folio_order_range() is not atomic, readahead may
> theoretically access the mapping's folio-order flags without holding the inode
> lock. Neither case is expected under normal Android workloads.

Can we call truncate_inode_pages() after mapping_set_folio_order_range()? something
like this:

		filemap_invalidate_lock

		mapping_set_folio_order_range(, 0, 0)
		truncate_inode_pages()

		if (mapping->nrpages) {
			err = -EBUSY;
			goto out_unlock;
		}

		...
		err = set_compress_context(inode);
		...

		filemap_invalidate_unlock

Thanks,

> 
> Jaegeuk previously mentioned that a file could have both the compression flag
> and a large-folio mapping. Its writeback could use the normal large-folio path
> without actually compressing the file. After the inode is evicted and the file
> is opened again, f2fs_iget() would see the compression flag, prevent the
> large-folio mapping from being enabled, and return to the normal order-0 read
> path. Chao Yu pointed out that it would be functionally strange if a file
> with the compression flag was not compressed during its first writeback.
> 
> Please let us know which of the above approaches you think is better, or
> whether we have another better approach.
> 
> Thanks,
> 
> Nanzhe
> 



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
