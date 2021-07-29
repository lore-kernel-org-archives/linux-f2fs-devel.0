Return-Path: <SRS0=A5bl=MV=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56341C4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 29 Jul 2021 22:51:39 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1880760F4B
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 29 Jul 2021 22:51:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1880760F4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1m9EsL-0005P9-7t; Thu, 29 Jul 2021 22:51:37 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1m9EsJ-0005Oz-6O
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 29 Jul 2021 22:51:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Em+StHylaptoSmhfajWHpxhtetWe2aJ9Xl/cEhtozrA=; b=MOvivsGqhaM5g5PBl7XdVs5PD0
 uQYjUeWR7Zrr0fc7OfnaMebARfotUU9ze5G/c1UVjurs9pcpVSJi8Ea5GkSHZuqphEnFu/tFR6Wrj
 L2JwZliehOGbxb/j9q8VhT+rRYVFreU1NSIgnST8wqgYJfcznz421irCbVQLKZxF45D0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Em+StHylaptoSmhfajWHpxhtetWe2aJ9Xl/cEhtozrA=; b=jQn9j8BBl2bkZduQlcvZb5R7CJ
 KTXJDO4DrXlB1k4Nz7zP1vvyrTq4zYOidz/7DFTzwDj+JF/GnZ9dW+klbL3iy8Zihob43c7+ey7/w
 vtnQPnSz6OoKiYSeWQcN8gF+RvanuGMnKvAfNcjxRVlw86QD/+6sy1jNgPYF7eFKyie8=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1m9Es8-0072Pd-7C
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 29 Jul 2021 22:51:35 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 450736023E;
 Thu, 29 Jul 2021 22:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627599078;
 bh=CcoVvdaUEJ4hNSxZtFmgxQoFCn0/MeIH+Fu9CTIgsNU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=IKHxuMjyM2ZpOaccpg6ZB98aZBJp1UM6Nfbjpj1eRXzWblrrUFZvyloRMtE4XGn2N
 cnU8jIcI1R9y43wuVi4i8UoCZTu8U6R65oAymG/ENh+sySgB3oyj+IFg7URi9kqphD
 nUoBqwQzw5vTcivqTq6/QovmmAO962Tv7aszRxJ4uRV8+MSHXJHaP9SV4qOYrezHno
 Gyqr3UbrYAi0wb5F5f/bMByQfKmusPCrNGoy4i+LK8H9Po+SbYFX5oNy6sutJ5CFKh
 8rarVuzoc6HXiOGjZCAepMLVc3icq1bpDzaTodKzXbZhbltvfPxAPeNinaYB03aJXf
 OACP3vUkDmfAA==
Date: Thu, 29 Jul 2021 15:51:16 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Message-ID: <YQMw5BjrJttrnOLR@google.com>
References: <20210726041819.2059593-1-daeho43@gmail.com>
 <f9555521-8878-2d46-36f1-3032bb8bbc0a@kernel.org>
 <YQA/orZ5wXjwWeyy@google.com>
 <8c0d05d2-3988-a8a4-5403-1173f25b822b@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8c0d05d2-3988-a8a4-5403-1173f25b822b@kernel.org>
X-Headers-End: 1m9Es8-0072Pd-7C
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: change fiemap way in printing
 compression chunk
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
Cc: Daeho Jeong <daehojeong@google.com>, Eric Biggers <ebiggers@google.com>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 07/29, Chao Yu wrote:
> On 2021/7/28 1:17, Jaegeuk Kim wrote:
> > Do we really need to catch this in fiemap? What about giving the current
> 
> Yes, I think so.
> 
> > layout with warning message and setting NEED_FSCK?
> 
> Sure,
> 
> How about doing sanity check on cluster metadata whenever it is going to
> be accessed, like we did for single blkaddr with f2fs_is_valid_blkaddr()?

I think that'd be viable.

> 
> Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
