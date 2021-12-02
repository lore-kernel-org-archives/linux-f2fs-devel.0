Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B7EC433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  2 Dec 2021 18:36:13 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1msqwG-0000wf-Ng; Thu, 02 Dec 2021 18:36:12 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <ebiggers@kernel.org>) id 1msqmP-0000nm-DU
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 02 Dec 2021 18:26:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XDzCe767SmWQMiM/qBlcNmqtCnigR1qnn9qVaaIuYjI=; b=Tdxl1SGcAybTSdKDN6vcMIIBhR
 W2t1/E7rGOHFxekyCZrU2XXWVRjlwBAREm+2/ZL/gpz+7/tTmqlkf5HTaVYpMz12C+sW5U7KMKRdM
 br/xnyaogXswjtxlehanr3R58GBuLfc371eKzPzpM4igpeic/JdziG0HEWoFfvLHM22Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=XDzCe767SmWQMiM/qBlcNmqtCnigR1qnn9qVaaIuYjI=; b=DkYsr7Yq2/N1w8UosOaOmZ0Wp3
 enRQghmTGehnrvVPimqk+NdDt45qYLXVVzyemEh0kVcSAapmJB5sqC21rKdyOKGETZ77PlzFiX7EK
 cebAueGb3e5YLcHB5jibx4umpKrSgs4sosebNx7klhkjJbRyz2FLajudjolJmvKRPbsU=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1msqmO-0007yJ-SA
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 02 Dec 2021 18:26:01 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 392866279C
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  2 Dec 2021 18:25:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81569C00446;
 Thu,  2 Dec 2021 18:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638469551;
 bh=o2r1iA58GRDamQyALDCHeB90Mhv0GeLSXU5yXMYXgmo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oHJdV2HOJaEjgLAbE+0qdY37gZEfTUBnx2Z/7uNKrHpMBeGmUaMJVyl56+IARF70Y
 55mEtthtdRT/vZ3ahgX85pIv2fD5rBy/vs3H35SPSiQC2D8kmgd0ynW9CUnpJ9i/GX
 pgBHRZeDcRKVkSveM2zByz78gucOp73oKR1qWdbm/aD6vk1VWvcUur2p3XO4iTttjR
 Zui8UnYJqRDLYGYv2o5NH3uv10LE/TNWQfENr1tIjp9Zjv9G1ixn+iIvxmMGHej/TR
 vlYOCAi7dz6A7aY50zAYv0o2e1fgMrFhtx9bzwG1jDaosh5N8iuK0CzmNSoKcRQYec
 o1Ds6VXHTOkQQ==
Date: Thu, 2 Dec 2021 10:25:49 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Chao Yu <chao@kernel.org>
Message-ID: <YakPrVPz5+qQm3kQ@sol.localdomain>
References: <20211116214510.2934905-1-jaegeuk@kernel.org>
 <20211116214510.2934905-5-jaegeuk@kernel.org>
 <b36e2d44-4834-3931-6a32-4fa52d1d7785@kernel.org>
 <YahIf3UlhuxJT1O4@sol.localdomain>
 <1ba0f002-42c7-b085-0c54-6071664ba79b@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1ba0f002-42c7-b085-0c54-6071664ba79b@kernel.org>
X-Headers-End: 1msqmO-0007yJ-SA
Subject: Re: [f2fs-dev] [PATCH 5/6] f2fs: implement iomap operations
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, Dec 02, 2021 at 10:04:11PM +0800, Chao Yu wrote:
> On 2021/12/2 12:15, Eric Biggers wrote:
> > On Thu, Dec 02, 2021 at 11:10:41AM +0800, Chao Yu wrote:
> > > Why not relocating this check before f2fs_map_blocks()?
> 
> Wait, it supports DIO in multi-device image after commit 	71f2c8206202
> ("f2fs: multidevice: support direct IO"), how about
> checking with f2fs_allow_multi_device_dio()?
> 
> Thanks,
> 

Okay, that was not the case when I sent this patch originally.  We'll need to
update this to support multiple devices.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
