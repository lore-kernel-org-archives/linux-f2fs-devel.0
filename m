Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB5AC55182
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  4 Aug 2026 00:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0J141aXp7kYeBDzh/Dx9GLZVaZQ3zHFpkOD1W9lJpjk=; b=MS/w2lCulFp4BM4xZOwJMFo1XH
	4Y6icSxSnwaMA5lkG4Y8dMgC4elcnh6Ae/ysIxay+acX5Qlx2+T98BmxKH7Z4Vft4s/c3Y2NS4xor
	E7v8LG6VVLuElvP4ULSvwip8G5llqEXBhj7N0xiLWXVNf4b+6V4gT3kwZdIji+xeGkxE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wr2hk-0006gg-8Y;
	Tue, 04 Aug 2026 00:08:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wr2hj-0006ga-DY
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 00:08:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=V6JMc4T97qa7AdgeRhkv+CB1f4XYEGtyD+lrlDxriQw=; b=YygB0VL2F+VjPN6Jmb4Jr+pKUS
 3CL8EadN0xs2YIPy1JLcOwk5q3wamRpGhBd/78CeGZlB8264uGFcUverDmqv9JJeiQSXQpGVVkvOs
 8elOg1MBhLaDDR54kJ1lsPzGRTLuuAiNs5L6ryTa0uD8jqZ6V1/sMH54HOBmxMZPC69U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=V6JMc4T97qa7AdgeRhkv+CB1f4XYEGtyD+lrlDxriQw=; b=gBx8ux/vZW+omxqrmW1whaqxpa
 3w+IbgwmFIpQfLBXPq1TB5K2OyAIAC7c91OanNUSo7akblHBCp2vn6JFeAcsWNCIzBCEP88puT1fN
 YbJnNUmojPusbbcP0F/UEAkDjOLrkTlgXIHYVDuUVk9074zjZU/r0UPGdukC6C0VIQ04=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wr2hl-00010r-Cz for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 00:08:23 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3829560A59;
 Tue,  4 Aug 2026 00:08:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78CFC1F000E9;
 Tue,  4 Aug 2026 00:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785802095;
 bh=V6JMc4T97qa7AdgeRhkv+CB1f4XYEGtyD+lrlDxriQw=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=l4hEkZUPUZb9N+vu4/HX9J0GdPbpGLarUO0nVFsrdNUHQaCJNOfP926uUyJflCuWU
 477JaJAZGnB3CvWbo9ePBlmoyB3IlOIsEHY7UJoEgzmWy8Yu9nv1LPrtavtlRglwcH
 gEkSVJXRw0e68Jcmc33bWDquJjh2NexYGb6VU0UTDW1GtIYdedMGhSxbhI6rnHlNL1
 X9Tc7ip9deJvdk7T6y+sOsKYh0VzOIySrCmlYC6yCRBqRtwHxG/vFzlQZgKtyEuzvG
 4BQ8DKUb3mOii3bRqILZABTzURgz9g+bWOLG/HGgrv88Jnt8ArlS+SeMupdDuYqVEd
 37zpDI3Sb4yYw==
Message-ID: <0b450e92-b9b0-4a55-bd16-ad106245d7e1@kernel.org>
Date: Tue, 4 Aug 2026 08:08:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Chen Changcheng <chenchangcheng@kylinos.cn>
References: <20260803073800.218814-1-chenchangcheng@kylinos.cn>
 <20260803074344.219899-1-chenchangcheng@kylinos.cn>
Content-Language: en-US
In-Reply-To: <20260803074344.219899-1-chenchangcheng@kylinos.cn>
X-Headers-End: 1wr2hl-00010r-Cz
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix valid block count leak on data
 block allocation failure
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
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, ccc194101@163.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/3/26 15:43, Chen Changcheng wrote:
> In __allocate_data_block(), when allocating a new data block
> (dn->data_blkaddr == NULL_ADDR), inc_valid_block_count() is
> called first to increment total_valid_block_count and i_blocks.
> If the subsequent f2fs_allocate_data_block() fails, the function
> returns the error directly without rolling back the
> already-incremented block counts, causing a permanent leak.
> 
> Fix this by calling dec_valid_block_count() to undo the
> increment before returning the error. The condition
> old_blkaddr == NULL_ADDR precisely identifies the case where
> inc_valid_block_count() was called.
> 
> Fixes: 54607494875e ("f2fs: compress: fix to avoid inconsistence bewteen i_blocks and dnode")

Should be?

Fixes: 7d009e048d7c ("f2fs: fix to handle segment allocation failure correctly")

Thanks,

> Cc: <stable@vger.kernel.org>
> Reviewed-by: Chao Yu <chao@kernel.org>
> Signed-off-by: Chen Changcheng <chenchangcheng@kylinos.cn>
> ---
>   fs/f2fs/data.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index a765fda71536..819631bb61ae 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1532,8 +1532,11 @@ static int __allocate_data_block(struct dnode_of_data *dn, int seg_type)
>   	old_blkaddr = dn->data_blkaddr;
>   	err = f2fs_allocate_data_block(sbi, NULL, old_blkaddr,
>   				&dn->data_blkaddr, &sum, seg_type, NULL);
> -	if (err)
> +	if (err) {
> +		if (old_blkaddr == NULL_ADDR)
> +			dec_valid_block_count(sbi, dn->inode, count);
>   		return err;
> +	}
>   
>   	if (GET_SEGNO(sbi, old_blkaddr) != NULL_SEGNO)
>   		f2fs_invalidate_internal_cache(sbi, old_blkaddr, 1);



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
