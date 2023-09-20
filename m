Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C81CE79AB
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 20 Sep 2023 08:50:05 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qisuK-0000Wj-9u;
	Wed, 20 Sep 2023 08:50:04 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1qisuJ-0000Wd-2L
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 20 Sep 2023 08:50:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nFXRVVeGuM6ATQyFQVcyJ9U4r3nLCbo9eDoHFMivK1w=; b=BO6RUrBdiotN3jrRKGuWIfz7V6
 d7xB5Kf4QRpNH6hdgwRdTSUVUhoXkiyM7i4TUZuxFZQd5Ifrs1PemPmQG6vuyBBEU+DiZt2n9Bqfs
 W040Vg5eZiwSsmlcJ9dga9GbLJ6iGI2kNfBchZ6vNoZCbBzIRAFBfD+Yj2uPhI5smVHs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=nFXRVVeGuM6ATQyFQVcyJ9U4r3nLCbo9eDoHFMivK1w=; b=Sq0LRIHgv/p0n3EEIMFhv9myWL
 bpzd9Bz1feo6X5l3WjceQStdSIngllbDcOh5IbKaW2Xt0penJFMh04V0cdhcJjax9DTlMHiCDEzrI
 U+4CXv+N3/xR5NWjL/PiFhWd1d0bnUGeots+oLzGqOZHxeD/MK4t2Kc6+oQ9POM2d2X0=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qisuI-00GO47-Ge for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 20 Sep 2023 08:50:03 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 36591B811B1;
 Wed, 20 Sep 2023 08:49:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E0AC433C9;
 Wed, 20 Sep 2023 08:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1695199794;
 bh=7GDLLe1gTwpj0EFsZk9vPK/oh9ioghJAlepW9IV+95M=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=JuR/HcUarRo3O2P9viAgkbR7i7bGUY7K5s4b9BXKSMKeF0+tGXgf6BZKMnMCzMfhm
 /YtbfpFgvU2X1eTy3YaQFUtTgfwK1pnpwGm5FAVAnMq1oiS3h2pGdq6aVib/uXe7a5
 Zbdib3wW7+qT0OBjqZQBkZubkrFx/04Den/TiRbtB8kZaoM3ewz07g11jOHOZNsMJI
 6wp2IR7DeDzZyNoXKaO1CZ5WOO2ViLnbDC9f9YcbwQXh5GRWHv4vrrtj7gpmoqDqPO
 0OyPQW1xK5Uv9AvfwgAk1wi61lEj6iLhe7esyipmuN5+HycgtDKXmndbqsGT4IeDVK
 bLx38wHiuEyWg==
Message-ID: <141e625d-7451-9687-826e-8d6b63cac5fe@kernel.org>
Date: Wed, 20 Sep 2023 16:49:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Content-Language: en-US
To: Wu Bo <bo.wu@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <cover.1694768423.git.bo.wu@vivo.com>
 <cc15b558e202197a424323e44ccece7bbb807434.1694768423.git.bo.wu@vivo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <cc15b558e202197a424323e44ccece7bbb807434.1694768423.git.bo.wu@vivo.com>
X-Headers-End: 1qisuI-00GO47-Ge
Subject: Re: [f2fs-dev] [PATCH 1/3] f2fs-tools: use 'IS_CUR_SEGNO()' to
 check if it is current segment
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
Cc: Wu Bo <wubo.oduw@gmail.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/9/15 17:04, Wu Bo wrote:
> Use IS_CUR_SEGNO() here can make code more concise and readable.
> ---
>   fsck/mount.c | 17 ++++-------------
>   1 file changed, 4 insertions(+), 13 deletions(-)
> 
> diff --git a/fsck/mount.c b/fsck/mount.c
> index df0314d..00940b8 100644
> --- a/fsck/mount.c
> +++ b/fsck/mount.c
> @@ -2531,20 +2531,11 @@ void build_sit_area_bitmap(struct f2fs_sb_info *sbi)
>   		memcpy(ptr, se->cur_valid_map, SIT_VBLOCK_MAP_SIZE);
>   		ptr += SIT_VBLOCK_MAP_SIZE;
>   
> -		if (se->valid_blocks == 0x0 && is_usable_seg(sbi, segno)) {
> -			if (le32_to_cpu(sbi->ckpt->cur_node_segno[0]) == segno ||
> -				le32_to_cpu(sbi->ckpt->cur_data_segno[0]) == segno ||
> -				le32_to_cpu(sbi->ckpt->cur_node_segno[1]) == segno ||
> -				le32_to_cpu(sbi->ckpt->cur_data_segno[1]) == segno ||
> -				le32_to_cpu(sbi->ckpt->cur_node_segno[2]) == segno ||
> -				le32_to_cpu(sbi->ckpt->cur_data_segno[2]) == segno) {
> -				continue;
> -			} else {
> -				free_segs++;
> -			}
> -		} else {
> +		if (se->valid_blocks == 0x0 && is_usable_seg(sbi, segno) &&
> +				!IS_CUR_SEGNO(sbi, segno))
> +			free_segs++;
> +		else
>   			sum_vblocks += se->valid_blocks;

IIUC, it should be?

if (se->valid_blocks == 0x0 && is_usable_seg(sbi, segno)) {
	if (!IS_CUR_SEGNO(sbi, segno))
		free_segs++;
} else {
	sum_vblocks += se->valid_blocks;
}

Thanks,

> -		}
>   	}
>   	fsck->chk.sit_valid_blocks = sum_vblocks;
>   	fsck->chk.sit_free_segs = free_segs;


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
