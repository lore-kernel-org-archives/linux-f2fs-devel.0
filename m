Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E84C35FFC
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 20 Mar 2025 02:26:23 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tv5bw-00066V-IL;
	Thu, 20 Mar 2025 02:26:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1tv5bv-00066G-7x
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 20 Mar 2025 02:26:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6ZNLtBoUWdOYFc3fW9n5uOzf9HxZCTS5hUN5OlK7nn8=; b=Npax8Pm+yUPJoP9QBwOyTGjdZV
 K8ziTUpz9TkEeWnSdaOnmJii76qfiCw07VCELGxOSjYrqEhjQJA5vXrokU4ofbYT5weYM1D/NTLYn
 uRoA7Hoh7TUTczs1EyvqbV8TjICdRPSfaI8c780aKD1MORBZKeAS5lQg3Cmj2Vd4G140=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6ZNLtBoUWdOYFc3fW9n5uOzf9HxZCTS5hUN5OlK7nn8=; b=l0K9FP5Tk+d9Z+ETXdF+zoe7Kj
 +ackjuQfqdGAtbyikY2ezDqf4rmSy0wNHHGnIYMOK7DToBtrZ7aE+lH4Ugla8M6BY5YGs0G05ovY6
 hOHiYTNnrsaSNATzpfXfPcfmC9q5YXiv9ZTc9rTa7iDe56gIWRu/JKKTcrGPvzNeA0Ak=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tv5bq-0007mZ-D2 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 20 Mar 2025 02:26:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 106E15C6698;
 Thu, 20 Mar 2025 02:23:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E863C4CEE4;
 Thu, 20 Mar 2025 02:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1742437563;
 bh=wd4bDV3Pbt8B3W9w906X2pNdOFxkfrKKq9cy9tqyocI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NW0iqYGr9u018xkh9A+wagJOm0WjRvlK8XZjDMnPzm7eFCXN/lkzjOH3lxtTQQCPR
 KPluGt7UgPwguLuAJmccnFOjURi4XuYP8Au49RM8AdV99eePCDj15xIPRK1OmeAbaK
 4KYVoFL45mkH/znPMB+2kJg9ww8qMcHS6uZ0lp1hwIn7Xi4p5AW6tVvRFKdIe900h9
 sBUNUOCF+G4kKP5lBe7QHINoArAa1yYiSxqJrDhE8/3VNdyzkRhfU1NVTggOIjKN8T
 AUZ5ZwJ+s0mt6U7OaMIz4n6uEE8Hgimv4moGsFN332LTOhn7+UBHBHx+htarvt+gC2
 dq0jr92Ej7xEg==
Date: Thu, 20 Mar 2025 02:26:01 +0000
To: Dan Carpenter <dan.carpenter@linaro.org>
Message-ID: <Z9t8uTQOmVB4ue2B@google.com>
References: <20250319113011.791319-1-colin.i.king@gmail.com>
 <a9c06462-5fd2-4724-9d44-0285f281ecec@stanley.mountain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a9c06462-5fd2-4724-9d44-0285f281ecec@stanley.mountain>
X-Headers-End: 1tv5bq-0007mZ-D2
Subject: Re: [f2fs-dev] [PATCH][next] f2fs: remove redundant assignment to
 variable err
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
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 Colin Ian King <colin.i.king@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 03/19, Dan Carpenter wrote:
> On Wed, Mar 19, 2025 at 11:30:10AM +0000, Colin Ian King wrote:
> > The variable err is being assigned a value zero and then the following
> > goto page_hit reassigns err a new value. The zero assignment is redundant
> > and can be removed.
> > 
> > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> > ---
> >  fs/f2fs/node.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> > index 5f15c224bf78..37c76bb19a8c 100644
> > --- a/fs/f2fs/node.c
> > +++ b/fs/f2fs/node.c
> > @@ -1497,7 +1497,6 @@ static struct folio *__get_node_folio(struct f2fs_sb_info *sbi, pgoff_t nid,
> >  	if (err < 0) {
> >  		goto out_put_err;
> >  	} else if (err == LOCKED_PAGE) {
> > -		err = 0;
> >  		goto page_hit;
> >  	}
> 
> We could remove the curly braces as well.

Applied as below. Thanks.

@@ -1494,12 +1494,10 @@ static struct folio *__get_node_folio(struct f2fs_sb_info *sbi, pgoff_t nid,
                return folio;

        err = read_node_page(&folio->page, 0);
-       if (err < 0) {
+       if (err < 0)
                goto out_put_err;
-       } else if (err == LOCKED_PAGE) {
-               err = 0;
+       if (err == LOCKED_PAGE)
                goto page_hit;
-       }

        if (parent)
                f2fs_ra_node_pages(parent, start + 1, MAX_RA_NODE);

> 
> regards,
> dan carpenter


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
