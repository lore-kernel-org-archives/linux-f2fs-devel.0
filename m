Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D31C46467
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 11 Jan 2023 18:50:44 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pFgBP-0006SJ-IR;
	Wed, 11 Jan 2023 18:50:42 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1pFgBO-0006SC-4O
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Jan 2023 18:50:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xg3XkiowJNDfo0s8zYw9Hlw7bOFm1QpXVn6+k0hxdfs=; b=fnpFRGAPrc3KIsZTFtejjD/h44
 hp8s3ngTDtYEnu6/Phx1eOjTUYh22jrAHgphxXlJe4UFQkh9EdCX+RfFDRWNVqaaZHigmwMiW5ie8
 RTobo00mpUzEligWRqumNHrRmKTnn+rwe7d3OB78jzStT9E5d3GsuUgmkO0BqwEm5kAw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=xg3XkiowJNDfo0s8zYw9Hlw7bOFm1QpXVn6+k0hxdfs=; b=ER4cf7SCGqTb+ZKhzgHEpqYNYd
 4wAM5r3113QuB1QzB45rdfH3FL2xNm/6JpUAh+lWWe0hnJgZg4iOqALDIBo8i6FW8NCXVsNayNEFl
 SEnehyn9qrmo4nRn1TSTS6Usmd3E5Y/mD8UzOBIyVBVBAPDBvsUN12Soc5kIQqKA6WQA=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pFgBK-00EHPq-RK for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Jan 2023 18:50:40 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id BEED9B81C0F
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 11 Jan 2023 18:50:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA2DC433D2;
 Wed, 11 Jan 2023 18:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1673463030;
 bh=QasiENd9bQiKisFz/wSTOxxKyJP0Z+R/8glnxbreHwQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XKp+ITw5MV+TlFfz1DuMuORnI4jtZKlThYSGjDdQKpoaUvY15dmekatCk8TrqUk0K
 wf1IBxtgvgcbst9AzFj3O9geFANe+G1FVFrpQfKBvXu8Tg89f2lI4pVR5f4eZBB/jv
 9k+STM0m7SSzpuuslmNxrRtGuLtsbePH5zVCQYsvspa7g0kBrG4+Bs0217pKg7pECw
 rXraBzAG741lR7+zYf6ZZAlyQQVirdUpq03ewSXLuwzT4gYQdVwX6ZF0nZjgUMAY8J
 RC/BNyayVRNERte5BNKE9vrSh5za0ryHtFecCK+TX71Ax+avEIoo8vSfMADLZRxS1c
 WNSfEng3sM9zA==
Date: Wed, 11 Jan 2023 10:50:28 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Message-ID: <Y78E9NpDxtvr2/Hs@google.com>
References: <20230105233908.1030651-1-jaegeuk@kernel.org>
 <Y74O+5SklijYqMU1@google.com>
 <77b18266-69c4-c7f0-0eab-d2069a7b21d5@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <77b18266-69c4-c7f0-0eab-d2069a7b21d5@kernel.org>
X-Headers-End: 1pFgBK-00EHPq-RK
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: retry to update the inode page
 given EIO
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
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 01/11, Chao Yu wrote:
> On 2023/1/11 9:20, Jaegeuk Kim wrote:
> > In f2fs_update_inode_page, f2fs_get_node_page handles EIO along with
> > f2fs_handle_page_eio that stops checkpoint, if the disk couldn't be recovered.
> > As a result, we don't need to stop checkpoint right away given single EIO.
> 
> f2fs_handle_page_eio() only covers the case that EIO occurs on the same
> page, should we cover the case EIO occurs on different pages?

Which case are you looking at?

> 
> Thanks,
> 
> > 
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Randall Huang <huangrandall@google.com>
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> > 
> >   Change log from v1:
> >    - fix a bug
> > 
> >   fs/f2fs/inode.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> > index ff6cf66ed46b..2ed7a621fdf1 100644
> > --- a/fs/f2fs/inode.c
> > +++ b/fs/f2fs/inode.c
> > @@ -719,7 +719,7 @@ void f2fs_update_inode_page(struct inode *inode)
> >   	if (IS_ERR(node_page)) {
> >   		int err = PTR_ERR(node_page);
> > -		if (err == -ENOMEM) {
> > +		if (err == -ENOMEM || (err == -EIO && !f2fs_cp_error(sbi))) {
> >   			cond_resched();
> >   			goto retry;
> >   		} else if (err != -ENOENT) {


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
