Return-Path: <SRS0=6Xs1=NI=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7AAC4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 17 Aug 2021 00:32:41 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7F3960F39
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 17 Aug 2021 00:32:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D7F3960F39
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mFn20-0000hz-8p; Tue, 17 Aug 2021 00:32:40 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <jaegeuk@kernel.org>) id 1mFn1z-0000hs-0e
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 17 Aug 2021 00:32:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gVyCLADu1S3I8dbfZ+l+c+kzqDdn9AQH5fT+gToGmEg=; b=jecDcJEwFyiZ3C+6I7eEGWb2To
 K+y/fdLGlxqiRGw3rSlfaXF1NJS/Ts22mR/QAqKNr475g3WTozrC6Cea2zrqo3vy4BGceEpA9as3a
 HbVCi2oYcbi2QcCNfcA7U5D/8mUz2MRAkTkRG3+NMdWsbmW36eSF48n4NpmggWP26fAY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=gVyCLADu1S3I8dbfZ+l+c+kzqDdn9AQH5fT+gToGmEg=; b=PTnNQH/FyPJQ2JBGTHskua8wUF
 ndN7HDm0yz0JLhiVDpmpcvLWw+FxbSi+CrNEqjg7m34mnSUNIpNR8c9PeeY2fRH7si2yyFZCu73CJ
 ASC33jKIGkwAe6t/QhprDabYGnLgu14gVUvIDZkpo8hzK7aQXftbTGznk7J6mSOIhTmo=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mFn1x-008lzO-Ty
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 17 Aug 2021 00:32:38 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6821B60F39;
 Tue, 17 Aug 2021 00:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629160352;
 bh=j9rX+xWK9KMeYx91b9UKRhQlkitsFLhEMA1h2yBt8nY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tYENyk89HM2TbfLyJp5wREcKgeWDA/6SghlpVDulriDNQnbxcmGqe9JLpjTFWt3Rf
 LgcxQycD9bQTIEnziKejljpSHURIQizMyTM5sxslnwj+cWh0uYm5nr/MKoubwnkmIJ
 icBIRjRUlgKeg4ga6ERcLeo5uRZx6sdXKRDgBptipRqjTeyw7O+ZJmroIKVvyt/9OA
 PMi9oO/kWono4aZ9Tr7rz63lgQmP0KByY+f26kY/ABoDPJaDsOgbNE56f8s8HO74IF
 KlPkPaHkYO/dZ6k9qOa4EJKQLgmwrWkNNsMj5aG+VTopwafJW2/eImZvI2KcBG6K1s
 zYGV0HmF5zf0w==
Date: Mon, 16 Aug 2021 17:32:31 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Yangtao Li <frank.li@vivo.com>
Message-ID: <YRsDnwWZwTBFvD0/@google.com>
References: <20210816132248.276865-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210816132248.276865-1-frank.li@vivo.com>
X-Headers-End: 1mFn1x-008lzO-Ty
Subject: Re: [f2fs-dev] [PATCH] f2fs: always call f2fs_issue_checkpoint() in
 f2fs_sync_fs()
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 08/16, Yangtao Li wrote:
> Sync is always 1, so delete the check of the value.

I don't think so.

> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/f2fs/super.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 98727e04d271..b823c7e3f303 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1553,7 +1553,6 @@ static void f2fs_put_super(struct super_block *sb)
>  int f2fs_sync_fs(struct super_block *sb, int sync)
>  {
>  	struct f2fs_sb_info *sbi = F2FS_SB(sb);
> -	int err = 0;
>  
>  	if (unlikely(f2fs_cp_error(sbi)))
>  		return 0;
> @@ -1565,10 +1564,7 @@ int f2fs_sync_fs(struct super_block *sb, int sync)
>  	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
>  		return -EAGAIN;
>  
> -	if (sync)
> -		err = f2fs_issue_checkpoint(sbi);
> -
> -	return err;
> +	return f2fs_issue_checkpoint(sbi);
>  }
>  
>  static int f2fs_freeze(struct super_block *sb)
> -- 
> 2.32.0


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
