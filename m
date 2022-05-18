Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 512F1C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 18 May 2022 00:15:53 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nr7Ly-00065L-40; Wed, 18 May 2022 00:15:50 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <tytso@mit.edu>) id 1nr7Lx-00065F-De
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 18 May 2022 00:15:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nLsux+bfQ0hRDpmEXS+VWMhm89TTeh444O+sN/+s48Y=; b=epsKi8GrmccqP1eJQqk7ZHu/98
 xn8dajh36+chlyUIvVOYN7jiRTg0WdC6ke6vX2gR9iaKz/eP5iJlaM/6afyGi1uJCw3aoj1BKWcZL
 PNFvj18N0IREIp4eeLpvSDi9DCI+KxpZb2/bot6gJT1Ew1vWsZwm3CKwNHXeauFBM3ZY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=nLsux+bfQ0hRDpmEXS+VWMhm89TTeh444O+sN/+s48Y=; b=SpzzN+Z5NQMnrr3PO8xgGxVg7c
 0RHd8kXAuxbJUB2iNqpyehgaEkhJdcC8YrDXrYd4gKnTMN+zZojsv8P7BCAz3TFijNRrYvAjrthBn
 6aV/MTN4ocKGk/nP5VjQJpvr6HYq2AIUpSPpZnkYF8jAqou2oDmfL4rhya1CPSLzZAqQ=;
Received: from outgoing-auth-1.mit.edu ([18.9.28.11] helo=outgoing.mit.edu)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nr7Lw-00060Z-IQ
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 18 May 2022 00:15:49 +0000
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net
 [108.7.220.252]) (authenticated bits=0)
 (User authenticated as tytso@ATHENA.MIT.EDU)
 by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 24I0FXpI008562
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 May 2022 20:15:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
 t=1652832935; bh=nLsux+bfQ0hRDpmEXS+VWMhm89TTeh444O+sN/+s48Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=KDgpYTicDX1UqyJA1019FH5KvR050Y4UMYITmPAt7aAmloOpjj1E1FJhMm/FQV0SY
 ge+GzB4KI1dUSJ2txAHPFrqOY/m+avFf4C1hbUCLxnthdpAdWhkBNJWUiaEAstu+9K
 vxxB25NifWUElpWe1l92wRrxYqhFAvpjLgBlvhgayP1ZrNS9Nemb+hhYuSGePYq8Uw
 DAcpQolW+O99Sk4azk8hAEV731c2lQHfLGly2WAL+6D8L3HTC+PkDltJYbUyyStLXa
 9ouXYUxerIs3eMx5K0bK32hqaacZc6M2HBIIExcdz6W/NhHzmLiFuSxfKFQL9EFGxQ
 pssISW+/DRbjg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
 id F331C15C3EC0; Tue, 17 May 2022 20:15:32 -0400 (EDT)
Date: Tue, 17 May 2022 20:15:32 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Gabriel Krisman Bertazi <krisman@collabora.com>
Message-ID: <YoQ6pPw/ITJtc310@mit.edu>
References: <20220511193146.27526-1-krisman@collabora.com>
 <YoP5jH5axe9ltX2Y@mit.edu> <87y1z0vsoe.fsf@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87y1z0vsoe.fsf@collabora.com>
X-Headers-End: 1nr7Lw-00060Z-IQ
Subject: Re: [f2fs-dev] [PATCH v4 00/10] Clean up the case-insensitive
 lookup path
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
Cc: kernel@collabora.com, linux-f2fs-devel@lists.sourceforge.net,
 ebiggers@kernel.org, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, May 17, 2022 at 03:57:05PM -0400, Gabriel Krisman Bertazi wrote:
> 
> I'll be reworking the series to apply Eric's comments and I might render
> patch 1 unnecessary.  I'd be happy to send a v5 for the whole thing
> instead of applying the first two now.

OK, great, I'll wait for the v5 patch series.

Thanks,

						- Ted


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
