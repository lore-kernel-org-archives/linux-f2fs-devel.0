Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2D50C5B572
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 17 Aug 2026 03:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fqmScBfXMntG/n9dyn3fzY4r3nzipeQtUcBSOlhRE9A=; b=m9G12HXCkZxVrU+O4grvlhZRz/
	iBYjyOnY6JdNLMw1P6RmOcsS1pWMgbRxgemvhawhJjfVD6n0pc3CJRctu8Iukqx18gYco7qj0rP3D
	VxC297r7SKVK01jsUcnVQnfhr616B+wACLdAA/LhoC92YCiIW8iJQ9Mqxd33zR9m0l6E=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wvoAu-000538-7U;
	Mon, 17 Aug 2026 03:38:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wvoAs-00052t-On
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 03:38:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/HqfCf7CNS8GgNzXYlxF/N9ni38HaPB3vsDehNgqqNY=; b=JKWOEPCk5rd9QLry2P6pDAcgR3
 XvLqa9X/S4Jp+o6eG+w2lu0Duf8+keq590NHIzJNM/s20IVmmv1LVwGqrj+XLLH/uxVFfGmg8CA3M
 SFTDpnX74+X2woiKyaQf0I9zIANK+gOoROMJt3RdLQTOG8lTxUBHtwaUhuBKNnm1kYmk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/HqfCf7CNS8GgNzXYlxF/N9ni38HaPB3vsDehNgqqNY=; b=RJnH7+iEijEge5rVby1ElyYaBW
 LLEzjtGz+B5Pj3othEwbl9Top+ZAOmnBcjBSAA2TO91h6cP/wRgHWm2ikSN0SvG7Fs9FiHoIYI/zG
 WFKo2+BGv+ofhsh7gzn3secZB7PAn28affWb5ceqV8enF+VLyzGm7ig2mF57SRZ/cy74=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wvoAw-00069F-KA for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 03:38:11 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BFBBE40F40;
 Mon, 17 Aug 2026 03:38:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 150B41F000E9;
 Mon, 17 Aug 2026 03:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786937885;
 bh=/HqfCf7CNS8GgNzXYlxF/N9ni38HaPB3vsDehNgqqNY=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=FFWk14+RL389a+vaz+oRB5KbwltPljqN92+Z1xgIncAodVa80VaPmvK9nHKaa9A+U
 JEEhgueA3I56jw0Dk5ObtASVsGWnv2hXdRhS19sqlrEFxydCRIKuutBtjn5blL615U
 cCvQh394jy4k7OOMtPp1fGlzF1+QVL5W4bgqqy4qwDjuTuZg9lIkfll8ibBMATC9Ze
 KOpXry60DfmTdTTw+/BtZWAx11x2cutWHK0ttbOqSO95Z5VpfVdKAkmkww9kb9QeJR
 pqEISLdgZ4HOu4+8Vt27ENnAxyQVfVofPdE6FiaBzfxNQyxS6CH5nast9U+ElYcj30
 fasYpzNMyZ3Vw==
Message-ID: <2a3d8702-f7fd-4013-8181-d9fd68b6aa18@kernel.org>
Date: Mon, 17 Aug 2026 11:38:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Seongjae Jeong <jsjlee1020@gmail.com>, jaegeuk@kernel.org
References: <20260814105234.31620-1-jsjlee1020@gmail.com>
Content-Language: en-US
In-Reply-To: <20260814105234.31620-1-jsjlee1020@gmail.com>
X-Headers-End: 1wvoAw-00069F-KA
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix O_DIRECT cleanup range for append
 writes
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/14/26 18:52, Seongjae Jeong wrote:
> When an O_DIRECT write falls back to buffered I/O,
> f2fs_flush_buffered_write() uses orig_pos to flush and invalidate
> the page cache.
> 
> For O_APPEND writes, f2fs_write_checks() updates iocb->ki_pos to
> the end of the file after orig_pos has been saved. As a result,
> the cleanup range can differ from the actual buffered write range.

If generic_write_checks() can adjust writing position or amount of bytes
to write, shouldn't we access iocb->ki_pos and iov_iter_count(from) after
generic_write_checks()?

Thanks,

> 
> Save the write position after f2fs_write_checks() and use it for
> the forced buffered I/O cleanup.
> 
> Fixes: 92318f20d703 ("f2fs: preserve direct write semantics when buffering is forced")
> Signed-off-by: Seongjae Jeong <jsjlee1020@gmail.com>
> ---
>   fs/f2fs/file.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index b99d9cdf9ba7..bf61545603e5 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -5313,6 +5313,7 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>   	const loff_t pos = iocb->ki_pos;
>   	const ssize_t count = iov_iter_count(from);
>   	ssize_t ret;
> +	loff_t bufio_start_pos;
>   
>   	if (unlikely(f2fs_cp_error(F2FS_I_SB(inode)))) {
>   		ret = -EIO;
> @@ -5343,6 +5344,8 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>   	if (ret <= 0)
>   		goto out_unlock;
>   
> +	bufio_start_pos = iocb->ki_pos;
> +
>   	/* Determine whether we will do a direct write or a buffered write. */
>   	dio = f2fs_should_use_dio(inode, iocb, from);
>   
> @@ -5396,8 +5399,8 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
>   	 */
>   	if (ret > 0 && !dio && (iocb->ki_flags & IOCB_DIRECT))
>   		f2fs_flush_buffered_write(iocb->ki_filp->f_mapping,
> -					  orig_pos,
> -					  orig_pos + ret - 1);
> +					  bufio_start_pos,
> +					  bufio_start_pos + ret - 1);
>   
>   	return ret;
>   }



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
