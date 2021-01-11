Return-Path: <SRS0=V0x5=GO=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CB5C433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 11 Jan 2021 15:11:38 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCC1622795;
	Mon, 11 Jan 2021 15:11:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCC1622795
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kyyr3-0001PO-7H; Mon, 11 Jan 2021 15:11:37 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jack@suse.cz>) id 1kyyr1-0001Ox-CB
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 11 Jan 2021 15:11:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BE8Q7EbFdfK8p1KWDuQrFCi7ZiyHO1y04kvGhQifKBc=; b=DUOkr7ZKbOHeOiSIE3i5uNYOg5
 lymnZ0Wlg2GFZ91It++GX5f7C2ehvtkpEgX16niJPs0IvgTDtL9LfFeD1OvnIO5FthVyk+b0B4Rua
 qCxaUJjQzQVuKt5xRDDwh7555cU0ZdxlkOFXHmSB9lqINDG6T+Q6Sw2NOP1V2EzYVR8M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=BE8Q7EbFdfK8p1KWDuQrFCi7ZiyHO1y04kvGhQifKBc=; b=KlJbKfK9rtFa3ElM+3UohKIC8Y
 RwkIL8KvTIEe1vlhHdvjLTRpf3hPiwCdOai20bC/VQ7bcb+NF5QbxUbzspLzvNsagfPAfnkQdG2lS
 yDw/2kH2bc/FGqtPIJCbKCYqRmfgaiWUmeADRR4LirXN9kEJNkIfvLg72TCY2VR9qR1A=;
Received: from mx2.suse.de ([195.135.220.15])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kyyqt-001Oej-6b
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 11 Jan 2021 15:11:35 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id DDFB2AB3E;
 Mon, 11 Jan 2021 15:11:20 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
 id 868C51E0807; Mon, 11 Jan 2021 16:11:20 +0100 (CET)
Date: Mon, 11 Jan 2021 16:11:20 +0100
From: Jan Kara <jack@suse.cz>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <20210111151120.GJ18475@quack2.suse.cz>
References: <20210109075903.208222-1-ebiggers@kernel.org>
 <20210109075903.208222-12-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210109075903.208222-12-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Headers-End: 1kyyqt-001Oej-6b
Subject: Re: [f2fs-dev] [PATCH v2 11/12] ext4: simplify i_state checks in
 __ext4_update_other_inode_time()
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
Cc: Theodore Ts'o <tytso@mit.edu>, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri 08-01-21 23:59:02, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Since I_DIRTY_TIME and I_DIRTY_INODE are mutually exclusive in i_state,
> there's no need to check for I_DIRTY_TIME && !I_DIRTY_INODE.  Just check
> for I_DIRTY_TIME.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 4cc6c7834312f..00bca5c18eb65 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4962,14 +4962,12 @@ static void __ext4_update_other_inode_time(struct super_block *sb,
>  		return;
>  
>  	if ((inode->i_state & (I_FREEING | I_WILL_FREE | I_NEW |
> -			       I_DIRTY_INODE)) ||
> -	    ((inode->i_state & I_DIRTY_TIME) == 0))
> +			       I_DIRTY_TIME)) != I_DIRTY_TIME)
>  		return;
>  
>  	spin_lock(&inode->i_lock);
> -	if (((inode->i_state & (I_FREEING | I_WILL_FREE | I_NEW |
> -				I_DIRTY_INODE)) == 0) &&
> -	    (inode->i_state & I_DIRTY_TIME)) {
> +	if ((inode->i_state & (I_FREEING | I_WILL_FREE | I_NEW |
> +			       I_DIRTY_TIME)) == I_DIRTY_TIME) {
>  		struct ext4_inode_info	*ei = EXT4_I(inode);
>  
>  		inode->i_state &= ~I_DIRTY_TIME;
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
