Return-Path: <SRS0=I8Ey=OS=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D47C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 28 Sep 2021 19:08:53 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DB18611CE
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 28 Sep 2021 19:08:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0DB18611CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mVITE-0002TN-MP; Tue, 28 Sep 2021 19:08:52 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <jaegeuk@kernel.org>) id 1mVITC-0002TF-JW
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 28 Sep 2021 19:08:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1zZBRcNp6R/5e7Ka0izNUg/L0w2AqI3jVJVJjpuRZhQ=; b=f8Ow2e1aBFkciqGdQnl9BPOGz2
 TYr+ET75A1apOF4wLeTGqddpnYGwucLQFicRJGKibwetZOkuymLjdryF2wm8x1VGQt2ZnWL7AGWdw
 dgNQmCmC08Zo8hbuxzXWeYIdx0O9Icl6L+axKNAeoTkSjUVEUSLF9ipYJsLU3mRSpS/I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=1zZBRcNp6R/5e7Ka0izNUg/L0w2AqI3jVJVJjpuRZhQ=; b=TQ7aAz+ZGVcP61OpamxJ38hgCq
 ipQutYE1oI/bIf5j8JfJH27/3ZBB+zm5fYT9csuQEPtLC50rgEVL5sLK+4jgzOxBtXBR1PxxXws4n
 OM+O1lS5KqY8xicxVd5jXvK83kn2G01bxeONz09M5FVGhkeicwgaJ7ae28mfWGYtz0JE=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mVITA-00016y-9H
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 28 Sep 2021 19:08:50 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id B855C61209;
 Tue, 28 Sep 2021 19:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632856122;
 bh=2K5H+VF6gLx+Fi8TsMHRqLCex+KQvcGxIT83dm37rkU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Syfi43I29lSjgkv3AfY6gkAmfGDvRSiXXK0F8d4qGux2X440jNi7hsh47vUOLCrJc
 opQBq2NoV3v+4dPdIosSMsS9YkGWbjCwqWzZuf5xNzIssqJn0lUNivVEELMq4XPKB2
 EYJ/pPeBcw5ZQlwHB4iiQWmzofB2ER2H+tp5/IgpBq2D7NKY+rGtMWsmMLhTWQ3RTK
 M9XRghk2aCk55q8gtmzroi8W4wHwK6N7B0/hQWJ8DGTwGe4ni/nOQKaSrQD+F02/Xj
 JDiDj6gJel/GJB/aguto1CLUb0yOnZKOGJ4oy1FkQmLKo3bu5LGz12bjdp+PUhERPG
 OlXAuRg7Mzfiw==
Date: Tue, 28 Sep 2021 12:08:41 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Message-ID: <YVNoObi/kRt5OMFz@google.com>
References: <20210927060905.68318-1-changfengnan@vivo.com>
 <6c114c4d-7e02-9d4e-7308-0810aa31339d@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6c114c4d-7e02-9d4e-7308-0810aa31339d@kernel.org>
X-Headers-End: 1mVITA-00016y-9H
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix whint_mode mount option error
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
Cc: tanghuan <tanghuan@vivo.com>, Fengnan Chang <changfengnan@vivo.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 09/28, Chao Yu wrote:
> On 2021/9/27 14:09, Fengnan Chang wrote:
> > When mount with whint_mode option, it doesn't work, Fix it.
> > Fixes: d0b9e42ab615 (f2fs: introduce inmem curseg)
> 
> Thanks for the patch, it looks Keoseong Park has submitted the same
> fix patch a little bit earlier....
> 
> I guess we need to select one of your patches, and merge Singed-off
> and Reported tags from another one.

Merged with SOB and Reported-by.

> 
> Thanks,
> 
> > 
> > Reported-by: tanghuan <tanghuan@vivo.com>
> > Signed-off-by: Fengnan Chang <changfengnan@vivo.com>
> > ---
> >   fs/f2fs/super.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > index 78ebc306ee2b..86eeb019cc52 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -1292,7 +1292,7 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
> >   	/* Not pass down write hints if the number of active logs is lesser
> >   	 * than NR_CURSEG_PERSIST_TYPE.
> >   	 */
> > -	if (F2FS_OPTION(sbi).active_logs != NR_CURSEG_TYPE)
> > +	if (F2FS_OPTION(sbi).active_logs != NR_CURSEG_PERSIST_TYPE)
> >   		F2FS_OPTION(sbi).whint_mode = WHINT_MODE_OFF;
> >   	if (f2fs_sb_has_readonly(sbi) && !f2fs_readonly(sbi->sb)) {
> > 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
