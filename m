Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 372A4C54EE9
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Sep 2022 18:12:19 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1obQgK-0005fC-MH;
	Thu, 22 Sep 2022 18:12:17 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1obQg5-0005eh-5Z
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Sep 2022 18:12:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=L2kP0y3O811B3J1y6LUqlZ72PofpZz/Xu4zk9bziClw=; b=Gr0c3D39+9dccSszz9q1crJpE4
 UpTPsQNEeeNj45Mz66Mxj+FK8BIp2Pmwz+MLpZF07QKSPQynlp3dYlMM7N1/UJED5EGttIPOPvOZ/
 gWME106FElPsgU+X+lFAUYkkjAMFSY+aePVQDtvL18h1Qkv4X+c3xaa9F36st2tB9C+I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=L2kP0y3O811B3J1y6LUqlZ72PofpZz/Xu4zk9bziClw=; b=MIwFoVWp/irf8h/PdvtOzgIKfo
 kEy3kxVenJkzembCkoEUHT6/zUxqd5KE/k1WZV/MDmoXH4/OsF2eM4vT+xIl12ldLNJdXEiPJfIOE
 g/A1eTMnZ27akZL0O1XAIb51e439KEa2tTSMDxDRX5FFZn1ad+98PPb7aOeUtxO5G2jg=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1obQft-0003pX-RW for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Sep 2022 18:11:55 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 922B2B80D3A
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 22 Sep 2022 18:11:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44466C433D6;
 Thu, 22 Sep 2022 18:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1663870302;
 bh=qqEhrzEMHMuwKfPqoDEHNAeIHePY6satB6tP61stR18=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=irPy6i+FAzabvCDnime1nOYTYFtzdZun9SnzHmQtZ/mfdD6MC3mYJM2dJBlLdyWXa
 1inDw33YQoTM1tVBwb56FTtdUndZvXItNziESWbcVhI1uammkrfV7DuY55cAuwZPgZ
 pBe9yHGabn26IpnOwdCJ7DRDIwjXewlfveQVY5oRzqlIwthnBKqB9o1jv4tSTYmeMS
 Eg1WLnnwqFUMI406C0djMwph4w+6F22vfmKZXfh34K7A9gBvvCPmeZxs5TzBRdmoGL
 GpCuAV3Iu+UNd/8EDKBWlXNAU0R9vAsqVUm2W/7KjyBNzAKFYJRHkmBmej6//0xHA9
 kiFTcexazCscw==
Date: Thu, 22 Sep 2022 11:11:40 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Message-ID: <YyylXIEhaearlfEf@google.com>
References: <20220913074812.2300528-1-chao@kernel.org>
 <44a1eca6-568b-a752-ef01-06de489eb466@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <44a1eca6-568b-a752-ef01-06de489eb466@kernel.org>
X-Headers-End: 1obQft-0003pX-RW
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: fix to detect corrupted meta ino
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

I modified a bit.

https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev-test&id=a9a1592fa175baaaae43f54f175a972757c47919

Thanks,

On 09/22, Chao Yu wrote:
> Ping,
> 
> On 2022/9/13 15:48, Chao Yu wrote:
> > It is possible that ino of dirent or orphan inode is corrupted in a
> > fuzzed image, occasionally, if corrupted ino is equal to meta ino:
> > meta_ino, node_ino or compress_ino, caller of f2fs_iget() from below
> > call paths will get meta inode directly, it's not allowed, let's
> > add sanity check to detect such cases.
> > 
> > case #1
> > - recover_dentry
> >   - __f2fs_find_entry
> >   - f2fs_iget_retry
> > 
> > case #2
> > - recover_orphan_inode
> >   - f2fs_iget_retry
> > 
> > Signed-off-by: Chao Yu <chao@kernel.org>
> > ---
> > v3:
> > - update commit title/message
> > - change logic inside f2fs_iget() rather than its caller
> >   fs/f2fs/inode.c | 25 ++++++++++++++++++-------
> >   1 file changed, 18 insertions(+), 7 deletions(-)
> > 
> > diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> > index cde0a3dc80c3..1baac6056733 100644
> > --- a/fs/f2fs/inode.c
> > +++ b/fs/f2fs/inode.c
> > @@ -487,6 +487,12 @@ static int do_read_inode(struct inode *inode)
> >   	return 0;
> >   }
> > +static bool is_meta_ino(struct f2fs_sb_info *sbi, unsigned int ino)
> > +{
> > +	return ino == F2FS_NODE_INO(sbi) || ino == F2FS_META_INO(sbi) ||
> > +		ino == F2FS_COMPRESS_INO(sbi);
> > +}
> > +
> >   struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
> >   {
> >   	struct f2fs_sb_info *sbi = F2FS_SB(sb);
> > @@ -497,17 +503,22 @@ struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
> >   	if (!inode)
> >   		return ERR_PTR(-ENOMEM);
> > +	if (is_meta_ino(sbi, ino)) {
> > +		if (!(inode->i_state & I_NEW)) {
> > +			f2fs_err(sbi, "detect corrupted inode no:%lu, run fsck to repair", ino);
> > +			set_sbi_flag(sbi, SBI_NEED_FSCK);
> > +			ret = -EFSCORRUPTED;
> > +			trace_f2fs_iget_exit(inode, ret);
> > +			iput(inode);
> > +			return ERR_PTR(ret);
> > +		}
> > +		goto make_now;
> > +	}
> > +
> >   	if (!(inode->i_state & I_NEW)) {
> >   		trace_f2fs_iget(inode);
> >   		return inode;
> >   	}
> > -	if (ino == F2FS_NODE_INO(sbi) || ino == F2FS_META_INO(sbi))
> > -		goto make_now;
> > -
> > -#ifdef CONFIG_F2FS_FS_COMPRESSION
> > -	if (ino == F2FS_COMPRESS_INO(sbi))
> > -		goto make_now;
> > -#endif
> >   	ret = do_read_inode(inode);
> >   	if (ret)


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
