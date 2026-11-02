Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA5060A3833
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=YrpvygHD;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=m+jExlKz;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=iPGBV+m2;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bQa30JGC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ExADQuTbSh2PqJX85mQg28s+ecRJaXxCelF0v5xlF/M=; b=YrpvygHDcNz2Gm6ynJXLFGLsBU
	MMDkRhWMoFRqsOnoSRgqSp/RdSk8vDEN2aRbQmtGgd1vyV4UbMRkMz9uS4nDBZwHeKNV7xU35GfCi
	q8H49biGPS7fIuhqiul0k3IET1CFIU1vil7aG0YERBnB8cmw1HVCFACxqB03EtMI2OFk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xNv7e-000000002rK-41UD;
	Mon, 02 Nov 2026 16:43:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <jaegeuk@kernel.org>) id 1xNv7d-000000002rD-1iDy
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 16:43:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/lr0BMP7asm8lPzTS0i2/1MVYdtwdCx6avO+q5t7f6k=; b=m+jExlKzRtnT2arvpB0YlawdxE
 aZRi8g08mqZVkyQJUumUjdENJhQqwUJiWm4FH2JapKgzoSI6den0ZlCKQiMe6Y0sAtPbq1ZnXeW17
 MzOc9hTiUnQfZMnzNoBy4rS1L6LRox5B9hmNt5+SD+7pQ3ormMU2HHa/9Sqy7QFRQ8YE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/lr0BMP7asm8lPzTS0i2/1MVYdtwdCx6avO+q5t7f6k=; b=iPGBV+m2o+nJ7yNz+bMn3WfIKR
 H2dXDIL2oM0SDEUVrBSwBWUaYa+vqXzVw6KoID9W3VNhCG6DfDpfa/pArLzCfbc4w/rH1xxlIQnLW
 lLs8wWTqZW6BNtxO8YwrAgkZyKLirpcW0RWeafH1bBszR+H3su6ZmTwulWlHkhgQ9lfU=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xNv7b-000000005es-34br
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 16:43:01 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 518DB4128F;
 Mon,  2 Nov 2026 16:42:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D51431F00A17;
 Mon,  2 Nov 2026 16:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793637774;
 bh=/lr0BMP7asm8lPzTS0i2/1MVYdtwdCx6avO+q5t7f6k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=bQa30JGCbgufdumrmaB5sthqhQ7NtR0T0d6XsL/AcDlXXP9So7l9P4GHIayYuKRYn
 W9sWsuDrqEXIcuspeWf3ZmSuFwHfu6R1uDmRtzJWmqS7uDQaux+cQ6t15c0GqbXVjl
 8jgoeNUj16YHf5cD0d71bBeYrW0+d0dJ/++fCHXCUja4eb2TzqSvRK5vtjeBiEvDz4
 idFRU5LXmC8BHxpC5pCRFuqnZCC6oTHlLuOLRAgKEK9gs576P4EjgKnbf4x3+BxJu/
 mpWhOOjNZgC47oD+aRvxF1dbEwz+DCNSAsqR4mUEpTWzK2JdMm508xiJrejLZHXtzJ
 heoGsOlgK3Ayg==
Date: Mon, 2 Nov 2026 16:42:52 +0000
To: Chao Yu <chao@kernel.org>
Message-ID: <aui9jHfAfNBMbyvo@google.com>
References: <20261030072423.197883-1-zhanxusheng1024@gmail.com>
 <20261030072423.197883-2-zhanxusheng1024@gmail.com>
 <a096053d-3f01-42aa-a933-50145abb874d@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a096053d-3f01-42aa-a933-50145abb874d@kernel.org>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xNv7b-000000005es-34br
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: free the quota file name that
 remount drops
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: sandeen@redhat.com, zhanxusheng@xiaomi.com,
 syzbot+6c000dea1a93b4f5905c@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, Zhan Xusheng <zhanxusheng1024@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net, lihongbo22@huawei.com,
 stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/02, Chao Yu wrote:
> On 10/30/26 15:24, Zhan Xusheng wrote:
> > From: Zhan Xusheng <zhanxusheng@xiaomi.com>
> > 
> > Remounting with an empty journalled quota option such as "usrjquota="
> > clears the name, but f2fs_apply_quota_options() overwrites the old
> > string without freeing it, so every such remount leaks it.
> > 
> > Free it after a grace period, as f2fs_show_options() may still be
> > reading it.
> > 
> > Fixes: d18535132523 ("f2fs: separate the options parsing and options checking")
> 
> BTW, shouldn't it be:
> 
> Fixes: ff11d8701b77 ("f2fs: fix to allow removing qf_name")

It seems this one is correct. Applied.

> 
> Thanks,
> 
> > Reported-by: syzbot+6c000dea1a93b4f5905c@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=6c000dea1a93b4f5905c
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
> > ---
> > Tested in QEMU with KASAN and kmemleak, remounting with "usrjquota="
> > and "usrjquota=f2fs" in a loop while reading /proc/mounts: nothing is
> > reported.  A plain kfree() here trips KASAN in f2fs_show_options().
> > 
> >   fs/f2fs/super.c | 7 +++++--
> >   1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > index 510df7998c18..d86ab25fbcc5 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -1646,7 +1646,7 @@ static void f2fs_apply_quota_options(struct fs_context *fc,
> >   	struct f2fs_fs_context *ctx = fc->fs_private;
> >   	struct f2fs_sb_info *sbi = F2FS_SB(sb);
> >   	bool quota_feature = f2fs_sb_has_quota_ino(sbi);
> > -	char *qname;
> > +	char *qname, *old;
> >   	int i;
> >   	if (quota_feature)
> > @@ -1662,7 +1662,10 @@ static void f2fs_apply_quota_options(struct fs_context *fc,
> >   					GFP_KERNEL | __GFP_NOFAIL);
> >   			set_opt(sbi, QUOTA);
> >   		}
> > -		F2FS_OPTION(sbi).s_qf_names[i] = qname;
> > +		old = F2FS_OPTION(sbi).s_qf_names[i];
> > +		/* Pairs with READ_ONCE() in f2fs_show_quota_options() */
> > +		smp_store_release(&F2FS_OPTION(sbi).s_qf_names[i], qname);
> > +		kfree_rcu_mightsleep(old);
> >   	}
> >   	if (ctx->spec_mask & F2FS_SPEC_jqfmt)
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
