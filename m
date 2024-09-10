Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A061ECE582
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 10 Sep 2024 17:06:17 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1so4Jj-0004ky-Pp;
	Tue, 10 Sep 2024 17:06:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1so4Ji-0004ks-Us
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 10 Sep 2024 17:06:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7XJK45MnTOW+K/G1lVZ7iJg8hMg+LQ4XRwjyix1vEG8=; b=H9zdgtH1H+FATt7PxaTtXtZzm5
 G18F6L3GCT9DZ/ksY9coHL2k1121o5yk3QuBaG+XDJFDaMmlTiEGA/a2RZCnMaNfnONbPJpESkyC0
 dbyZORE0/99/W6DzvQG/1izHq18OwIbW9LKVzfrismaXVCbLUV/7hB0nA3sbzxf8tFRs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=7XJK45MnTOW+K/G1lVZ7iJg8hMg+LQ4XRwjyix1vEG8=; b=fTjoHE7dnwwmUAZZwcG8GbcRHm
 G5ha4rYl3SmS+EDybEUDKPj1Aj9I7HBz1sozAklGwGRc4xE9mi4MZp+/JFbHfzDvzCdNq8S+fMavL
 fDwWQm4/tE9cDjGrttL2OghHQ9g/+PA+elWovdJ9JcJzajD1VfT2KCQtz1xLS5RYMmMc=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1so4Jg-0003kz-Jk for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 10 Sep 2024 17:06:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id ADF565C01AF
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 10 Sep 2024 17:05:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED7FC4CEC3;
 Tue, 10 Sep 2024 17:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1725987961;
 bh=9Du6n31xKQT+/2GaL7JJvZuXehy1P6YxYx3Nd2mdNDY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uWlvyrIXQdS5UcnYhQ0iqrSBUt/RT6WeOSeTGnjd3Vzd/mjSeR94omDWSRJ9Ob1ps
 X6jhzqdVbE/DEcJLsmeTTcjJ3xisQsFtQO7wJPgRAmN6/HLDbbDjhrBux193ESRzTb
 /6v4ZigjEJibgd0c2Yyl24xfOZeVlcqHSoH5C87C1itzAF4GZmv6yHtIqYBoISeukS
 QRFVZdV+fGfEXuVs5spXv0eu9TozqVBpW8GOss2uPakSg+Dk30F36KXCl/iIDjlj/5
 s2f5osDotFTaSG8NPbPxWMKT8a7MZD9UDinbh14PoYR5rmcTbLKwN4QLeY4yLmI+Ph
 VGSuDpBDHMlKg==
Date: Tue, 10 Sep 2024 10:06:00 -0700
To: Chao Yu <chao@kernel.org>
Message-ID: <20240910170600.GB2642@sol.localdomain>
References: <20240910125753.80502-1-chao@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240910125753.80502-1-chao@kernel.org>
X-Headers-End: 1so4Jg-0003kz-Jk
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to tag STATX_DIOALIGN only if
 inode support dio
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
From: Eric Biggers via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Eric Biggers <ebiggers@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Sep 10, 2024 at 08:57:53PM +0800, Chao Yu via Linux-f2fs-devel wrote:
> After commit 5c8764f8679e ("f2fs: fix to force buffered IO on inline_data
> inode"), f2fs starts to force using buffered IO on inline_data inode.
> 
> And also, it will cause f2fs_getattr() returning invalid zeroed value on
> .dio_mem_align and .dio_offset_align fields, however, STATX_DIOALIGN flag
> was been tagged. User may use zeroed .stx_dio_offset_align value
> since STATX_DIOALIGN was been tagged, then it causes a deadloop during
> generic/465 test due to below logic:
> 
> align=stx_dio_offset_align(it equals to zero)
> page_size=4096
> while [ $align -le $page_size ]; do
> 	echo "$AIO_TEST -a $align -d $testfile.$align" >> $seqres.full
> 	$AIO_TEST -a $align -d $testfile.$align 2>&1 | tee -a $seqres.full
> 	align=$((align * 2))
> done
> 
> Quoted from description of statx manual:
> 
> " If  a  filesystem  does  not support a field or if it has an
>   unrepresentable value (for instance, a file with an exotic type),
>   then the mask bit corresponding to that field will be cleared in
>   stx_mask even if the user asked for it and a dummy value will be
>   filled in for compatibility purposes if one is available (e.g.,
>   a dummy UID and GID may be specified to mount under some
>   circumstances)."
> 
> We should not set STATX_DIOALIGN flag in kstat.stx_mask if inode
> does not support DIO, so that it can indicate related fields contain
> dummy value, and avoid following incorrect use of them.
> 
> Fixes: c8c02272a9f7 ("f2fs: support STATX_DIOALIGN")

When claiming to be Fixing a commit, please make sure to Cc the author of that
commit.

> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/file.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 99903eafa7fe..f0b8b77e93ba 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -906,14 +906,11 @@ int f2fs_getattr(struct mnt_idmap *idmap, const struct path *path,
>  	 * f2fs sometimes supports DIO reads but not DIO writes.  STATX_DIOALIGN
>  	 * cannot represent that, so in that case we report no DIO support.
>  	 */
> -	if ((request_mask & STATX_DIOALIGN) && S_ISREG(inode->i_mode)) {
> -		unsigned int bsize = i_blocksize(inode);
> -
> +	if ((request_mask & STATX_DIOALIGN) && S_ISREG(inode->i_mode) &&
> +				!f2fs_force_buffered_io(inode, WRITE)) {
> +		stat->dio_mem_align = F2FS_BLKSIZE;
> +		stat->dio_offset_align = F2FS_BLKSIZE;
>  		stat->result_mask |= STATX_DIOALIGN;
> -		if (!f2fs_force_buffered_io(inode, WRITE)) {
> -			stat->dio_mem_align = bsize;
> -			stat->dio_offset_align = bsize;
> -		}
>  	}
>  
>  	flags = fi->i_flags;

No, this patch is wrong and the existing code is correct.  The cases are:

    STATX_DIOALIGN set and stx_dio_*_align nonzero:
        File supports DIO.

    STATX_DIOALIGN set and stx_dio_*_align zero:
        File doesn't support DIO.

    STATX_DIOALIGN unset:
        Filesystem doesn't support STATX_DIOALIGN, so it's unknown whether the
        file supports DIO or not.

Please see the statx(2) manual page which explains this too.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
