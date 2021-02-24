Return-Path: <SRS0=8cUc=H2=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3ADC433DB
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 24 Feb 2021 23:03:09 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 877BE64F03
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 24 Feb 2021 23:03:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 877BE64F03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lF3BT-0004Ke-RF; Wed, 24 Feb 2021 23:03:07 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1lF3BS-0004KS-TG
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 24 Feb 2021 23:03:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qk/w9ITAMed7PVKUrN621ijzAeQZLn1AIMcrH616BQQ=; b=GCiXF2Gd6Bvcn0pu/9KIYT9UHZ
 e/TOWQJcfDGzZbZ3yaYKqhEfwBgZPMxmFWpYGhze9cf4vuP/1FZ8WzCmBMAs0YwXCjUw6qoEYHnx0
 sE2JT74ZWjAgLitobUCiCNfpJpIER43fH5Kic1HWtUhmu8iVAabvwFcTLa3alrRd9Zrg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=qk/w9ITAMed7PVKUrN621ijzAeQZLn1AIMcrH616BQQ=; b=U6qs1wkdcHfXcCo2TfXSEUr7vA
 EC61WnMfVyfpgdEx2h4NVa16ImTTZV2XWZHMksKQaWsEuMwlUPIxyBcPxipWkNvo6Pv4WtbHXY3Uj
 5nZGAYya8wK0Ef0orOj0sI5qD73T285BrpnX2/KyPK4fVML+yd7RXFNx3Fcoxn019CBQ=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1lF3BK-0000r0-6M
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 24 Feb 2021 23:03:06 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9DF2B64F03;
 Wed, 24 Feb 2021 23:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1614207772;
 bh=IBfM+WxOPzT0aWvj9Rf8TeTawHRsLTUa1uwicCNO4wU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WXMJGSakSI0bXxn4InQqWzUF2LSr/J9l7fxsQ0e1zR477N/qVJRg9RLa+1TaMha6Q
 AcsUK69rYDm6P8Q+X3DjwkdRZCo416WS/xvEhouEe6iVN8jiPq96e+uOautIb5aWPz
 tqRS6AF1NnWnsU0THiRMQE/X+H/iw0Ds0Y7n8Vk8N0ODdaikbmFD+UGUTKNlddTlU7
 8TuM618FQOgsh91IZ9MTr95sa9yW/hoQEj7ToYaycPCoSQF2oj8TIbgFAMIDa4pdiy
 qi9SFWUr+hKph4T6cSN984JVFVfyNdQFyPbnsbGYlQqKzgAzsk4a8Gmen+ajKJpHf2
 asOXIUKPAKOuA==
Date: Wed, 24 Feb 2021 15:02:49 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Chao Yu <chao@kernel.org>
Message-ID: <YDbbGSsd6ibKOpzT@sol.localdomain>
References: <20210223112425.19180-1-heyunlei@hihonor.com>
 <c1ce1421-2576-5b48-322c-fa682c7510d7@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c1ce1421-2576-5b48-322c-fa682c7510d7@kernel.org>
X-Headers-End: 1lF3BK-0000r0-6M
Subject: Re: [f2fs-dev] [PATCH] f2fs: fsverity: Truncate cache pages if set
 verity failed
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
Cc: linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Yunlei,

On Wed, Feb 24, 2021 at 09:16:24PM +0800, Chao Yu wrote:
> Hi Yunlei,
> 
> On 2021/2/23 19:24, heyunlei wrote:
> > If file enable verity failed, should truncate anything wrote
> > past i_size, including cache pages.
> 
> +Cc Eric,
> 
> After failure of enabling verity, we will see verity metadata if we truncate
> file to larger size later?
> 
> Thanks,
> 
> > 
> > Signed-off-by: heyunlei <heyunlei@hihonor.com>
> > ---
> >   fs/f2fs/verity.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
> > index 054ec852b5ea..f1f9b9361a71 100644
> > --- a/fs/f2fs/verity.c
> > +++ b/fs/f2fs/verity.c
> > @@ -170,8 +170,10 @@ static int f2fs_end_enable_verity(struct file *filp, const void *desc,
> >   	}
> >   	/* If we failed, truncate anything we wrote past i_size. */
> > -	if (desc == NULL || err)
> > +	if (desc == NULL || err) {
> > +		truncate_inode_pages(inode->i_mapping, inode->i_size);
> >   		f2fs_truncate(inode);
> > +	}
> >   	clear_inode_flag(inode, FI_VERITY_IN_PROGRESS);
> > 

This looks good; thanks for finding this.  You can add:

	Reviewed-by: Eric Biggers <ebiggers@google.com>

I thought that f2fs_truncate() would truncate pagecache pages too, but in fact
that's not the case.

ext4_end_enable_verity() has the same bug too.  Can you please send a patch for
that too (to linux-ext4)?

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
