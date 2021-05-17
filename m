Return-Path: <SRS0=cGqQ=KM=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E026C433B4
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 17 May 2021 21:18:56 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 006406112D;
	Mon, 17 May 2021 21:18:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 006406112D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1likdZ-0000n6-Q1; Mon, 17 May 2021 21:18:53 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <ebiggers@kernel.org>) id 1likdY-0000mz-Hh
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 17 May 2021 21:18:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=km1Y85x5gTx/B32ydzOzrSuUsdfzsl4DLtv+d7wqBUU=; b=T3SXfx+gz3V06NWCWCutyk3V2h
 2n6x8RnKBT4CXS0zXPXySPkCkurtgAMd94XaD+B0CWAXFErQgIjgkKeqsE2fRSaepH8eLZDkcfzwL
 /0iDM3KEjMP3ZYdDwSl6wsYpU3uyHHmq4T4FGhWjkT98rsQzbkaSEs2DZxrcUDUDshyQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=km1Y85x5gTx/B32ydzOzrSuUsdfzsl4DLtv+d7wqBUU=; b=AUfLjFWcwMqpPM6zIJdeK7L8Wo
 seSKvmEc0WpLztRj6YFUZ/TG/GmBYI2sJY2MuUDyQha/fO8xrND3vx84/RtXKv/bJrG3Ragd6HW7+
 e36I4beyL5shOZs/eDkZrvcQyy6HLyPre/T6iN7spYhUVP/d7K/AFsbfjTpqjwcPibEo=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1likdP-00BtrK-3l
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 17 May 2021 21:18:53 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 73D2160FF3;
 Mon, 17 May 2021 21:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621286317;
 bh=cmzlezJXdjoNUrS+2SMZYPVzmK28Eak6fBQFREiwFUY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=t+hQ40v5CIHrNoldcMPt6/SqZNvPqWHm2j3PRKoTBhD4yewkzptsruEypxwX9ypwG
 BFRZVIItEW9AOjShZ8BA4wujqE88k6iGZLs9uTjWbaojNhJtEzaiAZAXDJfvgLEbQ3
 QfK8clpr8mDDl1Um6cthoAWlhrSCpDQIV6wDIt+q6AHV9d16fiHCHLjNPsIc4VhlOF
 VoUWOSgrqdtLJZ5Dv8eTJJiTo/DmfcamUeMOaXADyyyQ9KvIa+PFEAlcMQM2xsCIAB
 hPVvuHQc2WU2da2L7c8KbBOxoohieham/udvayU379SWuKzraoHG/igcjZTFwQIZDd
 4h+vPClyHRlUg==
Date: Mon, 17 May 2021 14:18:36 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Chao Yu <yuchao0@huawei.com>
Message-ID: <YKLdrGV9utVHDuE/@gmail.com>
References: <20210507094455.1695-1-changfengnan@vivo.com>
 <YJlUpHJLONlORWWl@google.com>
 <000b01d74656$518e96f0$f4abc4d0$@vivo.com>
 <YJr8PuZlOBqb+Qv1@google.com>
 <15efccda-b8e3-80bc-13b7-b2d62a1cac15@huawei.com>
 <YJ2Xflx6eF2P89Km@gmail.com>
 <7f6b707c-dd45-21fe-e1f7-624fafcda3d3@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7f6b707c-dd45-21fe-e1f7-624fafcda3d3@huawei.com>
X-Headers-End: 1likdP-00BtrK-3l
Subject: Re: [f2fs-dev] =?utf-8?b?562U5aSNOiBbUEFUQ0ggdjRdIGYyZnM6IGNvbXBy?=
 =?utf-8?q?ess=3A_avoid_unnecessary_check_in_f2fs=5Fprepare=5Fcompress=5Fo?=
 =?utf-8?q?verwrite?=
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, changfengnan@vivo.com,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, May 14, 2021 at 09:15:54AM +0800, Chao Yu wrote:
> On 2021/5/14 5:17, Eric Biggers wrote:
> > On Wed, May 12, 2021 at 09:52:19AM +0800, Chao Yu wrote:
> > > On 2021/5/12 5:50, Jaegeuk Kim wrote:
> > > > On 05/11, changfengnan@vivo.com wrote:
> > > > > Hi Jaegeuk:
> > > > > 
> > > > > If there're existing clusters beyond i_size, may cause data corruption, but
> > > > > will this happen in normal? maybe some error can cause this, if i_size is
> > > > > error the data beyond size still can't handle properly.  Is there normal
> > > > > case can casue existing clusters beyond i_size?
> > > > 
> > > > We don't have a rule to sync between i_size and i_blocks.
> > > 
> > > I can't image a case that compressed cluster may cross filesize, it looks it's
> > > a bug if that happened, but I'm not sure I have considered all cases. So, I
> > > prefer to add a check condition as below, then testing w/ xfstest/por_fsstress
> > > for a while.
> > > 
> > > Subject: [PATCH] f2fs: compress: compressed cluster should not cross i_size
> > > 
> > > ---
> > >   fs/f2fs/data.c | 2 ++
> > >   1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > > index 06d1e58d3882..9acca358d578 100644
> > > --- a/fs/f2fs/data.c
> > > +++ b/fs/f2fs/data.c
> > > @@ -3325,6 +3325,8 @@ static int f2fs_write_begin(struct file *file, struct address_space *mapping,
> > >   			err = ret;
> > >   			goto fail;
> > >   		} else if (ret) {
> > > +			f2fs_bug_on(sbi, index >=
> > > +				DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE));
> > >   			return 0;
> > >   		}
> > >   	}
> > 
> > If a file has both fs-verity and compression enabled, it can have compressed
> > clusters past i_size.
> 
> Correct, any other case we missed for a writable file? let us know.
> 
> Thanks,
> 

Well, files become read-only once fs-verity is enabled on them, but that happens
after the blocks past i_size are written in the first place.  That part still
uses ->write_begin(), ->write_end(), ->writepages(), etc.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
