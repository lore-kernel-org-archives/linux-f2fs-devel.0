Return-Path: <SRS0=IH0A=5I=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707B4C54FCE
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 23 Mar 2020 02:02:57 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CCCB20714
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 23 Mar 2020 02:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="Iy9n5EUY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="LhO6YuQG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CCCB20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jGCQa-0005ZL-Qb; Mon, 23 Mar 2020 02:02:56 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <joe@perches.com>) id 1jGCQa-0005Z7-BU
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 23 Mar 2020 02:02:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Content-Type
 :References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7W6p7iQ5PX746ZsRnSvXqmR8MDzij/BkcoJFLMbs7Rg=; b=Iy9n5EUY5lKMjnxzlKGAslH4V0
 SdN0gghSim/g0laJjMJ021ed6HKp6VhhNgCGJyqF5qvg/J87HUWwu7PpAMmiVpBqyc1MoVQbAQ5eJ
 nK6bfzfBpqJKIK2wQk0g299GPphUGkeOpgIVXst7/cTv2vHm4yM9XLMv0G9Ifwiwfz5M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:
 In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=7W6p7iQ5PX746ZsRnSvXqmR8MDzij/BkcoJFLMbs7Rg=; b=LhO6YuQGjAvrmuvC4Ts2DrqEGm
 QS8YhPidOx743v7KjEJw3SuX66ARpYeN0L7F1YW+oomo9Igk52fYlnpTWVt3N12Lq2/zmQMd7oEPq
 k0MheRf218A1SUnGpZG8vxKWEZ5m4kc4/n9fQdIpZ6WeDkwbKFfoxx1vSsarrKFz37ow=;
Received: from smtprelay0129.hostedemail.com ([216.40.44.129]
 helo=smtprelay.hostedemail.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jGCQY-00DKYj-CF
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 23 Mar 2020 02:02:56 +0000
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay03.hostedemail.com (Postfix) with ESMTP id A55B2837F24F;
 Mon, 23 Mar 2020 02:02:48 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cakes39_8cd2320f7ba51
X-Filterd-Recvd-Size: 2290
Received: from XPS-9350.home (unknown [47.151.136.130])
 (Authenticated sender: joe@perches.com)
 by omf07.hostedemail.com (Postfix) with ESMTPA;
 Mon, 23 Mar 2020 02:02:47 +0000 (UTC)
Message-ID: <ed37a2a18060f71accb202c05724c0b66d0aa9f7.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: Chao Yu <yuchao0@huawei.com>, jaegeuk@kernel.org
Date: Sun, 22 Mar 2020 19:00:58 -0700
In-Reply-To: <20200323012519.41536-1-yuchao0@huawei.com>
References: <20200323012519.41536-1-yuchao0@huawei.com>
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
X-Headers-End: 1jGCQY-00DKYj-CF
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: fix potential .flags overflow on
 32bit architecture
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

On Mon, 2020-03-23 at 09:25 +0800, Chao Yu wrote:
> f2fs_inode_info.flags is unsigned long variable, it has 32 bits
> in 32bit architecture, since we introduced FI_MMAP_FILE flag
> when we support data compression, we may access memory cross
> the border of .flags field, corrupting .i_sem field, result in
> below deadlock.
> 
> To fix this issue, let's expand .flags as an array to grab enough
> space to store new flags.
[]
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
[]
> @@ -2586,22 +2590,28 @@ static inline void __mark_inode_dirty_flag(struct inode *inode,
>  	}
>  }
>  
> +static inline void __set_inode_flag(struct inode *inode, int flag)
> +{
> +	test_and_set_bit(flag % BITS_PER_LONG,
> +			&F2FS_I(inode)->flags[BIT_WORD(flag)]);

I believe this should just use

	test_and_set_bit(flag, F2FS_I(inode)->flags);

>  static inline int is_inode_flag_set(struct inode *inode, int flag)
>  {
> -	return test_bit(flag, &F2FS_I(inode)->flags);
> +	return test_bit(flag % BITS_PER_LONG,
> +				&F2FS_I(inode)->flags[BIT_WORD(flag)]);

here too.

	test_bit(flag, F2FS_I(inode)->flags);

>  static inline void clear_inode_flag(struct inode *inode, int flag)
>  {
> -	if (test_bit(flag, &F2FS_I(inode)->flags))
> -		clear_bit(flag, &F2FS_I(inode)->flags);
> +	test_and_clear_bit(flag % BITS_PER_LONG,
> +				&F2FS_I(inode)->flags[BIT_WORD(flag)]);

and here.

I also don't know why these functions are used at all.




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
