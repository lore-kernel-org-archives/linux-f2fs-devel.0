Return-Path: <SRS0=uuFX=5H=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E8E5C4332B
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 22 Mar 2020 14:58:09 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14A432072D
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 22 Mar 2020 14:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="e0/GCoqF";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="LooJOQVN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14A432072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jG23E-0000eC-6d; Sun, 22 Mar 2020 14:58:08 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <joe@perches.com>) id 1jG237-0000dv-Kp
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 22 Mar 2020 14:58:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Content-Type
 :References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+2ZXRkwqW4xtY6eDH9Bk3rHzI4EbYyHR4X38i/zHbDA=; b=e0/GCoqFb94gKR44muc8Skreum
 bNBrk1Hz72EbTXIwIVIIaRi8ORXEgimE3yRTCS2Npkbl94RlPNfEZ1oMXp0Cf/HDg4Gii61ysYyi3
 CSn6s87+Rc+RKp876nY430mFSuz4hDfAo3JAhLw7BerwRWMOgq5+HVFZjjWLH+idyxxY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:
 In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+2ZXRkwqW4xtY6eDH9Bk3rHzI4EbYyHR4X38i/zHbDA=; b=LooJOQVN0msDkUDPL78KokwUcF
 BijMpN7tIT6Ps3l7AkJQo3FlxEQQiL1raLG0WpgTxujv3v5TieGpl8y9qTQcnyHmeYOj8ipBR+/BY
 8L3xb2m35WA+YtdFRrokVPC/+Ju4WE2NYS9MxhIGWQiibO/YgY6wtrnbr+KGOGpXe1XY=;
Received: from smtprelay0254.hostedemail.com ([216.40.44.254]
 helo=smtprelay.hostedemail.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jG233-00Clsm-HU
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 22 Mar 2020 14:58:01 +0000
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay08.hostedemail.com (Postfix) with ESMTP id 8E4F0182CF665;
 Sun, 22 Mar 2020 14:57:50 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: steel34_a211d3b44761
X-Filterd-Recvd-Size: 1815
Received: from XPS-9350.home (unknown [47.151.143.254])
 (Authenticated sender: joe@perches.com)
 by omf05.hostedemail.com (Postfix) with ESMTPA;
 Sun, 22 Mar 2020 14:57:49 +0000 (UTC)
Message-ID: <d88cce8ff37f336087899226668abcbcacd96baa.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: Chao Yu <chao@kernel.org>, jaegeuk@kernel.org
Date: Sun, 22 Mar 2020 07:56:01 -0700
In-Reply-To: <20200322135614.10413-1-chao@kernel.org>
References: <20200322135614.10413-1-chao@kernel.org>
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
X-Headers-End: 1jG233-00Clsm-HU
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix potential .flags overflow on
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

On Sun, 2020-03-22 at 21:56 +0800, Chao Yu wrote:
> From: Chao Yu <yuchao0@huawei.com>
> 
> f2fs_inode_info.flags is unsigned long variable, it has 32 bits
> in 32bit architecture, since we introduced FI_MMAP_FILE flag
> when we support data compression, we may access memory cross
> the border of .flags field, corrupting .i_sem field, result in
> below deadlock.
> 
> To fix this issue, let's expand .flags as an array to grab enough
> space to store new flags.
[]
> +static inline void __set_inode_flag(struct inode *inode, int flag)
> +{
> +	if (!test_bit(flag % BITS_PER_LONG,
> +			&F2FS_I(inode)->flags[BIT_WORD(flag)]))
> +		set_bit(flag % BITS_PER_LONG,
> +			&F2FS_I(inode)->flags[BIT_WORD(flag)]);
> +}

I believe you don't need to do anything like this
but just let test_bit and set_bit do the indexing.

	if (!test_bit(flg, F2FS_I(inode->flags)))
		set_bit(flag, F2FS_I(inode->flags));

And there already is a function called test_and_set_bit()




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
