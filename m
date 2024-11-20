Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2422D743D7
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 20 Nov 2024 20:36:24 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tDrQy-0002OO-Is;
	Wed, 20 Nov 2024 20:36:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1tDrQp-0002O9-18
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 20 Nov 2024 20:36:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Q3nSscPG030NjqnH2O4XxEsEhCx0EFoVFUzipGoL8qw=; b=khTwd7KL/1KoNgEJkxbQIFpATG
 ITh0W3hhpFYff45CTBi0uCyaT9+Fd3KJU0FzD2EA8AJ+BeaiEbJTvbNHvyvoUZm7o5nP/e6EyieCg
 lRRCmp1CGAiafdXlCjH3ssIBUemc7gBqJ9nkukzJLL5NLh4XgxnMLfUPfjCOL0sJi9UY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Q3nSscPG030NjqnH2O4XxEsEhCx0EFoVFUzipGoL8qw=; b=hKCD9snO892Pgix7I1InT3tLzq
 iB9MN69H5HDzP8nRO2uMJS4c9jmyrs5oSXLY8iYJWMkJy53ENRsEVMa5Re6PPC41CObL0KwMXruaX
 zUzGf151pN4KlPyHEKdLWdzyN/ceu8vp0VaHX8IsZgj2KdS3+4DtP5CgRLVGf+JTFdXE=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tDrQj-00088P-Ph for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 20 Nov 2024 20:36:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 512545C4820;
 Wed, 20 Nov 2024 20:35:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE34FC4CECD;
 Wed, 20 Nov 2024 20:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1732134960;
 bh=X8FBbRmWHmatSWLjM3YTpUV6jfXsVQ1VgIdJpMCHcSI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OBfA9xirbzJPWJpZLOMX09UWwftrmYuI3LnpqOoOmNI+yN/pwtdXwdRijCyKD41tj
 x9XosnvE4MzG+d7U0fy9SKkJOF/yaQWlUUh4Z2UWhe5D8hWEo+/gnZJyHPHaBnZym4
 T8qVA851O6RjQT1ntRxz6orvEA4ujSWeZt9Pkhw89zdBbDGzqlOWjZJItAJqJlxcvO
 BJP7xbSW7HUI1SYGTgM69fKtb0GvpGKvzOzaOUNLknAM/hTOM9Yxpt/P6puRZLKgWL
 rPm6QBeSDRXrMDaxw2bsDTub280IUEXTOQQ38g+bZoWNlyuz6LPtq7Cz6kSrsotXdg
 Z1IwIYaZWJluA==
Date: Wed, 20 Nov 2024 20:35:58 +0000
To: Chao Yu <chao@kernel.org>
Message-ID: <Zz5ILj2H-F8iBSHV@google.com>
References: <20241112010820.2788822-1-jaegeuk@kernel.org>
 <ZzPLELITeOeBsYdi@google.com>
 <2d26eeee-01f7-445b-a1d2-bc2de65b5599@kernel.org>
 <Zzz5ocjKK_naOnMq@google.com>
 <35c20e47-9124-45df-8067-67c5ef29600e@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <35c20e47-9124-45df-8067-67c5ef29600e@kernel.org>
X-Headers-End: 1tDrQj-00088P-Ph
Subject: Re: [f2fs-dev] [PATCH] Revert "f2fs: remove unreachable lazytime
 mount option parsing"
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
Cc: Eric Sandeen <sandeen@redhat.com>, linux-f2fs-devel@lists.sourceforge.net,
 stable@vger.kernel.org, Daniel Rosenberg <drosen@google.com>,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 11/20, Chao Yu wrote:
> On 2024/11/20 4:48, Jaegeuk Kim wrote:
> > On 11/19, Chao Yu wrote:
> > > On 2024/11/13 5:39, Jaegeuk Kim via Linux-f2fs-devel wrote:
> > > > Hi Eric,
> > > > 
> > > > Could you please check this revert as it breaks the mount()?
> > > > It seems F2FS needs to implement new mount support.
> > > 
> > > Hi all,
> > > 
> > > Actually, if we want to enable lazytime option, we can use mount
> > > syscall as:
> > > 
> > > mount("/dev/vdb", "/mnt/test", "f2fs", MS_LAZYTIME, NULL);
> > > 
> > > or use shell script as:
> > > 
> > > mount -t f2fs -o lazytime /dev/vdb /mnt/test
> > > 
> > > IIUC, the reason why mount command can handle lazytime is, after
> > > 8c7f073aaeaa ("libmount: add support for MS_LAZYTIME"), mount command
> > > supports to map "lazytime" to MS_LAZYTIME, and use MS_LAZYTIME in
> > > parameter @mountflags of mount(2).
> > > 
> > > So, it looks we have alternative way to enable/disable lazytime feature
> > > after removing Opt_{no,}lazytime parsing in f2fs, do we really need this
> > > revert patch?
> > 
> > This is a regression of the below command. I don't think offering others are
> > feasible.
> > 
> > mount("/dev/vdb", "/mnt/test", "f2fs", 0, "lazytime");
> 
> Alright, there are other options were removed along w/ removal of
> related feature. e.g.
> 
> 1. io_bits=%u by commit 87161a2b0aed ("f2fs: deprecate io_bits")
> 2. whint_mode=%s by commit 930e2607638d ("f2fs: remove obsolete whint_mode")
> 
> Do we need to add these options handling back, and print "xxx options were
> deprecated" as we did in ("f2fs: kill heap-based allocation"), in order to
> avoid mount(......, "io_bits=%u" or "whint_mode=%s") command regression?

These are different from the generic lazytime option, and I haven't got any
complaint on this removal.

> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 867b147eb957..329f317e6f09 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -733,10 +733,8 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
>  			clear_opt(sbi, DISCARD);
>  			break;
>  		case Opt_noheap:
> -			set_opt(sbi, NOHEAP);
> -			break;
>  		case Opt_heap:
> -			clear_opt(sbi, NOHEAP);
> +			f2fs_warn(sbi, "heap/no_heap options were deprecated");
>  			break;
> 
> Thanks,
> 
> > 
> > > 
> > > Thanks,
> > > 
> > > > 
> > > > Thanks,
> > > > 
> > > > On 11/12, Jaegeuk Kim wrote:
> > > > > This reverts commit 54f43a10fa257ad4af02a1d157fefef6ebcfa7dc.
> > > > > 
> > > > > The above commit broke the lazytime mount, given
> > > > > 
> > > > > mount("/dev/vdb", "/mnt/test", "f2fs", 0, "lazytime");
> > > > > 
> > > > > CC: stable@vger.kernel.org # 6.11+
> > > > > Signed-off-by: Daniel Rosenberg <drosen@google.com>
> > > > > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > > > > ---
> > > > >    fs/f2fs/super.c | 10 ++++++++++
> > > > >    1 file changed, 10 insertions(+)
> > > > > 
> > > > > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > > > > index 49519439b770..35c4394e4fc6 100644
> > > > > --- a/fs/f2fs/super.c
> > > > > +++ b/fs/f2fs/super.c
> > > > > @@ -150,6 +150,8 @@ enum {
> > > > >    	Opt_mode,
> > > > >    	Opt_fault_injection,
> > > > >    	Opt_fault_type,
> > > > > +	Opt_lazytime,
> > > > > +	Opt_nolazytime,
> > > > >    	Opt_quota,
> > > > >    	Opt_noquota,
> > > > >    	Opt_usrquota,
> > > > > @@ -226,6 +228,8 @@ static match_table_t f2fs_tokens = {
> > > > >    	{Opt_mode, "mode=%s"},
> > > > >    	{Opt_fault_injection, "fault_injection=%u"},
> > > > >    	{Opt_fault_type, "fault_type=%u"},
> > > > > +	{Opt_lazytime, "lazytime"},
> > > > > +	{Opt_nolazytime, "nolazytime"},
> > > > >    	{Opt_quota, "quota"},
> > > > >    	{Opt_noquota, "noquota"},
> > > > >    	{Opt_usrquota, "usrquota"},
> > > > > @@ -922,6 +926,12 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
> > > > >    			f2fs_info(sbi, "fault_type options not supported");
> > > > >    			break;
> > > > >    #endif
> > > > > +		case Opt_lazytime:
> > > > > +			sb->s_flags |= SB_LAZYTIME;
> > > > > +			break;
> > > > > +		case Opt_nolazytime:
> > > > > +			sb->s_flags &= ~SB_LAZYTIME;
> > > > > +			break;
> > > > >    #ifdef CONFIG_QUOTA
> > > > >    		case Opt_quota:
> > > > >    		case Opt_usrquota:
> > > > > -- 
> > > > > 2.47.0.277.g8800431eea-goog
> > > > 
> > > > 
> > > > _______________________________________________
> > > > Linux-f2fs-devel mailing list
> > > > Linux-f2fs-devel@lists.sourceforge.net
> > > > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
