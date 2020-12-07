Return-Path: <SRS0=a7YV=FL=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B04CC4361B
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  7 Dec 2020 16:42:29 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9BBC23884;
	Mon,  7 Dec 2020 16:42:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9BBC23884
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kmJal-0001l4-V7; Mon, 07 Dec 2020 16:42:28 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1kmJak-0001km-Og
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 07 Dec 2020 16:42:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RDlSlUHv6RFTAHhfZdr3V3n70kGEWD5iUxt8Bi5X3Ww=; b=R6RA2u50MpcYCulXG+lqouqwMc
 2Kl+HaNtRBG34B5Fe55hI4uqc9mpl0R/5NbELKoeSvLF9G65XITzu09M0cpoXj//oSmxieQiPi/NT
 jQvRbWBN3ovq1MNPTNA7AtQAc3R46DGsGiAsF4EYsIcJvrOohJVfhXszhFyuOY2hnUXM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RDlSlUHv6RFTAHhfZdr3V3n70kGEWD5iUxt8Bi5X3Ww=; b=X7pDivX7Y15hHNQORgsCupOWaT
 TDegZtL2fMV/UtdgQxBc7ESvIvnXZOpwEOTc/uJ43dhIBQZ2mVMd7Vz049iskiwDvknxCK+AjemDt
 CrxysK/96hgEMwXxymOU2IpDoJyqsP1lE06wUrjCQX0M/37w3ItRa9OfokJ7ef0t74Yg=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kmJac-005Yqy-8S
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 07 Dec 2020 16:42:26 +0000
Date: Mon, 7 Dec 2020 08:42:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1607359332;
 bh=r39jSa7O4h4XF+mtH8ZkdKDvVNF09KuX0GRwTm1zppU=;
 h=From:To:Cc:Subject:References:In-Reply-To:From;
 b=PuveFqKDjL3pYA8tgl7/wgzAdtn5QZxJPtExTfKEto6Fl8R1rgpB37DBAbi/qGu3/
 tfbR5z4EwZp/4pHzAhPLeGM3ObvwjjSds9IV5L22ACXP3641WlC32VzvZFwBLEsNW4
 c8HSApyYTwiUk7v45i15/URjObZ+Lz9Zcg8n0hG5mNI9GTEavhjLAXvN95r5LlaOuc
 wMQw6bY7YSHsemGpq4ybnbU1L8LfGFyQ1KR7XMQOCIIOs7QjUZEXl2tbDMQejryN2+
 BUBJVZ7n3IlBXSZmhiipJB3njLMmjkq5DYAcyrrPVUVwijUGHfVu4u9IPl48vAJDOl
 N8b1tl89Cgebw==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <yuchao0@huawei.com>
Message-ID: <X85bY0Itm0vxH3+I@google.com>
References: <20201205042626.1113600-1-daeho43@gmail.com>
 <c3c41d53-2a99-17a2-223a-3d674613a417@huawei.com>
 <CACOAw_zwbmYHbUVUmzGMci9SaSVSrP8NXXavHBSSLxbAEOrMcw@mail.gmail.com>
 <c45d327f-b669-a0ec-bd77-0c95dfd8db2c@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c45d327f-b669-a0ec-bd77-0c95dfd8db2c@huawei.com>
X-Headers-End: 1kmJac-005Yqy-8S
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: fix race of pending_pages in
 decompression
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
Cc: Daeho Jeong <daehojeong@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 12/07, Chao Yu wrote:
> On 2020/12/7 15:28, Daeho Jeong wrote:
> > > It looks like it will be better to move this into merge condition?
> > > 
> > >                  if (bio && (!page_is_mergeable(sbi, bio,
> > >                                          *last_block_in_bio, blkaddr) ||
> > >                      !f2fs_crypt_mergeable_bio(bio, inode, page->index, NULL) ||
> > >                          f2fs_verify_mergeable_bio())) {
> > > 
> > 
> > I tried this for the first time, but it requires unnecessary checks
> > within the compression cluster.
> 
> We only need to check f2fs_verify_mergeable_bio for i == 0 case? something like:
> 
> static bool f2fs_verify_mergeable_bio(struct bio *bio, bool verify, bool first_page)
> {
> 	if (!first_page)

Agreed that we don't need to run this instruction for every pages.

> 		return false;
> 	if (!verify)
> 		return false;
> 
> 	ctx = bio->bi_private;
> 	if (!(ctx->enabled_steps & (1 << STEP_VERITY)))
> 		return true;
> }
> 
> Thoughts?
> 
> > I wanted to just check one time in the beginning of the cluster.
> > What do you think?
> 
> It's trivial, but I'm think about the readability... at least, one line comment
> is needed to describe why we submit previous bio. :)

I added like this. :P
https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev&id=f189a2471df2560e5834d999ab4ff68bc10853e4

> 
> Thanks,
> 
> > .
> > 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
