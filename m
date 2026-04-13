Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3E69F531DF
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 13 Apr 2026 22:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IoeMHwz2CXgqD9foruQXJuHMY/t/Z9eFyxy9RAhw1q0=; b=l+mpjvxv68JCSB18qaDHx+6N0B
	FipQI2PXHEgMUbOOx9qra06mO4Hm6F5RMO2q0i2FkItgWNr2KvkfMlJ4evVxJZPSxtrtRLSZwBhdC
	GRi6A1rvinY9Uu3FA704B3ii/rXa/W4APhSMgkhSs6iQf/KEe5PX6Kyuvr7lm9X5sLDk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wCQ41-0005VQ-Qo;
	Mon, 13 Apr 2026 22:47:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1wCQ40-0005VK-VW
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 13 Apr 2026 22:47:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=72Ck8//wWhXz9s8uAFJctt5DmDg9/B70EJAbFuH3/lA=; b=m48CPy1PH+2Utn0JmO+/YI2k+p
 vh66UAPArV+AMAoERujs7o3UGFe2IKCRQoZFeBEUo8r9UY6wjkgCKOvF30OZQHhspx16rfzds5Or8
 bt1ps2x4lYSa4a5tNIkiGHjAMlBjbE3nUHjjsTC90mKmHZaR8WqEELGj8qgf+C4oKsmQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=72Ck8//wWhXz9s8uAFJctt5DmDg9/B70EJAbFuH3/lA=; b=m8QTvOGt90eGvXCuFvSZpPirvK
 J9eThZbyw76gEakpefSdQoh3v3Jh48Qwbndln7dUjhj/RZrUJjnosimP55lYFXU+RDbY6HzZ2mN/8
 jGoGlpPnp//N/MdcbqpYP36F4n63MY19oWIa8ufhr11IZ659cDlSTCXmZ52B6Ujbflj8=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wCQ40-00058n-Id for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 13 Apr 2026 22:47:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4AE35418D5
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 13 Apr 2026 22:47:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E15EC2BCAF;
 Mon, 13 Apr 2026 22:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776120443;
 bh=PBJPML5TBMWM87+bWX2GivtKR9lgNeG0jmnaOaw+fo8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ggm2pcEb6HtsWCEHl7guOnOOpQ1lwohuMHDhEePL1ne2uAOd0yd0+WK7S72A55Aft
 gCWgS8awDkko0oae0YULL7cZ7GKxaFwgS46JaR148irtVTCnHe0eY0fEbh6HzmAD3j
 9GUeJmekC/V6E5y2bU6q5SAZ6gDfYgzq3eYvK3acnRjWE4EkMIyati+v1Q/b4M7on8
 hW6Z79Kb79OBYW8WAnc++BmjbK2Vf+1vFqK3d1eJ/6myw6iPHws46Jy+lULW3u1C0C
 YvN3309+UQHfQ5Q/SqaQFxEfZrvTYgUtTux7Ja1fHseAtydwa2XsXntidglpacwXIy
 J7QMQcKG1ERww==
Date: Mon, 13 Apr 2026 22:47:21 +0000
To: Chao Yu <chao@kernel.org>
Message-ID: <ad1yedxHjn_IhgKV@google.com>
References: <20260406154940.2407853-1-jaegeuk@kernel.org>
 <adaasm42rLxRY2GN@google.com>
 <116344cd-c591-42c9-9593-2e999c2029d8@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <116344cd-c591-42c9-9593-2e999c2029d8@kernel.org>
X-Headers-End: 1wCQ40-00058n-Id
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: do not support mmap write for large
 folio
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 04/13, Chao Yu wrote:
> On 4/9/2026 2:13 AM, Jaegeuk Kim via Linux-f2fs-devel wrote:
> > Let's check mmap writes onto the large folio, since we don't support writing
> > large folios.
> > 
> > Reviewed-by: Daeho Jeong <daehojeong@google.com>
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> > 
> >   - log v2:
> >    : add comments
> > 
> >   fs/f2fs/file.c | 7 ++++++-
> >   1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index 2c4880f24b54..c0220cd7b332 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -82,7 +82,12 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
> >   	int err = 0;
> >   	vm_fault_t ret;
> > -	if (unlikely(IS_IMMUTABLE(inode)))
> > +	/*
> > +	 * We only support large folio on the read case.
> > +	 * Don't make any dirty pages.
> > +	 */
> > +	if (unlikely(IS_IMMUTABLE(inode)) ||
> > +	    mapping_large_folio_support(inode->i_mapping))
> >   		return VM_FAULT_SIGBUS;
> 
> The code itself looks good, since it's an impossible case, should we
> use f2fs_bug_on(, mapping_large_folio_support()) to catch any bug case
> rather than just returning error here w/o log?

Instead of kernel panicing for the production, I'd leave a kernel message first.

> 
> Thanks,
> 
> >   	if (is_inode_flag_set(inode, FI_COMPRESS_RELEASED)) {


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
