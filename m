Return-Path: <SRS0=DrP0=44=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9603BC10DCE
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 11 Mar 2020 03:07:59 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F2102146E;
	Wed, 11 Mar 2020 03:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="CZ301LaH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="gEvOZwUO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BlJ4Jbog"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F2102146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jBriv-0008RQ-4f; Wed, 11 Mar 2020 03:07:57 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1jBriu-0008RG-Jp
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 11 Mar 2020 03:07:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tMBn4+ShYN+kwM9Gk5hsAaxe2SLIKDpHi6K4u5QcQpo=; b=CZ301LaHPxV1/baqUq61aQ/Pb1
 H5TpFSmruS1nd02wMgl3dP0ZJq0vfOu57t290DLFj9iAiDAMyQS97GyqBKgS7ywh3HMlJDa1rro+V
 tOaNiL7Sy6k9IOoXg66RvqOcyvynK5PW3TGV++YdFr2cZKdLtqMPUd/PXMvPfhoP4Hw4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=tMBn4+ShYN+kwM9Gk5hsAaxe2SLIKDpHi6K4u5QcQpo=; b=gEvOZwUOzkFVaw3kme1w4lzjdb
 Kn23j+87WOYe2M/BlxN/4BemaBWxWJ50XPDAWS7TTSaI2QWQEKe09U8ZvmgAcf4X++PviAHdE5Pxp
 7llxv0AKIq/FsntTddBKql9zAjdR+LkZTbsYP7/7tR7dXnJLNZRwQm97Dio6OUmGzk6o=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jBriq-0088AW-W7
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 11 Mar 2020 03:07:56 +0000
Received: from localhost (unknown [104.132.1.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 551A32146E;
 Wed, 11 Mar 2020 03:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1583896062;
 bh=WJTonuZBHjT2gmhJN5zqDlZVwWoWWxEFvlg0bLkgcg0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BlJ4JbogrNYdixG1Oj5q7F5cAsJpnZceO2kKG3ORkTbq8cZKavuMhj2NhkmuqYyQq
 V9JFpe/ztou8PEXtRCplLa35qZdEIddXbPhDmhQAo2J5krlVS1tXv7Xoz/xlMAjDcV
 VQ45Hozkk46oYOKTfr2rmEA39J30tHA5TRCG9v9E=
Date: Tue, 10 Mar 2020 20:07:41 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <yuchao0@huawei.com>
Message-ID: <20200311030741.GA119277@google.com>
References: <20200310125009.12966-1-yuchao0@huawei.com>
 <20200310161515.GA1067@sol.localdomain>
 <4d8384b9-88fe-2a15-13ff-238d9fd4027a@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4d8384b9-88fe-2a15-13ff-238d9fd4027a@huawei.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-Headers-End: 1jBriq-0088AW-W7
Subject: Re: [f2fs-dev] [PATCH 1/5] f2fs: change default compression
 algorithm
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
Cc: Eric Biggers <ebiggers@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 03/11, Chao Yu wrote:
> On 2020/3/11 0:15, Eric Biggers wrote:
> > On Tue, Mar 10, 2020 at 08:50:05PM +0800, Chao Yu wrote:
> >> Use LZ4 as default compression algorithm, as compared to LZO, it shows
> >> almost the same compression ratio and much better decompression speed.
> >>
> >> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> >> ---
> >>  fs/f2fs/super.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> >> index db3a63f7c769..ebffe7aa08ee 100644
> >> --- a/fs/f2fs/super.c
> >> +++ b/fs/f2fs/super.c
> >> @@ -1577,7 +1577,7 @@ static void default_options(struct f2fs_sb_info *sbi)
> >>  	F2FS_OPTION(sbi).test_dummy_encryption = false;
> >>  	F2FS_OPTION(sbi).s_resuid = make_kuid(&init_user_ns, F2FS_DEF_RESUID);
> >>  	F2FS_OPTION(sbi).s_resgid = make_kgid(&init_user_ns, F2FS_DEF_RESGID);
> >> -	F2FS_OPTION(sbi).compress_algorithm = COMPRESS_LZO;
> >> +	F2FS_OPTION(sbi).compress_algorithm = COMPRESS_LZ4;
> >>  	F2FS_OPTION(sbi).compress_log_size = MIN_COMPRESS_LOG_SIZE;
> >>  	F2FS_OPTION(sbi).compress_ext_cnt = 0;
> >>  	F2FS_OPTION(sbi).bggc_mode = BGGC_MODE_ON;
> > 
> > This makes sense, but it's unclear to me why comparing the different compression
> > algorithms is happening just now, after support for both LZO and LZ4 was already
> > merged into mainline and now has to be supported forever.  During review months
> > ago, multiple people suggested that LZ4 is better than LZO, so there's not much
> > reason to support LZO at all.
> 
> Agreed,
> 
> Jaegeuk, thoughts?

Supporting LZO or whatever algorithms looks fine to me as long as kernel
supports without huge maintenance effort. I think it'd be good to provide
a way for users to compare several algorithms in whatever their ways.

And, unfortunately, I don't think we can remove LZO at this point, even for -rc.

Thanks,

> 
> Let me remove lzo if you have no objection on this.
> 
> Thanks,
> 
> > 
> > - Eric
> > .
> > 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
