Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D28C25B7A
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 20 May 2024 19:52:45 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1s993r-0000TI-P1;
	Mon, 20 May 2024 19:52:43 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1s993p-0000T5-Dk
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 May 2024 19:52:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XxS4trwBILGvT/LteDMhlTMI3aJP8RBvJroxNN1M98o=; b=HLQ2ev1lMjpndn8kuOtk4XWV1h
 +3EvJN1Ha1NqLf1TWjNRJzyQeHyiP4i/xNwQiSFpbQBP4SUM2iUZ00RMJIr37BtPcERdmwBqL7qmr
 dy9axz37lR0gbuDdVNmXAlC9HBUZmQoTywUt++EOEyQVcNxayS9sA0/7OJQjEra04u6g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=XxS4trwBILGvT/LteDMhlTMI3aJP8RBvJroxNN1M98o=; b=N7kn7x141L1n8yGnzMlUVcNaWt
 FqojW7K3SOuvDuRAykIMiotL1dYV1fjtp2Y2zloV9mnu6XGzAnHWdFicGIdpEwy2qdjtilPcCBiGL
 GcbnG/KIITOEZdan8NVTuAu522gLwARQ/S06APDh7rL0uX/urUZg8rLwkRlqm4ULMTYA=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1s993o-0001WU-R6 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 May 2024 19:52:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 51523CE0B2C;
 Mon, 20 May 2024 19:52:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 358BAC2BD10;
 Mon, 20 May 2024 19:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1716234747;
 bh=U2CMoe4AE+nyQy1FyMvXOkw8VyQr9iKivbdDeG3xG14=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Iqa3Dbbqw6bpcrwiqzWuFRKSKf26vkkvQdyjYxaiKydiPjx+mQa241ogQWQ1dVsTB
 vgl1VptkRMvH62nqQiHZ5qdFdkG3Ut+gKKqA52Tu/g/u+Ufm3TGT1gOHLBiurPhFmz
 R/jPduEWkBgO5+ipRPGa/AjXyNfUHSm7j83ismgOz5obIMCqazpmwI1ftW0KMVy9h+
 aauX7E58FTGv7+Ra2TE/CHrdyaLEXRjVRNdCNOsINIgPii80fDFDLNmjDLpRpBz2yc
 PG7AcoJzwCWeMaxBQWEDZfVUA1X57JWvOnrm+0iQxzNZaq/JZAqiUY7jutGYyjDJLf
 tnqXGvCiLEPKw==
Date: Mon, 20 May 2024 19:52:25 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Zhiguo Niu <zhiguo.niu@unisoc.com>
Message-ID: <Zkup-c2K74bxVJ0i@google.com>
References: <1715945202-30045-1-git-send-email-zhiguo.niu@unisoc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1715945202-30045-1-git-send-email-zhiguo.niu@unisoc.com>
X-Headers-End: 1s993o-0001WU-R6
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to check return value of
 f2fs_allocate_new_section
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
Cc: ke.wang@unisoc.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Hao_hao.Wang@unisoc.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 05/17, Zhiguo Niu wrote:
> commit 245930617c9b ("f2fs: fix to handle error paths of {new,change}_curseg()")
> missed this allocated path, fix it.
> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> ---
>  fs/f2fs/segment.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index a0ce3d0..71dc8042 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -5190,7 +5190,9 @@ static int fix_curseg_write_pointer(struct f2fs_sb_info *sbi, int type)
>  	if (cs->next_blkoff) {
>  		unsigned int old_segno = cs->segno, old_blkoff = cs->next_blkoff;
>  
> -		f2fs_allocate_new_section(sbi, type, true);
> +		err = f2fs_allocate_new_section(sbi, type, true);
> +		if (err)
> +			return err;

I hesitate to apply this, since this may give mount failures forever. Do you see
a real issue with this?

>  		f2fs_notice(sbi, "Assign new section to curseg[%d]: "
>  				"[0x%x,0x%x] -> [0x%x,0x%x]",
>  				type, old_segno, old_blkoff,
> -- 
> 1.9.1


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
