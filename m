Return-Path: <SRS0=6WiR=KV=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A758C47088
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 26 May 2021 14:02:26 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E003613C9;
	Wed, 26 May 2021 14:02:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E003613C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1llu75-0005UL-F2; Wed, 26 May 2021 14:02:23 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1llu74-0005U9-EV
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 26 May 2021 14:02:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=M/MlrD8MpdY2dHVit2eFCgTTGbgNWZmMBF1oBnjSkU8=; b=FMWLC7izWfNAsfkD4wgqfpfKRI
 AgMD5FHxxCj8dpV7jaD2jEbrm5oI1Xpj2HL0Dn7ZWaiV/JOQyXtU3n11Q9gJfQ6+kFsWR9p7bvAmD
 Zxjmmfr9BLikl9OozLFAFmQLtboPUml4/IxRYtAl7VgkTkASlvBbQVD+d0demxKKdUgY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=M/MlrD8MpdY2dHVit2eFCgTTGbgNWZmMBF1oBnjSkU8=; b=Zm6Io5/rnnJzEYXuydC6GN67/8
 hkSV/JaRbujCFuxt8gaWVo5JzJ64UQSVpTHA3qLKEd97+KB6VI8TvcqFnE/CFF2qOukNq77X7uog3
 gF/CvL8rVWuE7CyUvGGRGuY0gJRa4IjnmZY/MGtlEDVKjDCOfrIxOVQuLut53ZQAByhE=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1llu6w-0002Io-0T
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 26 May 2021 14:02:23 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9DE4861260;
 Wed, 26 May 2021 14:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622037729;
 bh=ZOZJp2WdVCkYj0Es/mOcXSzkMoXCayinr6ObnjkqIPY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rh3DN6RLhMBijEbGzaG1PJ4MXvqxfNzwI1Z/BPu7CjTBiU6+2qj7jTxDtAMHT3CAn
 UteRZbiXBpb0ME66DgLND1TlvprBJd/hYJhePGAZ18Y51bpSEHROrv/lKB0nD9uVg4
 FmI98z2dUxRolzq82jOf7/jq/qgTdqbxOv+eoqRTaXOc3ksB/5njDsivcwAZJ6KkWC
 DjqvHo9iDohV1ECZCZz1QKGs4hHFH33clX8Da3IV1BMBkEJK4Yh8Ih0ppCfLYpfa7z
 CbsklWG7Ryl4NK26rxpPtSvUZtY8Bz7dmHgmaxWDWiqpUZVUjs50Wk+YzLBeR1ooZF
 ArGKleioJnk7Q==
Date: Wed, 26 May 2021 07:02:08 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <yuchao0@huawei.com>
Message-ID: <YK5U4GmF8BgMR3Kd@google.com>
References: <20210521190217.2484099-1-jaegeuk@kernel.org>
 <33c5c36e-b5e1-cecc-fdc4-28a173a5b0a1@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <33c5c36e-b5e1-cecc-fdc4-28a173a5b0a1@huawei.com>
X-Headers-End: 1llu6w-0002Io-0T
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: immutable file can have null
 address in compressed chunk
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

On 05/26, Chao Yu wrote:
> On 2021/5/22 3:02, Jaegeuk Kim wrote:
> > If we released compressed blocks having an immutable bit, we can see less
> > number of compressed block addresses. Let's fix wrong BUG_ON.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> 
> It looks it will be better to merge this into
> ("f2fs: compress: remove unneeded preallocation")?

Right, fixed there. :)

> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
> Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
