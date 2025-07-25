Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34466C87FCC
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 25 Jul 2025 02:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pc9qMptqIJKAX7LvhHncRuSnssasTtLjEIhv7HR8GgY=; b=H7C3bijFrKdK38Q2y/S70KOI+8
	JO+s0vyzgEQkZ6tZ5Bzo7Gb6JIp9DCUIdSfZA8HE69Ie6t8LGtsYwc4RgF4c9s04ZR5OF1s2S12Qa
	O34PEtaG2pT90ov2IoQYiVdYomiz7e6n6qXg4hqvBQck64o8rcnvEAUP7QPvjXj7o6/4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uf8HJ-0001u5-Q4;
	Fri, 25 Jul 2025 02:35:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1uf8HI-0001tq-LM
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 25 Jul 2025 02:35:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+RTmqPjSz2gD/wVp1mmZPPA5HcWI37ZmBQw4VhjP12c=; b=J5C3Y0vadyzxbc1hjJGtY905KO
 HwtDdhQnuj6szEYLOUxjZg7TgfVdLPfaflTU1EepNKTA3HBnQAPVlsBzlv3IlEwtPyroEE3iogO+Y
 L0JJOemBiC0RHAV4IwclkX2wE1mh4q8A/6PH5A3/t4mINufZawOz++Otc9RXjE3eKId0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+RTmqPjSz2gD/wVp1mmZPPA5HcWI37ZmBQw4VhjP12c=; b=X+NhUSH+GLIKQVnh7ghxnk04+D
 aLOmkK9BIbdJQuEcDyUfNTvBIySqsSrupzK43nog7xsdCUXQ7GLvkyKhF70agDxlpUtESyuKQL3XD
 vjE5w9iSrZJr3to/K4AYfC/+vvnviga1nq8QK0KExm9PdSFFc4VYbdTb7CENsAXX09uY=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uf8HJ-0002ki-39 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 25 Jul 2025 02:35:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id AFE8A4667F;
 Fri, 25 Jul 2025 02:35:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD8AC4CEED;
 Fri, 25 Jul 2025 02:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1753410915;
 bh=nXuW9sDa5fC2gjkR2Eriw7Oer+0cOQXO3yyiZOpDSqE=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=ttOQypxnERjidL92dpoIX/V3exOZqYncnxNEdw07WfdSWS4X30K9fA99Un557DguI
 LIi27+roBMQ8r5TTalkdyyd+lvsdDcgttNR3D0cg9twhPr+7Gw8MVf4/wfRi8dW+p9
 b0H8RtR3tAO9SkxYxhdmDQn8jQXv32t+/S0C4FoYOdYM1zfr3mnPs+smFC62S4QFIE
 hzw7vbx6fMm/8aXS2cx9ok8Xjnz07xmAogX1vT2XFFmw3YdjAujR2lB7fYg162sjPy
 FuTGbDjiSZrQuygVxmG5469fXkogDWsEpviPkhz1e3yN75vww23EIuOldLycT9Gkul
 kwiRtiMRhOuig==
Message-ID: <68c1c92b-5c29-49b9-a8af-916e5293c80e@kernel.org>
Date: Fri, 25 Jul 2025 10:35:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "mason.zhang" <masonzhang.linuxer@gmail.com>
References: <20250724155945.206801-1-masonzhang.linuxer@gmail.com>
Content-Language: en-US
In-Reply-To: <20250724155945.206801-1-masonzhang.linuxer@gmail.com>
X-Headers-End: 1uf8HJ-0002ki-39
Subject: Re: [f2fs-dev] [PATCH] f2fs: add error checking in do_write_page()
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

On 7/24/2025 11:59 PM, mason.zhang wrote:
> Otherwise, the filesystem may unaware of potential file corruption.
> 
> Signed-off-by: mason.zhang <masonzhang.linuxer@gmail.com>
> ---
>   fs/f2fs/segment.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index ae1223ef648f..ce80ba226aed 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -3936,12 +3936,15 @@ static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
>   	int seg_type = log_type_to_seg_type(type);
>   	bool keep_order = (f2fs_lfs_mode(fio->sbi) &&
>   				seg_type == CURSEG_COLD_DATA);
> +	int err;
>   
>   	if (keep_order)
>   		f2fs_down_read(&fio->sbi->io_order_lock);
>   
> -	if (f2fs_allocate_data_block(fio->sbi, fio->page, fio->old_blkaddr,
> -			&fio->new_blkaddr, sum, type, fio)) {
> +	err = f2fs_allocate_data_block(fio->sbi, fio->page, fio->old_blkaddr,
> +			&fio->new_blkaddr, sum, type, fio);
> +	if (unlikely(err)) {
> +		f2fs_err(fio->sbi, "Failed to allocate data block(%d)", err);

How about using f2fs_err_ratelimited() to avoid too many logs?

Can you please dump more informations about inode, page, blkaddr...?

Thanks,

>   		if (fscrypt_inode_uses_fs_layer_crypto(folio->mapping->host))
>   			fscrypt_finalize_bounce_page(&fio->encrypted_page);
>   		folio_end_writeback(folio);



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
