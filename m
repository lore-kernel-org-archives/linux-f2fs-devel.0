Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2259C61DD3
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  1 Sep 2026 12:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SuGbvMY8hdnnXUv0zTJmsOiMBo2iCtpSFmvynopksn4=; b=k9gx1GWgFGDyt9Xr66JVNTrW/q
	Y4VFoVpf/FwxxohNWAmgLOU2Ndv+3tGQWXxtXTtagRJ75eDiAss2A6mBpSZmHUvx9PSwJM1mLA1Or
	TM2/6Qx6qfGX8ggYJUX5kV1VZGYXGudOy+8uWK1bT0wkiK6uCJqGNSaE8osWfhLtbV9M=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x1Nl0-0006PU-EI;
	Tue, 01 Sep 2026 12:38:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x1Nkz-0006PO-RV
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 12:38:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pG6pq+g9QZo4FaYnQsrkXq9VfyWEAlzBgyFTRaAjOio=; b=KQleXWxMloHueK0G/4SvTw7Qgy
 GIRmQ9yonhKqMxgVb/3DbOUJs6S8a+VwhAz33xTqSE/awSkb2MjGzT5pustaYA+tu6kgAnPPSGjdr
 g5G1LsrVleVQOD33hc+8CgD7ZiloZyfv+ky7DxFoy4HrJLQ2QhmjhJH3PDNvDp9PrVvQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=pG6pq+g9QZo4FaYnQsrkXq9VfyWEAlzBgyFTRaAjOio=; b=TsPhWtTTtf+GTUEXWObxdaUltM
 LtK/U6aa81DwYX1sQx2CbJEIoXQWlh/v/Vin4hNXYZHwV33KMCa5WXBq6A6f6d8MWidl5kKQsMeO+
 fV6KB72UKNZbjysTAkSADd96JMrItCRX2y0zVM2pBFOg+kUiYq6rTXGF4HQ8NJT8vGtg=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x1Nkx-0007sX-VK for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 12:38:30 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0059342E1A;
 Tue,  1 Sep 2026 12:38:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58F91F000E9;
 Tue,  1 Sep 2026 12:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788266300;
 bh=pG6pq+g9QZo4FaYnQsrkXq9VfyWEAlzBgyFTRaAjOio=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=EfIF4r9u16TKu9LDPL9yKKNv6SUK5MCDqbQ8QbRzKxbc5DryPLkSVgcp/LWToT7HU
 +UB6g2lmXDOhI9Fhh94jsXlASYIC6cBxoy2oJk774Y+EHEsGCi7E6sVspW/MDSNfHu
 UZJ3ub+Q3JRr9/Rv385tvgC9K13ip17/gsHp/gAtHYSGfJhbzdZ9m75tjfrFCtyQY5
 Uxc3VY3oOLb95S6Gsa3yJHrFKGbU88Vqv9R5JX38kPoVCr5ZTlCTrF8dHWaKq5tykD
 6MHi1nBdNhoSLln7Bvx2WZyzFaO+DlOt1A/0YC9q0ePfCVIic2XoLEGL7l447dFqfs
 VqIf3dHGYPPig==
Message-ID: <f633cdb1-f00c-46e9-b159-bcb51fdc49d3@kernel.org>
Date: Tue, 1 Sep 2026 20:38:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wenjie Qi <qwjhust@gmail.com>, jaegeuk@kernel.org
References: <20260831133916.2110470-1-qiwenjie@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260831133916.2110470-1-qiwenjie@xiaomi.com>
X-Headers-End: 1x1Nkx-0007sX-VK
Subject: Re: [f2fs-dev] [PATCH] f2fs: wait for inode record work before
 clearing ino bitmaps
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
Cc: qiwenjie@xiaomi.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/31/26 21:39, Wenjie Qi wrote:
> APPEND/UPDATE inode state recording was moved to the inode eviction
> workqueue. These entries were later converted to bitmap values stored in
> XArrays, but the workqueue drain was left behind in the list cleanup loop
> where it is now a no-op.
> 
> During unmount, inode eviction work can therefore remain queued when
> f2fs_release_ino_entry() destroys the bitmap XArrays. A delayed worker can
> repopulate them before the workqueue is finally destroyed, leaking newly
> allocated XArray nodes when the F2FS superblock is freed.
> 
> Wait for APPEND/UPDATE inode record work before destroying each bitmap
> XArray, restoring the required ordering.
> 
> Fixes: 9a9ee7408a1f ("f2fs: reduce memory footprint of ino management")
> Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
> ---
>  fs/f2fs/checkpoint.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 4b59f30ef45d..400eab730c14 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -902,6 +902,8 @@ void f2fs_release_ino_entry(struct f2fs_sb_info *sbi, bool all)
>  	for (i = APPEND_INO; i < MAX_INO_ENTRY; i++) {
>  		struct inode_management *im = &sbi->im[i];
>  
> +		f2fs_wait_for_inode_record(sbi, i);

We need to remove f2fs_wait_for_inode_record(sbi, i) from above loop for cleanup?


Thanks,

> +
>  		spin_lock(&im->ino_lock);
>  		xa_destroy(&im->ino_root);
>  		spin_unlock(&im->ino_lock);



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
