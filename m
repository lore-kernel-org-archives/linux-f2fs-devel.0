Return-Path: <SRS0=svdC=MO=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DAFC63793
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Jul 2021 14:21:16 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1AFF6101E;
	Thu, 22 Jul 2021 14:21:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1AFF6101E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1m6ZZa-0002sa-3E; Thu, 22 Jul 2021 14:21:14 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <greg@kroah.com>) id 1m6ZZX-0002sR-RO
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 22 Jul 2021 14:21:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PIk/hnjdDcCpZshdtUpN11tWW3zZ8Twd1XIuw3t2v9A=; b=fKM8RMEv5zipDmWVGqY3aAMjOn
 n8x/5lQqu4o3XNoXHnAsrcZwnMLwTEJn55XFZq5+UNBACLgNEMQ/RKEIbh+64cdxVZvo4OMa7otqm
 UOAQWgkulNkuM/Cy9TFjcdMkg09p1LLnMO4HVYIX+Db7FtwTwkg+Cje57vvIj5t7btes=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=PIk/hnjdDcCpZshdtUpN11tWW3zZ8Twd1XIuw3t2v9A=; b=EuL9wxWiuAEWMlY4e7HMJ+nHL/
 gDW6yH8kCGHShx4bOcm3Izx7c7kAZO5O3zkrhgjX2RZySSUJ9Q/Io4MIhcWSU6EW5RDaV2pgsTkXa
 4VPvvLzfXZg3J144QOkyqzXTebyEb5BS1lveYyPGILAibw08etBifloT8Qs//lM3cU8o=;
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1m6ZZR-00GuET-Ek
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 22 Jul 2021 14:21:11 +0000
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
 by mailnew.west.internal (Postfix) with ESMTP id C3BDC2B011CD;
 Thu, 22 Jul 2021 10:03:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute4.internal (MEProxy); Thu, 22 Jul 2021 10:03:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
 date:from:to:cc:subject:message-id:references:mime-version
 :content-type:in-reply-to; s=fm1; bh=PIk/hnjdDcCpZshdtUpN11tWW3z
 Z8Twd1XIuw3t2v9A=; b=FEd+443hzUX7l2d2yJupnpd04JIzl4zwpr50xC8aTPF
 NMErx37C4+VCbhcLdyuYUClJPHzYDBSh/R696L/J4C9s6ZOQGrGSIpoW9Zo94JsX
 Z1IzmiPK1IL2SVT9ZipkzrzYG3F7z3vWyOjPdPBlJPM4e87nBrhwDWjYJfSPneKh
 RhhO9xZFFyFXh0e/NfLPUuxJjeBbFwhYBM2oXwPp9JLQBOiXxLJSqavMQmxJKnCg
 kXBVsRBPGpu9VRNRTcnTZ+DoJ9ATg9SnfZ5wNOnCqGnJd6p3wBy6e6iqX+ghkcgL
 6YTqpUKIiXxApuCyfdA5e4BnMWBtSAafpP50KfiulzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=PIk/hn
 jdDcCpZshdtUpN11tWW3zZ8Twd1XIuw3t2v9A=; b=NBW77Rf/nXISuONKAAJ99l
 OnLxSiMA5wuLeVEsb/9oX3BH9Tzq5SxKPG/yGZHDS4Jy9czL2S7ucQZ1xdqpWPvo
 qzDYFxCw/ScWzOjdhif/MsRJ/adTax7GRrWsg2rlAx/hiVkCEgggq2svK77cwY5i
 Hdg1g99CkTMJ/Qn6sW9hLLgCu10si/GV+U6ldmpvRmFN6aggSnzuGjsSthfWsebv
 PACKvGEGfWq55jYC0OugiDwFXh6FcBY7wmEOrvXzVpsqcuuV6C9UAoJTJr1Vk3QQ
 IMUFWft9LX98w5Tor/1CFHzM0oXHDpweQ4VbfWw5IgPpdCd1jY9Vyd8kIENV4ooA
 ==
X-ME-Sender: <xms:r3r5YBgjEs9SnC-0OBgvBfTxPSyYLAzhbJReyC7TlT5xd27CqR0qVQ>
 <xme:r3r5YGCdVuj20xJ5x4GDa9UCYY4z_6hWzA10An6ePc2RDTXo-PllfjoAnDzxsPDQb
 1YMMOhvyUzV6w>
X-ME-Received: <xmr:r3r5YBGaJQpMbe2lrmUSk-b9kOAcg_u9xIjPSS-VhLDWT2O-f_F3BcQGSQI1sADJRWKpXzu-_LmIs03E_clsazuMHdYU7OeS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrfeeigdeilecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfm
 jfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepveeuheejgf
 ffgfeivddukedvkedtleelleeghfeljeeiueeggeevueduudekvdetnecuvehluhhsthgv
 rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrd
 gtohhm
X-ME-Proxy: <xmx:r3r5YGRL_STZsjgzjiTjcvaBV_wtteAN7rCxTl_c55WkOwylT9wSZA>
 <xmx:r3r5YOy1CMZwiDVdgkLSXk1_NH9AshUTiZ1gzARN_8YIQmBCBVZXMQ>
 <xmx:r3r5YM4ZngPZNmC8VnHOyIqv97tu0VYWUzuQ_miu2FXyOmZKrRq5EQ>
 <xmx:sHr5YDqb-NhNKBF7RawpCav2SP-05XUU-SEQ75nRMxdRPMv3etaH53KUcEw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Jul 2021 10:03:27 -0400 (EDT)
Date: Thu, 22 Jul 2021 16:03:22 +0200
From: Greg KH <greg@kroah.com>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <YPl6qu39ZrG1SJTw@kroah.com>
References: <20210720161629.1918963-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210720161629.1918963-1-ebiggers@kernel.org>
X-Headers-End: 1m6ZZR-00GuET-Ek
Subject: Re: [f2fs-dev] [PATCH 5.10, 5.12,
 5.13] f2fs: Show casefolding support only when supported
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
 Daniel Rosenberg <drosen@google.com>, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Jul 20, 2021 at 09:16:29AM -0700, Eric Biggers wrote:
> From: Daniel Rosenberg <drosen@google.com>
> 
> commit 39307f8ee3539478c28e71b4909b5b028cce14b1 upstream.
> [Please apply to 5.10-stable, 5.12-stable, and 5.13-stable.]

Now queued up to 5.13 and 5.10 stable, thanks.

greg k-h


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
