Return-Path: <SRS0=R28F=VF=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DC9C606CF
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  8 Jul 2019 23:47:52 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 564BE20693
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  8 Jul 2019 23:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="W+ntDbd7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="FManZjoZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="2hrPj8nt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 564BE20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hkdMN-0003i8-RI; Mon, 08 Jul 2019 23:47:51 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1hkdMN-0003i1-2a
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 08 Jul 2019 23:47:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8BdKv2X58uXZmSHtXLxVrAZoOPWoQuH/3pfl7NLosFY=; b=W+ntDbd7tgkpfZMu0wKqEA246y
 aVqlbLiQXmsgYNEw9NCEZy1UqeslB5WB21rH2SN61SzrpawsJmb8YMq96Y5+oWiWX/WdRahf1Wh33
 6Od1ixs8ZfPfrkik8gjXHYGu4kxwma/SRsea+HxVzcH1pPutgDASWSWU+fDZ/phe3KOY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8BdKv2X58uXZmSHtXLxVrAZoOPWoQuH/3pfl7NLosFY=; b=FManZjoZm3Hazdll1vd94OQWU6
 5EGqdWUu6u8FSktO9yNV20EfNFX5BVyJzOlHcoRZRevDEVCcIXI5Twg2kfBl+t2i8xijqYyXWg7D+
 OsQbVw+2J9wWI17ZGdNYcvBTe+GYsjnDQhfmlu8eJt1UYm6d4geTeqJaYWfchjQQKa1g=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hkdML-00Axh7-Uq
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 08 Jul 2019 23:47:51 +0000
Received: from localhost (unknown [104.132.1.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5311620693;
 Mon,  8 Jul 2019 23:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1562629664;
 bh=Cz5Bx6P52fodwps54BhyGetegFSXmNne2sxJp0+kASE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=2hrPj8ntVZhpY8EJmqztIJVe4GDZIvrObL6mQjFwHM60cbL8gV8ih/A8XoBNflH1r
 jgijOIzbrDZfQmWJQOAMCje499k4rfwS6Jvp7Cwrw/dAZVszqkFrqlsMv6RvqEalLP
 fs8lW7zYwmNfhJl0VXqTH6rbWPsDFiXp5IB/rR8s=
Date: Mon, 8 Jul 2019 16:47:43 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <yuchao0@huawei.com>
Message-ID: <20190708234743.GC21769@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190708062912.104815-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190708062912.104815-1-yuchao0@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
X-Headers-End: 1hkdML-00Axh7-Uq
Subject: Re: [f2fs-dev] [PATCH] f2fs: improve print log in
 f2fs_sanity_check_ckpt()
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

On 07/08, Chao Yu wrote:
> As Park Ju Hyung suggested:
> 
> "I'd like to suggest to write down an actual version of f2fs-tools
> here as we've seen older versions of fsck doing even more damage
> and the users might not have the latest f2fs-tools installed."
> 
> This patch give a more detailed info of how we fix such corruption
> to user to avoid damageable repair with low version fsck.
> 
> Signed-off-by: Park Ju Hyung <qkrwngud825@gmail.com>
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/super.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 019422a0844c..3cd6c8d810f9 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -2737,7 +2737,8 @@ int f2fs_sanity_check_ckpt(struct f2fs_sb_info *sbi)
>  
>  	if (__is_set_ckpt_flags(ckpt, CP_LARGE_NAT_BITMAP_FLAG) &&
>  		le32_to_cpu(ckpt->checksum_offset) != CP_MIN_CHKSUM_OFFSET) {
> -		f2fs_warn(sbi, "layout of large_nat_bitmap is deprecated, run fsck to repair, chksum_offset: %u",
> +		f2fs_warn(sbi, "using deprecated layout of large_nat_bitmap, "
> +			  "please run fsck v1.13.0 or higher to repair, chksum_offset: %u",

How about adding the patch name as well?

>  			  le32_to_cpu(ckpt->checksum_offset));
>  		return 1;
>  	}
> -- 
> 2.18.0.rc1


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
